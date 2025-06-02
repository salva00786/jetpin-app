import 'package:flutter/material.dart';

// Non ci sono stringhe UI da localizzare direttamente in questa funzione.
// La 'label' passata come parametro dovrebbe essere già localizzata
// dal codice chiamante.

/// Costruisce un widget badge "Premium" con un'etichetta e un'icona a lucchetto.
///
/// La [label] fornita dovrebbe essere già localizzata.
Widget buildPremiumBadge(String label) {
  return Row(
    mainAxisSize: MainAxisSize.min, // Adatta la riga al contenuto
    children: [
      Text(label), // La 'label' dovrebbe essere già localizzata dal chiamante
      const SizedBox(width: 4.0), // Spazio costante
      const Icon(
        Icons.lock_outline, // Icona più adatta per "bloccato" o "premium"
        color: Colors.amber, // Colore come da originale
        size: 16.0,          // Dimensione come da originale
      ),
    ],
  );
}