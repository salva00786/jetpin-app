// lib/services/profile_actions.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jetpin_app/l10n/app_localizations.dart'; // Per la classe S
import 'package:jetpin_app/services/auth_service.dart'; // Per deleteCurrentUserAccount e signOut

// Enum AccountDeletionChoice, necessario per le funzioni sottostanti e per il dialogo in profile_page
enum AccountDeletionChoice {
  deleteAll,
  anonymizeAndDelete,
}

// --- Funzioni di Utilità per UI Feedback (Dialoghi e SnackBar) ---

void showLoadingDialog(BuildContext context, String message) {
  if (!Navigator.of(context, rootNavigator: true).canPop()) { // Evita di mostrare se un altro è già attivo in modo modale
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const CircularProgressIndicator(), const SizedBox(width: 20), Text(message),
          ]),
        ),
      ),
    );
  }
}

void closeLoadingDialog(BuildContext context) {
  // Controlla se il Navigator può fare pop per evitare errori se nessun dialogo è mostrato
  // o se il contesto non è più valido per il dialogo.
  if (Navigator.of(context, rootNavigator: true).canPop()) {
     Navigator.of(context, rootNavigator: true).pop();
  }
}

void showSnackBarMessage(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
  ));
}

// --- Logica per Ri-autenticazione ---

Future<bool?> promptForReauthentication(BuildContext context, S localizations) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(localizations.reauthenticationRequiredTitle),
        content: Text(localizations.reauthenticationRequiredMessage),
        actions: <Widget>[
          TextButton(
            child: Text(localizations.cancelButton),
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          ElevatedButton(
            child: Text(localizations.reauthenticateButton),
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      );
    },
  );
}

Future<bool> reauthenticateCurrentUserWithGoogle(BuildContext context, S localizations) async {
  showLoadingDialog(context, localizations.loadingReauthenticating);
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    closeLoadingDialog(context);
    return false;
  }

  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      closeLoadingDialog(context);
      print("Ri-autenticazione annullata dall'utente (nessun account Google selezionato).");
      return false;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await currentUser.reauthenticateWithCredential(credential);
    closeLoadingDialog(context);
    print("Utente ri-autenticato con successo.");
    return true;
  } catch (e) {
    closeLoadingDialog(context);
    print("Errore durante la ri-autenticazione: $e");
    showSnackBarMessage(context, localizations.reauthenticationFailedMessage, isError: true);
    return false;
  }
}

// --- Logica per Operazioni sulle Recensioni durante Cancellazione Account ---

Future<bool> performReviewOperationsForAccountDeletion(
  BuildContext context,
  User user,
  AccountDeletionChoice choice,
  S localizations,
) async {
  showLoadingDialog(context, localizations.accountDeletionProcessingReviewsMessage); // Messaggio più specifico
  try {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final reviewsQuery = FirebaseFirestore.instance.collection('reviews').where('userId', isEqualTo: user.uid);
    final reviewsSnapshot = await reviewsQuery.get();

    if (choice == AccountDeletionChoice.deleteAll) {
      for (var doc in reviewsSnapshot.docs) { batch.delete(doc.reference); }
      print("RECENSIONI ELIMINATE (batch) per ${user.uid}.");
    } else if (choice == AccountDeletionChoice.anonymizeAndDelete) {
      for (var doc in reviewsSnapshot.docs) {
        batch.update(doc.reference, {'userId': 'anonymized_user_id', 'userName': localizations.anonymousUser});
      }
      print("RECENSIONI ANONIMIZZATE (batch) per ${user.uid}.");
    }
    await batch.commit();
    closeLoadingDialog(context);
    return true;
  } catch (e) {
    print("Errore durante operazioni sulle recensioni (batch): $e");
    closeLoadingDialog(context);
    showSnackBarMessage(context, localizations.accountDeletionFailedReviewOperationMessage, isError: true);
    return false;
  }
}

// --- Logica Principale per il Processo di Cancellazione Account ---

Future<void> processAccountDeletion(
  BuildContext context,
  User user,
  AccountDeletionChoice choice,
  S localizations,
) async {
  showLoadingDialog(context, localizations.accountDeletingMessage); // Messaggio più specifico
  try {
    await deleteCurrentUserAccount(); // Da auth_service.dart
    closeLoadingDialog(context);
    showSnackBarMessage(
      context,
      choice == AccountDeletionChoice.deleteAll
          ? localizations.accountDeletionAllDeletedSuccessMessage
          : localizations.accountDeletionAnonymizedSuccessMessage
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

  } on FirebaseAuthException catch (e) {
    closeLoadingDialog(context);
    if (e.code == 'requires-recent-login') {
      final bool? wantsToReAuth = await promptForReauthentication(context, localizations);
      if (wantsToReAuth == true) {
        final bool reAuthSuccess = await reauthenticateCurrentUserWithGoogle(context, localizations);
        if (reAuthSuccess) {
          showLoadingDialog(context, localizations.loadingRetryingDelete);
          try {
            await deleteCurrentUserAccount(); // Secondo tentativo
            closeLoadingDialog(context);
            showSnackBarMessage(context, localizations.accountDeletionRetrySuccessMessage);
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          } catch (finalDeleteError) {
            closeLoadingDialog(context);
            print("Errore nel tentativo finale di eliminazione dopo ri-autenticazione: $finalDeleteError");
            showSnackBarMessage(context, localizations.accountDeletedErrorMessage, isError: true);
          }
        }
      }
    } else {
      print("FirebaseAuthException (non requires-recent-login) durante eliminazione: ${e.code}");
      showSnackBarMessage(context, localizations.accountDeletedErrorMessage, isError: true);
    }
  } catch (e) {
    closeLoadingDialog(context);
    print("Errore generico durante eliminazione account: $e");
    showSnackBarMessage(context, localizations.accountDeletedErrorMessage, isError: true);
  }
}

// --- Logica per il Logout ---
// (auth_service.dart ha già signOut(), questa è per il flusso UI in ProfilePage)

Future<void> handleLogoutFlow(BuildContext context, S localizations) async {
  final bool? shouldLogout = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      final S dialogLocalizations = S.of(dialogContext)!;
      return AlertDialog(
        title: Text(dialogLocalizations.profileLogoutDialogTitle),
        content: Text(dialogLocalizations.profileLogoutDialogContent),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(dialogLocalizations.cancelButton)),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(dialogLocalizations.logoutButton)),
        ],
      );
    },
  );

  if (shouldLogout == true) {
    await signOut(); // Da auth_service.dart
    showSnackBarMessage(context, localizations.profileLogoutSuccess);
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}