// lib/widgets/pin_add_button.dart
import 'package:flutter/material.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/widgets/upgrade_premium_modal.dart';
import 'package:jetpin_app/l10n/app_localizations.dart';

// --- IMPORTA LA TUA NUOVA FUNZIONE DIALOGO ---
// Modifica il path se hai messo common_dialogs.dart in una cartella diversa (es. lib/utils/)
import 'package:jetpin_app/widgets/common_dialogs.dart'; 

class PinAddButton extends StatelessWidget {
  final int pinCount;
  final int freePinLimit;

  const PinAddButton({
    super.key,
    required this.pinCount,
    this.freePinLimit = 30,
  });

  @override
  Widget build(BuildContext context) {
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

        if (!isPremium && pinCount >= freePinLimit) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  localizations.pinAddLimitReachedMessage(freePinLimit),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showPremiumDialog(context, feature: 'pin_add');
                },
                child: Text(localizations.pinAddUpgradeToPremiumButton),
              ),
            ],
          );
        }
        
        return ElevatedButton.icon(
          icon: const Icon(Icons.add_location_alt_outlined),
          label: Text(localizations.pinAddButtonLabel),
          onPressed: () {
            // --- ORA CHIAMA LA FUNZIONE IMPORTATA ---
            showComingSoonDialog(context); 
          },
        );
      },
    );
  }
}