import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class ReferralShareWidget extends StatelessWidget {
  final String? customMessage;

  const ReferralShareWidget({super.key, this.customMessage});

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final String referralCode = user.uid;
    // Costruisci il link d'invito qui per passarlo al messaggio localizzato
    // Questo potrebbe anche essere generato da ReferralManager se la logica fosse più complessa
    // e ReferralManager fosse adattato per non dipendere da BuildContext per questo.
    final String inviteLink = 'https://jetpin.app/invite/$referralCode'; // Esempio, adatta se necessario

    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.referralShareWidgetTitle, // Chiave da ARB
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              localizations.referralShareWidgetDescription, // Chiave da ARB
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              localizations.referralShareWidgetYourCodeLabel, // Chiave da ARB
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4.0),
            SelectableText(
              referralCode,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                final String messageToShare = customMessage ??
                    localizations.referralShareDefaultMessage(referralCode, inviteLink); // Chiave da ARB, accetta 2 parametri
                Share.share(messageToShare);
              },
              icon: const Icon(Icons.share_outlined),
              label: Text(localizations.referralShareWidgetShareButton), // Chiave da ARB
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}