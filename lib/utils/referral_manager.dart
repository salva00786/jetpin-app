// lib/utils/referral_manager.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'premium_manager.dart'; // Assicurati che il path sia corretto

// Non ci sono stringhe UI da localizzare direttamente in questo file.
// Eventuali messaggi mostrati all'utente a seguito di queste operazioni
// (es. "Link d'invito generato", "Bonus referral applicato") dovrebbero essere gestiti
// e localizzati nel codice chiamante (UI).

class ReferralManager {
  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  static CollectionReference get _usersCollection => _firestore.collection('users');

  /// Simula la generazione di un link d'invito univoco per l'utente.
  /// In un'app reale, questo potrebbe coinvolgere un servizio di deep linking.
  static Future<String> generateInviteLink(String userId) async {
    if (userId.isEmpty) {
      // Considera di lanciare un'eccezione o restituire un errore gestibile
      // se l'userId non è valido, invece di un link potenzialmente non funzionante.
      print("Tentativo di generare link d'invito con userId vuoto."); // Corretto con doppi apici
      return 'https://jetpin.app/invite/error_invalid_user'; // Esempio di link di errore
    }
    // Esempio semplice di link, potrebbe essere più complesso con parametri specifici
    return 'https://jetpin.app/invite?referrer=$userId';
  }

  /// Applica i benefici di un referral a un nuovo utente e potenzialmente all'utente referente.
  static Future<bool> applyReferral(String referrerId, String newUserId) async {
    if (referrerId.isEmpty || newUserId.isEmpty || referrerId == newUserId) {
      print('IDs non validi o auto-referral in applyReferral.');
      return false; // Condizioni non valide per applicare il referral
    }

    final DocumentReference newUserDocRef = _usersCollection.doc(newUserId);
    final DocumentReference referrerDocRef = _usersCollection.doc(referrerId);

    try {
      // Verifica che l'utente referente esista
      final referrerDoc = await referrerDocRef.get();
      if (!referrerDoc.exists) {
        print('Utente referente ($referrerId) non trovato. Impossibile applicare il referral.');
        return false;
      }
      
      // Verifica se il nuovo utente ha già usato un referral o una prova
      final newUserDoc = await newUserDocRef.get();
      final newUserData = newUserDoc.data() as Map<String, dynamic>?;
      if (newUserData?['referredBy'] != null) { // Controlla solo se 'referredBy' è già settato
          print('Il nuovo utente ($newUserId) ha già un referral registrato.');
          return false; // Non applicare se un referral è già stato registrato
      }
      // La logica di PremiumManager.activateFreeTrial gestirà il caso 'hasUsedTrial' == true

      // Applica benefici al nuovo utente
      // 1. Registra da chi è stato invitato
      // 2. Attiva la prova gratuita (PremiumManager gestisce la logica 'hasUsedTrial')
      await newUserDocRef.set({
        'referredBy': referrerId,
        'referredAt': FieldValue.serverTimestamp(), // Traccia quando è stato applicato
      }, SetOptions(merge: true));
      
      bool trialActivated = await PremiumManager.activateFreeTrial(newUserId);
      if (trialActivated) {
        print('🎁 Prova gratuita attivata per il nuovo utente $newUserId tramite referral da $referrerId.');
      } else {
        // Questo può accadere se PremiumManager.activateFreeTrial rileva che l'utente ha già 'hasUsedTrial'
        // o se c'è un altro errore nell'attivazione della prova.
        print('ℹ️ Prova gratuita non attivata per $newUserId (potrebbe averla già usata o errore durante l_attivazione).');
      }

      // Applica benefici/tracciamento all'utente referente (referrer)
      // È importante che questo avvenga anche se la prova per il nuovo utente non si attiva,
      // purché il campo 'referredBy' sia stato settato correttamente per il nuovo utente.
      await referrerDocRef.set({
        'referralsGiven': FieldValue.arrayUnion([newUserId]), // Lista di utenti invitati
        'referralCount': FieldValue.increment(1), // Incrementa il conteggio
        'lastReferralDate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Controlla se il referente ha sbloccato nuove ricompense/badge
      await PremiumManager.checkAndUnlockRewards(referrerId);

      print('✅ Bonus referral applicato con successo per $newUserId (invitato da $referrerId).');
      return true;

    } catch (e) {
      print('❌ Errore durante l_applicazione del referral ($referrerId -> $newUserId): $e');
      return false;
    }
  }
}