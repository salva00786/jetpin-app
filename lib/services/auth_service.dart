// lib/services/auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jetpin_app/utils/premium_manager.dart'; // Assicurati che il path sia corretto

// Non ci sono stringhe UI da localizzare direttamente in questo file.

Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      await _ensureUserDocumentExists(user.uid, user.displayName); // Passa anche displayName
      PremiumManager.syncPremiumFromCloud(user.uid); 
      PremiumManager.startPremiumAutoSync(user.uid); 
    }
    return user;
  } catch (e) {
    print('Errore durante il signInWithGoogle: $e');
    return null;
  }
}

Future<User?> signInAnonymously() async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    final User? user = userCredential.user;
    if (user != null) {
      await _ensureUserDocumentExists(user.uid, null); // displayName potrebbe essere null
    }
    return user;
  } catch (e) {
    print('Errore durante il signInAnonymously: $e');
    return null;
  }
}

Future<void> signOut() async {
  try {
    // Prima il signOut da Firebase Auth
    await FirebaseAuth.instance.signOut();
    // Poi il signOut da GoogleSignIn per permettere la selezione di un altro account Google la prossima volta
    await GoogleSignIn().signOut();
    
    // Operazioni di pulizia dello stato locale
    PremiumManager.stopPremiumAutoSync(); 
    await PremiumManager.setPremium(false); // Resetta lo stato premium locale
    // Aggiungi qui altre operazioni di pulizia se necessario (es. SharedPreferences specifiche)
    print('Logout completato (Firebase Auth, GoogleSignIn, stato Premium locale resettato).');
  } catch (e) {
    print('Errore durante il signOut: $e');
  }
}

// --- MODIFICATA QUESTA FUNZIONE ---
Future<void> _ensureUserDocumentExists(String uid, String? displayName) async {
  final DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
  final DocumentSnapshot userDocSnapshot = await userDocRef.get();

  if (!userDocSnapshot.exists) {
    try {
      // Ottieni il nome utente dall'istanza User di FirebaseAuth se displayName è null
      // Questo è utile specialmente per l'accesso anonimo dove displayName potrebbe non essere passato.
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final String nameToSave = displayName ?? firebaseUser?.displayName ?? 'Utente JetPin';

      await userDocRef.set({
        'uid': uid, // Buona pratica salvare anche l'uid nel documento
        'displayName': nameToSave, // Salva il displayName
        'reviewCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'isVerifiedReviewer': false, // <<< NUOVO CAMPO AGGIUNTO QUI
        'referralCount': 0,          // Inizializza anche referralCount se non già presente
        'hasUsedTrial': false,       // Inizializza hasUsedTrial
        // Aggiungi qui altri campi di default se necessario
      });
      print('✅ Documento utente creato per $uid con isVerifiedReviewer=false.');
    } catch (e) {
      print('❌ Errore creazione documento utente per $uid: $e');
    }
  } else {
    // Se il documento esiste, potremmo voler aggiornare il displayName se è cambiato
    // e assicurare che i campi di default (come isVerifiedReviewer) esistano.
    Map<String, dynamic> updates = {};
    final data = userDocSnapshot.data() as Map<String, dynamic>?;

    if (displayName != null && data?['displayName'] != displayName) {
      updates['displayName'] = displayName;
    }
    if (data == null || data['isVerifiedReviewer'] == null) {
      updates['isVerifiedReviewer'] = false;
    }
    if (data == null || data['referralCount'] == null) {
      updates['referralCount'] = 0;
    }
    if (data == null || data['hasUsedTrial'] == null) {
      updates['hasUsedTrial'] = false;
    }
    // Aggiungi controllo per 'uid' se necessario
    if (data == null || data['uid'] == null) {
        updates['uid'] = uid;
    }


    if (updates.isNotEmpty) {
      try {
        await userDocRef.update(updates);
        print('ℹ️ Documento utente $uid aggiornato con campi di default mancanti/modificati.');
      } catch (e) {
        print('❌ Errore aggiornamento documento utente esistente $uid: $e');
      }
    }
  }
}
// --- FINE MODIFICA ---


// Funzione per la riautenticazione (necessaria per operazioni sensibili come eliminazione account)
Future<bool> reauthenticateCurrentUser(AuthCredential credential) async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("Nessun utente per la riautenticazione.");
    return false;
  }
  try {
    await user.reauthenticateWithCredential(credential);
    print("Ri-autenticazione riuscita.");
    return true;
  } on FirebaseAuthException catch (e) {
    print("Errore durante la ri-autenticazione: ${e.code} - ${e.message}");
    // Potresti voler gestire codici di errore specifici qui (es. 'wrong-password')
    return false;
  } catch (e) {
    print("Errore generico durante la ri-autenticazione: $e");
    return false;
  }
}


// Funzione per eliminare l'account dell'utente corrente da Firebase Authentication
// NOTA: Questa funzione ora lancia eccezioni in caso di errore, inclusa FirebaseAuthException per 'requires-recent-login'
Future<void> deleteCurrentUserAccount() async { 
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("Nessun utente attualmente loggato per l'eliminazione.");
    throw Exception("Nessun utente loggato."); 
  }

  try {
    print("Tentativo di eliminare l'account Firebase Auth per l'utente: ${user.uid}");
    await user.delete(); 
    print("Account Firebase Auth eliminato con successo per l'utente: ${user.uid}");

    await GoogleSignIn().signOut();
    await PremiumManager.setPremium(false);
    PremiumManager.stopPremiumAutoSync();
    print("Pulizia post-eliminazione account completata (Google SignOut, Premium reset).");
  } on FirebaseAuthException catch (e) {
    print('Errore FirebaseAuth durante l_eliminazione dell_account: ${e.message} (codice: ${e.code})');
    throw e; 
  } catch (e) {
    print('Errore generico durante l_eliminazione dell_account Firebase Auth: $e');
    throw Exception("Errore generico durante l'eliminazione dell'account.");
  }
}