// Copyright 2025 Salvo00786 Jetpin. Tutti i diritti riservati.
// Per informazioni sulla licenza, vedere il file LICENSE.

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Non ci sono stringhe UI da localizzare direttamente in questo file.
// Eventuali messaggi mostrati all'utente a seguito di queste operazioni
// (es. "Prova attivata", "Backup completato") dovrebbero essere gestiti
// e localizzati nel codice chiamante (UI).

class PremiumManager {
  static const String _isPremiumKey = 'isPremium'; // Chiave per SharedPreferences
  static const String _lastBackupKey = 'lastBackupDate'; // Chiave per SharedPreferences
  static Timer? _autoSyncTimer;

  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  static CollectionReference get _usersCollection => _firestore.collection('users');
  static CollectionReference get _userBackupsCollection => _firestore.collection('user_backups');

  /// Controlla lo stato premium locale (da SharedPreferences).
  static Future<bool> isPremium() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPremiumKey) ?? false;
  }

  /// Imposta lo stato premium locale (in SharedPreferences).
  static Future<void> setPremium(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, value);
  }

  /// Sincronizza lo stato premium dal cloud (Firestore) a SharedPreferences.
  static Future<void> syncPremiumFromCloud(String uid) async {
    if (uid.isEmpty) {
      print('[PremiumManager] UID utente non valido per syncPremiumFromCloud.');
      return;
    }
    try {
      final DocumentSnapshot userDoc = await _usersCollection.doc(uid).get().timeout(const Duration(seconds: 7));
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null) {
        bool isCurrentlyPremium = userData['isPremium'] == true;
        DateTime? trialStartDate;
        if (userData['trialStartDate'] is Timestamp) {
          trialStartDate = (userData['trialStartDate'] as Timestamp).toDate();
        }

        bool isTrialActive = false;
        if (trialStartDate != null && userData['hasUsedTrial'] == true) {
          final trialEndDate = trialStartDate.add(const Duration(days: 7));
          isTrialActive = DateTime.now().isBefore(trialEndDate);
        }

        // L'utente è considerato premium se ha un abbonamento attivo o una prova attiva.
        bool finalPremiumStatus = isCurrentlyPremium || isTrialActive;
        await setPremium(finalPremiumStatus);
        print('[PremiumManager] Stato Premium per $uid aggiornato da cloud: $finalPremiumStatus (Premiumeffettivo: $isCurrentlyPremium, ProvaAttiva: $isTrialActive)');
      } else {
        // Se il documento utente non esiste, considera l'utente non premium.
        await setPremium(false);
        print('[PremiumManager] Documento utente non trovato per $uid. Impostato Premium a false.');
      }
    } catch (e) {
      print('❌ Errore in syncPremiumFromCloud per $uid: $e. Stato Premium locale non modificato.');
      // Non modificare lo stato locale in caso di errore di rete, per evitare di disattivare premium erroneamente.
    }
  }

  /// Avvia la sincronizzazione automatica periodica dello stato premium.
  static void startPremiumAutoSync(String uid, {Duration interval = const Duration(minutes: 15)}) {
    if (uid.isEmpty) {
      print('[PremiumManager] UID utente non valido per startPremiumAutoSync.');
      return;
    }
    _autoSyncTimer?.cancel(); // Cancella timer esistenti
    _autoSyncTimer = Timer.periodic(interval, (_) async {
      print('[PremiumManager] Esecuzione AutoSync per $uid...');
      await syncPremiumFromCloud(uid);
    });
    print('[PremiumManager] AutoSync Premium avviato per $uid ogni ${interval.inMinutes} minuti.');
  }

  /// Ferma la sincronizzazione automatica.
  static void stopPremiumAutoSync() {
    _autoSyncTimer?.cancel();
    _autoSyncTimer = null;
    print('[PremiumManager] AutoSync Premium fermato.');
  }

  /// Forza un aggiornamento immediato dello stato premium.
  static Future<void> forceRefresh(String uid) async {
    if (uid.isEmpty) return;
    print('[PremiumManager] Forzatura aggiornamento stato Premium per $uid...');
    await syncPremiumFromCloud(uid);
    // Il backup potrebbe essere opzionale qui o condizionato,
    // per non farlo troppo frequentemente.
    // await backupUserDataToCloud(uid); // Valutare necessità se chiamare sempre
  }

  /// Esegue il backup dei dati utente su cloud.
  static Future<bool> backupUserDataToCloud(String uid) async {
    if (uid.isEmpty) return false;
    final DateTime now = DateTime.now();
    final Map<String, dynamic> backupData = {
      'backupDate': Timestamp.fromDate(now),
      // Questa nota è interna. Se fosse mostrata all'utente, andrebbe localizzata
      // o resa una chiave di localizzazione, oppure rimossa se non necessaria.
      'note': 'Backup automatico dei dati utente.',
      'version': '1.0.0', // Esempio: versione dell'app o formato backup
    };

    try {
      await _userBackupsCollection.doc(uid).set(backupData, SetOptions(merge: true));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastBackupKey, now.toIso8601String());
      print('✅ Backup dati per $uid eseguito con successo alle $now.');
      return true;
    } catch (e) {
      print('❌ Errore durante il backup dei dati per $uid: $e');
      return false;
    }
  }

  /// Recupera la data dell'ultimo backup.
  static Future<DateTime?> getLastBackupDate(String uid) async {
    if (uid.isEmpty) return null;
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? localBackupDateStr = prefs.getString(_lastBackupKey);
      if (localBackupDateStr != null) {
        return DateTime.tryParse(localBackupDateStr);
      }

      final DocumentSnapshot backupDoc = await _userBackupsCollection.doc(uid).get();
      final Map<String, dynamic>? backupData = backupDoc.data() as Map<String, dynamic>?;
      if (backupData != null && backupData['backupDate'] is Timestamp) {
        final DateTime cloudBackupDate = (backupData['backupDate'] as Timestamp).toDate();
        await prefs.setString(_lastBackupKey, cloudBackupDate.toIso8601String());
        return cloudBackupDate;
      }
    } catch (e) {
      print('❌ Errore in getLastBackupDate per $uid: $e');
    }
    return null;
  }

  /// Controlla se mostrare il modale "smart" per l'upgrade a Premium.
  static Future<bool> shouldShowSmartModal() async {
    final prefs = await SharedPreferences.getInstance();
    final int lastShownMillis = prefs.getInt('smartModalLastShown') ?? 0;
    final DateTime lastShownDate = DateTime.fromMillisecondsSinceEpoch(lastShownMillis);
    return DateTime.now().difference(lastShownDate).inDays > 3;
  }

  /// Registra che il modale "smart" è stato mostrato.
  static Future<void> setSmartModalShownNow() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('smartModalLastShown', DateTime.now().millisecondsSinceEpoch);
  }

  /// Attiva la prova gratuita di 7 giorni per l'utente.
  static Future<bool> activateFreeTrial(String uid) async {
    if (uid.isEmpty) return false;
    try {
      final DocumentReference userDocRef = _usersCollection.doc(uid);
      final DocumentSnapshot userDoc = await userDocRef.get().timeout(const Duration(seconds: 5));
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData?['hasUsedTrial'] == true) {
        print('[PremiumManager] L\'utente $uid ha già usato la prova gratuita.');
        return false; 
      }

      await userDocRef.set({
        'hasUsedTrial': true,
        'trialStartDate': Timestamp.fromDate(DateTime.now()),
      }, SetOptions(merge: true));

      await setPremium(true);
      print('🎉 Prova gratuita attivata per $uid. Lo stato premium locale è true.');
      return true;
    } catch (e) {
      print('❌ Errore durante l_attivazione della prova gratuita per $uid: $e');
      return false;
    }
  }

  /// Recupera i dati relativi allo stato premium/trial dell'utente da Firestore.
  static Future<Map<String, dynamic>?> getUserPremiumData({required String uid}) async {
    if (uid.isEmpty) return null;
    try {
      final DocumentSnapshot userDoc = await _usersCollection.doc(uid).get().timeout(const Duration(seconds: 5));
      return userDoc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('❌ Errore durante getUserPremiumData per $uid: $e');
      return null;
    }
  }

  /// Recupera il numero di slot gratuiti extra per le recensioni.
  static Future<int> getExtraFreeSlots(String uid) async {
    if (uid.isEmpty) return 0;
    try {
      final DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      return userData?['extraFreeSlots'] as int? ?? 0;
    } catch (e) {
      print('❌ Errore in getExtraFreeSlots per $uid: $e');
      return 0;
    }
  }

  /// Aggiunge slot gratuiti extra all'utente.
  static Future<void> addExtraSlots(String uid, int count) async {
    if (uid.isEmpty || count <= 0) return;
    try {
      final DocumentReference userDocRef = _usersCollection.doc(uid); // Definita qui per il blocco try
      await userDocRef.update({'extraFreeSlots': FieldValue.increment(count)});
      print('✅ Aggiunti $count slot extra a $uid.');
    } catch (e) {
      print('❌ Errore in addExtraSlots per $uid (provando ad aggiungere $count): $e. Tentativo con set.');
      try {
           await _usersCollection.doc(uid).set({'extraFreeSlots': FieldValue.increment(count)}, SetOptions(merge: true));
           print('✅ Aggiunti $count slot extra a $uid tramite set(merge:true).');
      } catch (e2) {
        print('❌ Errore definitivo in addExtraSlots per $uid: $e2');
      }
    }
  }

  /// Consuma uno slot gratuito extra.
  static Future<void> useExtraSlot(String uid) async {
    if (uid.isEmpty) return;
    try {
      final DocumentReference userDocRef = _usersCollection.doc(uid);
      final DocumentSnapshot userDoc = await userDocRef.get();
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      final int currentSlots = userData?['extraFreeSlots'] as int? ?? 0;

      if (currentSlots > 0) {
        await userDocRef.update({'extraFreeSlots': FieldValue.increment(-1)});
        print('🔓 Slot extra usato per $uid, ne restano: ${currentSlots - 1}');
      } else {
        print('ℹ️ Nessuno slot extra da usare per $uid.');
      }
    } catch (e) {
      print('❌ Errore in useExtraSlot per $uid: $e');
    }
  }

  /// Controlla e sblocca badge/ricompense in base a criteri (es. conteggio referral).
  static Future<void> checkAndUnlockRewards(String uid) async {
    if (uid.isEmpty) return;
    try {
      final DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      if (userData == null) return;

      final int referralCount = userData['referralCount'] as int? ?? 0;
      Map<String, bool> unlockedRewards = Map<String, bool>.from(userData['unlockedRewards'] ?? {});
      bool rewardsUpdated = false;

      const String reward3ReferralsKey = 'referral_3_friends';
      if (referralCount >= 3 && unlockedRewards[reward3ReferralsKey] != true) {
        await addExtraSlots(uid, 3); 
        unlockedRewards[reward3ReferralsKey] = true;
        rewardsUpdated = true;
        print('🎖️ Ricompensa "$reward3ReferralsKey" sbloccata per $uid.');
      }

      const String reward5ReferralsKey = 'referral_5_friends_ads_disabled';
       if (referralCount >= 5 && unlockedRewards[reward5ReferralsKey] != true) {
        final DateTime adsDisabledUntil = DateTime.now().add(const Duration(days: 1));
        await _usersCollection.doc(uid).update({'adsDisabledUntil': Timestamp.fromDate(adsDisabledUntil)});
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('ads_disabled_until', adsDisabledUntil.toIso8601String());

        unlockedRewards[reward5ReferralsKey] = true;
        rewardsUpdated = true;
        print('🎖️ Ricompensa "$reward5ReferralsKey" (ads disabilitate) sbloccata per $uid.');
      }

      // Aggiungi qui altre logiche per ricompense/badge

      if (rewardsUpdated) {
        await _usersCollection.doc(uid).update({'unlockedRewards': unlockedRewards});
      }
    } catch (e) {
      print('❌ Errore in checkAndUnlockRewards per $uid: $e');
    }
  }

  /// Controlla se un utente ha sbloccato una specifica ricompensa/badge.
  static Future<bool> hasUnlockedReward(String uid, String rewardKey) async {
    if (uid.isEmpty || rewardKey.isEmpty) return false;
    try {
      final DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      final Map<String, dynamic> unlockedRewards = Map<String, dynamic>.from(userData?['unlockedRewards'] ?? {});
      return unlockedRewards[rewardKey] == true;
    } catch (e) {
      print('❌ Errore in hasUnlockedReward per $uid (chiave: $rewardKey): $e');
      return false;
    }
  }

  /// Assegna una ricompensa per la visualizzazione di un video ad, con un limite giornaliero.
  static Future<bool> grantVideoAdReward(String userId, {int slotsToAdd = 3, int dailyLimit = 3}) async {
    if (userId.isEmpty) return false;

    final DateTime now = DateTime.now();
    final String todayDateString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final DocumentReference userDocRef = _usersCollection.doc(userId);

    try {
      return await _firestore.runTransaction((transaction) async {
        final DocumentSnapshot userSnapshot = await transaction.get(userDocRef);
        final Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        Map<String, int> dailyVideoRewards = {};
        if (userData?['dailyVideoRewards'] is Map) {
          dailyVideoRewards = Map<String, int>.from(userData!['dailyVideoRewards']);
        }
        
        int todayCount = dailyVideoRewards[todayDateString] ?? 0;

        if (todayCount >= dailyLimit) {
          print('ℹ️ Limite giornaliero di video reward raggiunto per $userId ($todayCount/$dailyLimit).');
          return false;
        }

        dailyVideoRewards[todayDateString] = todayCount + 1;
        
        Map<String, dynamic> updates = {
          'dailyVideoRewards': dailyVideoRewards,
          'extraFreeSlots': FieldValue.increment(slotsToAdd)
        };
        
        if (!userSnapshot.exists) {
            transaction.set(userDocRef, updates);
        } else {
            transaction.update(userDocRef, updates);
        }
        
        print('✅ Ricompensa video ($slotsToAdd slot) assegnata a $userId. Conteggio oggi: ${todayCount + 1}');
        return true;
      });
    } catch (e) {
      print('❌ Errore in grantVideoAdReward per $userId: $e');
      return false;
    }
  }
}