// lib/widgets/map_filters.dart
import 'package:flutter/material.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/widgets/upgrade_premium_modal.dart';
import 'package:jetpin_app/l10n/app_localizations.dart';

// --- IMPORTA LA TUA FUNZIONE DIALOGO COMUNE ---
// Assicurati che il path sia corretto
import 'package:jetpin_app/widgets/common_dialogs.dart'; 

class MapFilters extends StatelessWidget {
  // Le callback originali vengono mantenute nel costruttore, anche se temporaneamente
  // non verranno usate direttamente se la funzionalità è "Coming Soon".
  // Questo permette di riattivarle facilmente in futuro.
  final VoidCallback onAdvancedFilter;
  final VoidCallback onBaseFilter;

  const MapFilters({
    super.key,
    required this.onAdvancedFilter,
    required this.onBaseFilter,
  });

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterChip(
          label: Text(localizations.mapFiltersAllPins),
          selected: false, // selected è false perché non c'è uno stato attivo per il filtro
          onSelected: (bool selected) {
            // --- MODIFICA: Mostra dialogo "Coming Soon" ---
            // Invece di chiamare onBaseFilter()
            showComingSoonDialog(context);
          },
        ),
        const SizedBox(width: 8.0),
        FutureBuilder<bool>(
          future: PremiumManager.isPremium(),
          builder: (context, snapshot) {
            final bool isPremium = snapshot.data ?? false;

            return FilterChip(
              label: Text(localizations.mapFiltersAdvanced),
              selected: false, // selected è false
              avatar: isPremium ? null : const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
              onSelected: (bool selected) {
                if (isPremium) {
                  // --- MODIFICA: Mostra dialogo "Coming Soon" anche per utenti premium ---
                  // Invece di chiamare onAdvancedFilter()
                  showComingSoonDialog(context);
                } else {
                  // Se non è premium, mostra comunque il dialogo per l'upgrade
                  showPremiumBlockDialog(context, 'map_filter');
                }
              },
            );
          },
        ),
      ],
    );
  }
}