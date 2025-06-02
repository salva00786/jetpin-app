import 'package:flutter/material.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/widgets/upgrade_premium_modal.dart'; // Contiene showPremiumDialog

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class CloudBackupButton extends StatelessWidget {
  const CloudBackupButton({super.key});

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    return ElevatedButton.icon(
      icon: const Icon(Icons.cloud_upload),
      label: Text(localizations.cloudBackupButtonLabel), // Chiave da ARB
      style: ElevatedButton.styleFrom(
          // Esempio di stile, puoi personalizzarlo
          // backgroundColor: Theme.of(context).colorScheme.secondary,
          // foregroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
      onPressed: () async {
        final bool isPremium = await PremiumManager.isPremium();
        if (!context.mounted) return;

        if (!isPremium) {
          showPremiumDialog(context, feature: 'backup_cloud');
        } else {
          // Logica di backup reale (qui simulata)
          // In un'app reale, questa logica dovrebbe essere in un servizio
          // e potrebbe restituire un booleano per il successo.
          // Esempio:
          // final String? userId = FirebaseAuth.instance.currentUser?.uid;
          // if (userId != null) {
          //   final bool success = await PremiumManager.backupUserDataToCloud(userId);
          //   if (context.mounted) {
          //     if (success) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text(localizations.cloudBackupSuccessMessage)),
          //       );
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text(localizations.cloudBackupFailedMessage)),
          //       );
          //     }
          //   }
          // } else {
          //   // Utente non loggato, gestisci se necessario
          // }

          // Manteniamo la simulazione come nel widget originale:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.cloudBackupSuccessMessage)),
          );
        }
      },
    );
  }
}