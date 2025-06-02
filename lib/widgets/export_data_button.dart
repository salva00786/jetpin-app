import 'package:flutter/material.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/widgets/upgrade_premium_modal.dart'; // Contiene showPremiumDialog

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class ExportDataButton extends StatelessWidget {
  final VoidCallback onExport;

  const ExportDataButton({
    super.key,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    return FutureBuilder<bool>(
      future: PremiumManager.isPremium(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final bool isPremium = snapshot.data ?? false;

        if (isPremium) {
          return ElevatedButton.icon(
            icon: const Icon(Icons.file_download),
            label: Text(localizations.exportDataButtonLabel), // Chiave da ARB
            onPressed: onExport,
          );
        } else {
          return ElevatedButton.icon(
            icon: const Icon(Icons.lock_outline),
            label: Text(localizations.exportDataButtonLabelPremiumRequired), // Chiave da ARB
            onPressed: () {
              showPremiumDialog(context, feature: 'pin_export');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.grey.shade700,
            ),
          );
        }
      },
    );
  }
}