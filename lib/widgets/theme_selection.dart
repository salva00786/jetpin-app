import 'package:flutter/material.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/widgets/upgrade_premium_modal.dart'; // Contiene showPremiumBlockDialog

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class ThemeSelection extends StatelessWidget {
  final VoidCallback onSelectDefault;
  final VoidCallback onSelectPremium;

  const ThemeSelection({
    super.key,
    required this.onSelectDefault,
    required this.onSelectPremium,
  });

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    return FutureBuilder<bool>(
      future: PremiumManager.isPremium(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        // } // Puoi aggiungere un indicatore di caricamento se preferisci

        final bool isPremium = snapshot.data ?? false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(localizations.themeSelectionClassicTheme), // Chiave da ARB
              leading: const Icon(Icons.palette_outlined),
              onTap: onSelectDefault,
            ),
            ListTile(
              title: Text(localizations.themeSelectionPremiumTheme), // Chiave da ARB
              leading: const Icon(Icons.workspace_premium_outlined),
              trailing: isPremium ? null : const Icon(Icons.lock_outline, size: 18.0, color: Colors.amber),
              onTap: isPremium
                  ? onSelectPremium
                  : () => showPremiumBlockDialog(context, 'themes'),
              enabled: isPremium,
            ),
          ],
        );
      },
    );
  }
}