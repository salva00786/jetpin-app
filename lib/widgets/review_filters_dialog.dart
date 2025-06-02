import 'package:flutter/material.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class ReviewFiltersDialog extends StatefulWidget {
  const ReviewFiltersDialog({super.key});

  @override
  State<ReviewFiltersDialog> createState() => _ReviewFiltersDialogState();
}

class _ReviewFiltersDialogState extends State<ReviewFiltersDialog> {
  String _selectedFilter = 'tutti'; // Chiave di default

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    // Le chiavi ('tutti', '5', '4+', 'negativi') sono interne e non necessitano di localizzazione.
    // I Text widget per le etichette usano le stringhe localizzate.
    final List<DropdownMenuItem<String>> filterItems = [
      DropdownMenuItem<String>(
        value: 'tutti',
        child: Text(localizations.reviewFilterAll),
      ),
      DropdownMenuItem<String>(
        value: '5',
        child: Text(localizations.reviewFilter5Stars),
      ),
      DropdownMenuItem<String>(
        value: '4+',
        child: Text(localizations.reviewFilter4PlusStars),
      ),
      DropdownMenuItem<String>(
        value: 'negativi',
        child: Text(localizations.reviewFilterNegative),
      ),
    ];

    return AlertDialog(
      title: Text(localizations.reviewFiltersDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: _selectedFilter,
            isExpanded: true,
            items: filterItems,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedFilter = newValue;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localizations.cancelButton), // Chiave da ARB
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _selectedFilter),
          child: Text(localizations.applyButton), // Chiave da ARB
        ),
      ],
    );
  }
}