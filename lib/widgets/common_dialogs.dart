// lib/widgets/common_dialogs.dart (o lib/utils/common_dialogs.dart)

import 'package:flutter/material.dart';
import 'package:jetpin_app/l10n/app_localizations.dart'; // Assicurati che il path sia corretto per la tua classe S

// Funzione per mostrare un dialogo generico "Prossimamente"
void showComingSoonDialog(BuildContext context) {
  final S localizations = S.of(context)!; // Ottieni le localizzazioni
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(localizations.comingSoonDialogTitle), // Chiave ARB già definita
        content: Text(localizations.comingSoonDialogMessage), // Chiave ARB già definita
        actions: <Widget>[
          TextButton(
            child: Text(localizations.okButton), // Assumendo che tu abbia già una chiave "okButton"
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      );
    },
  );
}

// Potresti aggiungere qui altri dialoghi comuni in futuro