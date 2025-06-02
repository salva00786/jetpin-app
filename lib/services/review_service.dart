// lib/services/review_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/review.dart';
import '../models/reply.dart';
import '../utils/premium_manager.dart';
import '../ads/ad_manager.dart';
import '../services/notification_service.dart';

import 'package:jetpin_app/l10n/app_localizations.dart';

class ReviewService {
  final AdManager _adManager;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const int VERIFIED_REVIEWER_THRESHOLD = 10;

  ReviewService({AdManager? adManager}) : _adManager = adManager ?? AdManager();

  Future<User?> ensureUserSignedIn() async {
    User? user = _auth.currentUser;
    if (user == null) {
      try {
        final UserCredential cred = await _auth.signInAnonymously();
        user = cred.user;
        print('🔐 Autenticazione anonima eseguita da ReviewService: ${user?.uid}');
        // Assicurati che auth_service._ensureUserDocumentExists venga chiamato
        // o una logica simile per creare il documento utente per gli utenti anonimi.
        // Se si usa auth_service.signInAnonymously() questa logica è già inclusa lì.
      } catch (e) {
        print('❌ Errore login anonimo da ReviewService: $e');
        return null;
      }
    }
    return user;
  }

  Future<(bool, int)> loadUserStatus() async {
    final User? user = await ensureUserSignedIn();
    if (user == null) return (false, 0);

    final bool isPremium = await PremiumManager.isPremium();
    final int slots = await PremiumManager.getExtraFreeSlots(user.uid);
    return (isPremium, slots);
  }

  void unlockViaVideo({
    required BuildContext context,
    required String uid,
    required Function(int newSlots) onSlotsUpdated,
    required Function(String message) onError,
    required Function() onSuccess,
  }) {
    _adManager.showRewardedAd(
      context: context,
      onReward: () async {
        try {
          await PremiumManager.addExtraSlots(uid, 3);
          final int updatedSlots = await PremiumManager.getExtraFreeSlots(uid);
          onSlotsUpdated(updatedSlots);
          onSuccess();
        } catch (e) {
          print('Errore durante l_aggiornamento degli slot dopo reward: $e');
          onError("Errore durante l'aggiornamento degli slot");
        }
      },
       onAdFailedToLoad: (message) {
         print('Video con premio non caricato: $message');
         onError(S.of(context)?.rewardVideoLoadError ?? "Errore caricamento video");
       },
       onAdFailedToShow: (message) {
         print('Video con premio non mostrato: $message');
         onError(S.of(context)?.rewardVideoShowError ?? "Errore visualizzazione video");
       }
    );
  }

  Future<String?> saveReview({
    required BuildContext context,
    required Review review,
    required bool isPremium,
    required int extraSlots,
    required Function(int updatedSlots) onSlotConsumed,
  }) async {
    final S localizations = S.of(context)!;

    print("[ReviewService.saveReview] Tentativo di salvataggio per review.userId: '${review.userId}'");
    if (review.userId.isEmpty || review.userId == 'anonymous') {
      print("[ReviewService.saveReview] ATTENZIONE: review.userId è '${review.userId}'.");
    }

    final DocumentReference userRef = _firestore.collection('users').doc(review.userId);

    try {
      DocumentSnapshot userDoc = await userRef.get();
      print("[ReviewService.saveReview] Documento utente (users/${review.userId}) esiste? ${userDoc.exists}");
      if (!userDoc.exists) {
          print("[ReviewService.saveReview] ERRORE CRITICO: Il documento per l'utente ${review.userId} non esiste in Firestore.");
          // Questo potrebbe essere un punto di fallimento se l'ID utente non è valido o il doc non è stato creato.
      }

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      int currentReviewCount = userData?['reviewCount'] as int? ?? 0;
      bool isAlreadyVerified = userData?['isVerifiedReviewer'] as bool? ?? false;
      print("[ReviewService.saveReview] Dati utente: reviewCount=$currentReviewCount, isVerified=$isAlreadyVerified, extraSlots=$extraSlots, isPremium=$isPremium");

      final int totalLimit = 10 + extraSlots;
      print("[ReviewService.saveReview] Limite recensioni calcolato: $totalLimit");

      if (!isPremium && currentReviewCount >= totalLimit) {
        print("[ReviewService.saveReview] Limite recensioni raggiunto.");
        return 'LIMIT_REACHED';
      }

      print("[ReviewService.saveReview] Tentativo di aggiungere recensione a Firestore...");
      // Questa è l'operazione che stava fallendo con PERMISSION_DENIED
      await _firestore.collection('reviews').add(review.toMap());
      print("[ReviewService.saveReview] Recensione aggiunta. Tentativo di aggiornare userRef...");

      await userRef.update({
        'reviewCount': FieldValue.increment(1),
        'lastUpdatedAt': FieldValue.serverTimestamp()
      });
      print("[ReviewService.saveReview] userRef aggiornato (reviewCount e lastUpdatedAt).");

      currentReviewCount++;

      if (!isAlreadyVerified && currentReviewCount >= VERIFIED_REVIEWER_THRESHOLD) {
        await userRef.update({
          'isVerifiedReviewer': true,
          'lastUpdatedAt': FieldValue.serverTimestamp()
        });
        print("🏆 Utente ${review.userId} è ora un Recensore Verificato!");
      }

      if (!isPremium && currentReviewCount > 10 && extraSlots > 0) {
        int slotsUsedPriorToThisReview = (currentReviewCount -1) - 10;
        if(slotsUsedPriorToThisReview < extraSlots) {
             await PremiumManager.useExtraSlot(review.userId);
             final int remaining = (extraSlots -1).clamp(0,9999);
             onSlotConsumed(remaining);
             print("[ReviewService.saveReview] Slot extra consumato.");
        }
      }

      final reviewsLeft = totalLimit - currentReviewCount;
      if (!isPremium && reviewsLeft <= 2 && reviewsLeft > 0) {
        await NotificationService.showSimpleNotification(
          id: 2001,
          title: localizations.reviewLimitWarningTitle,
          body: localizations.reviewLimitWarningBody(reviewsLeft),
        );
      } else if (!isPremium && reviewsLeft == 0 && totalLimit > 0) {
        await NotificationService.showSimpleNotification(
          id: 2002,
          title: localizations.reviewLimitReachedTitle,
          body: localizations.reviewLimitReachedBody,
        );
      }
      print("[ReviewService.saveReview] Salvataggio completato con successo.");
      return null; // Successo
    } catch (e, stackTrace) {
      print("‼️ Errore CRITICO durante il salvataggio della recensione per userId '${review.userId}':");
      print("   Eccezione: $e");
      print("   StackTrace: $stackTrace");
      return localizations.errorSavingReview;
    }
  }

  Future<bool> updateReview(String reviewId, Review reviewToUpdate, BuildContext context) async {
    try {
      Map<String, dynamic> updatedData = {
        'airline': reviewToUpdate.airline,
        'airlineIcao': reviewToUpdate.airlineIcao,
        'flightNumber': reviewToUpdate.flightNumber,
        'rating': reviewToUpdate.rating,
        'comment': reviewToUpdate.comment,
        'userName': reviewToUpdate.userName,
        'lastEditedAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('reviews').doc(reviewId).update(updatedData);
      print("Recensione $reviewId aggiornata con successo.");
      return true;
    } catch (e, stackTrace) {
      print("Errore durante l'aggiornamento della recensione $reviewId: $e");
      print("StackTrace updateReview: $stackTrace");
      return false;
    }
  }

  Future<bool> deleteReview(String reviewId, String userId, BuildContext context) async {
    final DocumentReference reviewRef = _firestore.collection('reviews').doc(reviewId);
    final DocumentReference userRef = _firestore.collection('users').doc(userId);
    try {
      await _firestore.runTransaction((transaction) async {
        transaction.delete(reviewRef);
        transaction.update(userRef, {
          'reviewCount': FieldValue.increment(-1),
          'lastUpdatedAt': FieldValue.serverTimestamp()
          });
      });
      print("Recensione $reviewId eliminata e reviewCount per l'utente $userId decrementato.");
      return true;
    } catch (e) {
      print("Errore durante l'eliminazione della recensione $reviewId o l'aggiornamento del conteggio: $e");
      return false;
    }
  }

  Future<void> addReply({
    required String reviewId,
    required String reviewOwnerId,
    required String replyText,
    required S localizations,
  }) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("Utente non autenticato. Impossibile aggiungere una risposta.");
    }
    if (replyText.trim().isEmpty) {
      throw Exception("Il testo della risposta non può essere vuoto.");
    }
    final String replierId = currentUser.uid;
    final String replierName = currentUser.displayName ?? localizations.anonymousUser;
    final Map<String, dynamic> replyData = {
      'reviewId': reviewId,
      'reviewOwnerId': reviewOwnerId,
      'replierId': replierId,
      'replierName': replierName,
      'replyText': replyText.trim(),
      'timestamp': FieldValue.serverTimestamp(), // Gestito dal server
      'lastEditedAt': null, // Inizialmente null
    };
    try {
      await _firestore.collection('reviews').doc(reviewId).collection('replies').add(replyData);
      print("Risposta aggiunta con successo alla recensione $reviewId");
    } catch (e) {
      print("Errore durante l'aggiunta della risposta alla recensione $reviewId: $e");
      throw Exception("Errore durante l'invio della risposta: $e");
    }
  }

  Stream<List<Reply>> getRepliesForReview(String reviewId) {
    return _firestore
        .collection('reviews')
        .doc(reviewId)
        .collection('replies')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      try {
        return snapshot.docs.map((doc) {
          return Reply.fromMap(doc.data(), doc.id);
        }).toList();
      } catch (e) {
        print("Errore durante la mappatura delle risposte: $e");
        return [];
      }
    });
  }

  Future<bool> incrementHelpfulCount(String reviewId) async {
    if (_auth.currentUser == null) {
      print("Utente non autenticato. Impossibile incrementare helpfulCount.");
      return false;
    }
    final DocumentReference reviewRef = _firestore.collection('reviews').doc(reviewId);
    try {
      await reviewRef.update({'helpfulCount': FieldValue.increment(1)});
      print("Helpful count incrementato per la recensione $reviewId.");
      return true;
    } catch (e) {
      print("Errore durante l'incremento di helpfulCount per la recensione $reviewId: $e");
      return false;
    }
  }

  Future<bool> updateReply({
    required String reviewId,
    required String replyId,
    required String newReplyText,
  }) async {
     if (_auth.currentUser == null) {
      print("Utente non autenticato. Impossibile modificare la risposta.");
      return false;
    }
    if (newReplyText.trim().isEmpty) {
      print("Il testo della risposta non può essere vuoto per l'aggiornamento.");
      return false;
    }
    final DocumentReference replyRef = _firestore.collection('reviews').doc(reviewId).collection('replies').doc(replyId);
    try {
      await replyRef.update({
        'replyText': newReplyText.trim(),
        'lastEditedAt': FieldValue.serverTimestamp(),
      });
      print("Risposta $replyId aggiornata con successo per la recensione $reviewId.");
      return true;
    } catch (e) {
      print("Errore durante l'aggiornamento della risposta $replyId: $e");
      return false;
    }
  }

  Future<bool> deleteReply({
    required String reviewId,
    required String replyId,
  }) async {
    if (_auth.currentUser == null) {
      print("Utente non autenticato. Impossibile eliminare la risposta.");
      return false;
    }
    final DocumentReference replyRef = _firestore.collection('reviews').doc(reviewId).collection('replies').doc(replyId);
    try {
      await replyRef.delete();
      print("Risposta $replyId eliminata con successo per la recensione $reviewId.");
      return true;
    } catch (e) {
      print("Errore durante l'eliminazione della risposta $replyId: $e");
      return false;
    }
  }
}
