// lib/widgets/pin_stats_section.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
// import 'package:jetpin_app/utils/premium_manager.dart'; // Non più necessario se mostriamo solo placeholder
// import 'package:jetpin_app/widgets/upgrade_premium_modal.dart'; // Non più necessario

import 'package:jetpin_app/l10n/app_localizations.dart';

class PinStatsSection extends StatelessWidget {
  // I parametri originali potrebbero non essere più necessari se mostriamo solo un placeholder
  // final int pinCount;
  // final DateTime? lastPinDate;
  // final Widget advancedStats;

  const PinStatsSection({
    super.key,
    // required this.pinCount, // Non più necessario per il placeholder
    // this.lastPinDate,       // Non più necessario per il placeholder
    // required this.advancedStats, // Non più necessario per il placeholder
  });

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;

    // --- MODIFICA: Mostra un placeholder "Coming Soon" ---
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pending_actions_outlined, size: 36, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 8.0),
            Text(
              localizations.comingSoonDialogTitle, // Riutilizziamo il titolo del dialogo
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4.0),
            Text(
              localizations.comingSoonDialogMessage, // Riutilizziamo il messaggio del dialogo
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    // --- FINE MODIFICA ---


    // IL CODICE ORIGINALE PER MOSTRARE LE STATISTICHE (ORA COMMENTATO) ERA SIMILE A QUESTO:
    /*
    String formattedLastPinDate = '';
    if (lastPinDate != null) {
      try {
        formattedLastPinDate = DateFormat.yMMMd(localizations.localeName).format(lastPinDate!.toLocal());
      } catch (e) {
        print("Errore formattazione data per PinStatsSection: $e");
        formattedLastPinDate = lastPinDate!.toLocal().toString().split(' ')[0];
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.pinStatsTotalPins(pinCount),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (lastPinDate != null && formattedLastPinDate.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(
            localizations.pinStatsLastPinDate(formattedLastPinDate),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        const SizedBox(height: 16.0),
        FutureBuilder<bool>(
          future: PremiumManager.isPremium(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
            final bool isPremium = snapshot.data ?? false;
            if (isPremium) {
              return advancedStats;
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () => showPremiumBlockDialog(context, 'pin_stats'),
                  child: Text(localizations.pinStatsUnlockAdvancedButton),
                ),
              );
            }
          },
        ),
      ],
    );
    */
  }
}