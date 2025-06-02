import 'package:flutter/material.dart';
import 'premium_purchase_button.dart'; // Sarà localizzato separatamente

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class UpgradePremiumModal extends StatelessWidget {
  final String feature;

  const UpgradePremiumModal({super.key, required this.feature});

  // Questo metodo ora riceve un'istanza 'S' non nullable
  String _getLocalizedFeatureMessage(S localizations) {
    switch (feature) {
      case 'map_filter':
        return localizations.upgradeFeatureMapFilter;
      case 'pin_stats':
        return localizations.upgradeFeaturePinStats;
      case 'pin_export':
        return localizations.upgradeFeaturePinExport;
      case 'backup_cloud':
        return localizations.upgradeFeatureBackupCloud;
      case 'themes':
        return localizations.upgradeFeatureThemes;
      case 'pin_add': 
        return localizations.upgradeFeaturePinAdd;
      case 'review_limit':
        return localizations.upgradeFeatureReviewLimit;
      case 'review_filters':
        return localizations.upgradeFeatureReviewFilters;
      case 'review_stats':
        return localizations.upgradeFeatureReviewStats;
      case 'review_stats_hint':
        return localizations.upgradeFeatureReviewStatsHint;
      default:
        return localizations.upgradeFeatureDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!; 
    final String featureMessage = _getLocalizedFeatureMessage(localizations); // Ora 'localizations' è di tipo 'S'

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              localizations.upgradePremiumModalTitle, // Chiave da ARB
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              featureMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            const PremiumPurchaseButton(), // Questo widget sarà localizzato separatamente se necessario
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(localizations.cancelButton), // Chiave da ARB
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔓 Funzione globale da usare in tutti i widget Premium-bloccati
Future<void> showPremiumDialog(BuildContext context, {required String feature}) {
  return showDialog(
    context: context,
    builder: (_) => UpgradePremiumModal(feature: feature),
  );
}

/// 🧱 Alias per retrocompatibilità con eventuale codice precedente
@Deprecated('Usa showPremiumDialog invece')
void showPremiumBlockDialog(BuildContext context, String feature) {
  showPremiumDialog(context, feature: feature);
}