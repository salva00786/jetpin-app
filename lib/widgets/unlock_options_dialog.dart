import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ads/ad_manager.dart';
import '../utils/referral_manager.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

// AdManager non ha un costruttore const di default nella nostra ultima revisione,
// quindi rimuoviamo 'const' se AdManager() non è un costruttore const.
final AdManager _adManager = AdManager();

Future<void> showUnlockOptionsDialog(
  BuildContext context, {
  VoidCallback? onVideoUnlock,
}) async {
  // CORREZIONE: Aggiunto '!'
  final S localizations = S.of(context)!;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      // CORREZIONE: Aggiunto '!'
      final S dialogLocalizations = S.of(dialogContext)!;

      return AlertDialog(
        title: Text(dialogLocalizations.unlockOptionsDialogTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dialogLocalizations.unlockOptionsDialogContent),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowButtonSpacing: 8.0,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushNamed('/upgrade');
            },
            child: Text(dialogLocalizations.unlockOptionsGoPremium),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();

              final User? user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // Qui 'localizations' si riferisce a quello del contesto esterno del dialogo principale, che è corretto
                      content: Text(localizations.unlockOptionsLoginRequired),
                    ),
                  );
                }
                return;
              }
              _adManager.showRewardedAd(
                context: context, // Passa il context originale per AdManager
                onReward: () {
                  onVideoUnlock?.call();
                },
              );
            },
            child: Text(dialogLocalizations.unlockOptionsWatchVideoButton),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();

              final User? user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // Qui 'localizations' si riferisce a quello del contesto esterno del dialogo principale, che è corretto
                      content: Text(localizations.unlockOptionsLoginRequired),
                    ),
                  );
                }
                return;
              }

              String? inviteLink;
              try {
                inviteLink = await ReferralManager.generateInviteLink(user.uid);
              } catch (e) {
                print("Errore generazione link invito: $e");
                inviteLink = null;
              }

              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (BuildContext inviteDialogContext) {
                    // CORREZIONE: Aggiunto '!'
                    final S inviteDialogLocalizations = S.of(inviteDialogContext)!;
                    return AlertDialog(
                      title: Text(inviteDialogLocalizations.unlockOptionsShareDialogTitle),
                      content: SelectableText(
                        inviteLink ?? inviteDialogLocalizations.unlockOptionsErrorGeneratingInviteLink,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(inviteDialogContext).pop(),
                          child: Text(inviteDialogLocalizations.okButton), 
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text(dialogLocalizations.unlockOptionsInviteFriendButton),
          ),
        ],
      );
    },
  );
}