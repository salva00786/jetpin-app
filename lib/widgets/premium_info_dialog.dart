// lib/widgets/premium_info_dialog.dart
import 'package:flutter/material.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

Future<void> showPremiumInfoDialog(BuildContext context) async {
  // CORREZIONE: Aggiunto '!' per asserire che S.of(context) non è nullo
  final S localizations = S.of(context)!;

  const EdgeInsets listTilePadding = EdgeInsets.symmetric(vertical: 4.0);

  // Verifica che queste chiavi corrispondano esattamente a quelle nei tuoi file .arb
  // e ai getter generati nella classe S.
  final List<Widget> premiumFeatures = [
    ListTile(
      leading: const Icon(Icons.flight_takeoff_outlined, color: Colors.blue),
      title: Text(localizations.premiumInfoFeatureUnlimitedSlots), // Chiave da ARB
      contentPadding: listTilePadding,
    ),
    ListTile(
      leading: const Icon(Icons.cloud_done_outlined, color: Colors.green),
      // CORREZIONE: Assicurati che la chiave sia 'premiumFeatureCloudBackup' se così è nel tuo ARB
      title: Text(localizations.premiumFeatureCloudBackup), // Chiave da ARB
      contentPadding: listTilePadding,
    ),
    ListTile(
      leading: const Icon(Icons.block_flipped, color: Colors.red),
      // CORREZIONE: Assicurati che la chiave sia 'premiumFeatureNoAds' se così è nel tuo ARB
      title: Text(localizations.premiumFeatureNoAds), // Chiave da ARB
      contentPadding: listTilePadding,
    ),
    ListTile(
      leading: const Icon(Icons.rocket_launch_outlined, color: Colors.purple),
      title: Text(localizations.premiumInfoFeaturePriorityAccess), // Chiave da ARB
      contentPadding: listTilePadding,
    ),
  ];

  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      // Non è necessario ridefinire 'localizations' qui se usi quello già definito sopra,
      // a meno che tu non voglia usare specificamente dialogContext, ma per stringhe statiche
      // 'localizations' dal contesto originale va bene.
      // final S dialogLocalizations = S.of(dialogContext)!; // Opzionale se usi localizations dal contesto esterno

      return AlertDialog(
        title: Text(localizations.premiumInfoDialogTitle),
        content: SingleChildScrollView( // Aggiunto per sicurezza se le feature fossero molte
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: premiumFeatures,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(localizations.closeButton), // Chiave da ARB
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.star_border),
            label: Text(localizations.premiumInfoDiscoverButton), // Chiave da ARB
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushNamed('/upgrade');
            },
          ),
        ],
      );
    },
  );
}