// Copyright 2025 Salvo00786 Jetpin. Tutti i diritti riservati.
// Per informazioni sulla licenza, vedere il file LICENSE.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/screens/upgrade_premium_screen.dart';
import 'package:jetpin_app/screens/review_stats_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jetpin_app/widgets/referral_share_widget.dart';
import 'package:url_launcher/url_launcher.dart';
// Non più necessario importare GoogleSignIn qui direttamente se profile_actions lo gestisce
// import 'package:google_sign_in/google_sign_in.dart';
// Rimosso import di auth_service qui perché le chiamate sono ora incapsulate in profile_actions
// o già in auth_service ma chiamate da profile_actions

import 'package:jetpin_app/l10n/app_localizations.dart';

// Importa il nuovo file con la logica estratta
import 'package:jetpin_app/services/profile_actions.dart'; // AGGIUNGI QUESTO IMPORT

// AccountDeletionChoice è ora definito in profile_actions.dart e importato tramite esso.

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        // Usa la funzione showSnackBarMessage importata
        showSnackBarMessage(context, 'Impossibile aprire $urlString', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.profileAppBarTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: localizations.profileTabLabel, icon: const Icon(Icons.person)),
            Tab(text: localizations.profileTabPremiumLabel, icon: const Icon(Icons.star)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ProfileTab(launchUrlCallback: _launchUrl),
          _PremiumTab(launchUrlCallback: _launchUrl),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatefulWidget {
  final Function(String) launchUrlCallback;
  const _ProfileTab({required this.launchUrlCallback});

  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab> {
  // _formatDateTime e _buildBadge rimangono come nel tuo codice
  String _formatDateTime(BuildContext context, DateTime dateTime) {
    final S localizations = S.of(context)!;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    return "$day/$month ${localizations.atTimeConnector} $hour:$minute";
  }

  Widget _buildBadge(BuildContext context, String text, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12.0),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }

  // --- Funzioni Helper per la cancellazione e ri-autenticazione SONO STATE SPOSTATE in profile_actions.dart ---
  // _showLoadingDialog, _closeLoadingDialog, _showSnackBar
  // _performReviewOperations, _promptForReauthentication, _reauthenticateCurrentUser, _deleteAccountProcess

  // _handleDeleteAccount ora chiama le funzioni da profile_actions.dart
  Future<void> _handleDeleteAccount(BuildContext contextFromWidget) async { // Rinominato context per chiarezza
    final S localizations = S.of(contextFromWidget)!;
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    AccountDeletionChoice? deletionChoiceState = AccountDeletionChoice.deleteAll; // Per lo StatefulBuilder del dialogo

    final AccountDeletionChoice? confirmedChoice = await showDialog<AccountDeletionChoice>(
      context: contextFromWidget,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder( // Per aggiornare i RadioListTile nel dialogo
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(localizations.deleteAccountOptionsDialogTitle),
              content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(localizations.deleteAccountOptionDialogMessage),
                const SizedBox(height: 16),
                RadioListTile<AccountDeletionChoice>(
                  title: Text(localizations.deleteAccountOptionDeleteAllLabel),
                  subtitle: Text(localizations.deleteAccountOptionDeleteAllDescription),
                  value: AccountDeletionChoice.deleteAll, groupValue: deletionChoiceState,
                  onChanged: (AccountDeletionChoice? value) { setStateDialog(() { deletionChoiceState = value; }); },
                ),
                RadioListTile<AccountDeletionChoice>(
                  title: Text(localizations.deleteAccountOptionAnonymizeLabel),
                  subtitle: Text(localizations.deleteAccountOptionAnonymizeDescription),
                  value: AccountDeletionChoice.anonymizeAndDelete, groupValue: deletionChoiceState,
                  onChanged: (AccountDeletionChoice? value) { setStateDialog(() { deletionChoiceState = value; }); },
                ),
              ]),
              actions: <Widget>[
                TextButton(
                  child: Text(localizations.cancelButton),
                  onPressed: () => Navigator.of(dialogContext).pop(null),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(contextFromWidget).colorScheme.error),
                  child: Text(localizations.deleteAccountConfirmButton, style: TextStyle(color: Theme.of(contextFromWidget).colorScheme.onError)),
                  onPressed: deletionChoiceState == null ? null : () => Navigator.of(dialogContext).pop(deletionChoiceState),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmedChoice != null) {
      // Ora usiamo contextFromWidget perché _handleDeleteAccount lo riceve come parametro
      final bool reviewsOpOk = await performReviewOperationsForAccountDeletion(
        contextFromWidget, // Passa il context del widget
        user,
        confirmedChoice,
        localizations,
      );
      if (reviewsOpOk) {
        await processAccountDeletion(
          contextFromWidget, // Passa il context del widget
          user,
          confirmedChoice,
          localizations,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final S localizations = S.of(context)!;

    if (user == null) {
      return Center(child: Text(localizations.profileNotLoggedIn));
    }

    bool isActuallyPremiumState = false;
    DateTime? trialStartDateState;

    // ... (Il resto del tuo metodo build rimane INVARIATO, l'ho omesso per brevità ma nel tuo file sarà completo)
    // Ad esempio, la parte con FutureBuilder per PremiumManager.getUserPremiumData,
    // il FutureBuilder per FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
    // i vari ListTile per policy, termini, supporto, e i pulsanti di cancellazione e logout.
    // L'UNICA MODIFICA NEL BUILD SARÀ PER IL PULSANTE LOGOUT se usava _showSnackBar

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            localizations.profileWelcomeMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          FutureBuilder<Map<String, dynamic>?>(
            future: PremiumManager.getUserPremiumData(uid: user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
              }
              final data = snapshot.data;
              isActuallyPremiumState = data?['isPremium'] == true;

              if (data?['trialStartDate'] is Timestamp) {
                  trialStartDateState = (data!['trialStartDate'] as Timestamp).toDate();
              }
              DateTime? premiumUntilDate;
              if (data?['premiumUntil'] != null && data!['premiumUntil'] is String) {
                premiumUntilDate = DateTime.tryParse(data['premiumUntil']);
              } else if (data?['premiumUntil'] is Timestamp) {
                premiumUntilDate = (data!['premiumUntil'] as Timestamp).toDate();
              }

              if (trialStartDateState != null && data?['hasUsedTrial'] == true && premiumUntilDate == null) {
                premiumUntilDate = trialStartDateState!.add(const Duration(days: 7));
              }

              if (isActuallyPremiumState && premiumUntilDate != null) {
                final now = DateTime.now();
                if (premiumUntilDate.isAfter(now)) {
                  final diff = premiumUntilDate.difference(now).inDays;
                  if (trialStartDateState != null &&
                      premiumUntilDate.isAtSameMomentAs(trialStartDateState!.add(const Duration(days:7))) &&
                      diff >=0 && diff <= 7 ) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber, color: Colors.orange),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              localizations.profilePremiumTrialExpiresSoon(diff + 1),
                              style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }

              bool isTrulyPaidPremium = isActuallyPremiumState &&
                (trialStartDateState == null ||
                (data?['hasUsedTrial'] == true && premiumUntilDate != null && premiumUntilDate.isAfter(trialStartDateState!.add(const Duration(days: 7))))
              );

              if (!isTrulyPaidPremium) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ReferralShareWidget(),
                  );
              }
              return const SizedBox.shrink();
            },
          ),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
            builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                 return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
               }
               if (!snapshot.hasData || !snapshot.data!.exists) {
                 return const SizedBox();
               }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                final referredBy = data['referredBy'] != null;
                final referralCount = data['referralCount'] as int? ?? 0;
                final extraSlots = data['extraFreeSlots'] as int? ?? 0;
                final bool isVerifiedReviewer = data['isVerifiedReviewer'] as bool? ?? false;

                final List<Widget> badges = [];

                if (isVerifiedReviewer) {
                  badges.add(_buildBadge(
                    context,
                    localizations.profileBadgeVerifiedReviewer,
                    Icons.verified_user_outlined,
                    Colors.green,
                  ));
                }

                if (referredBy) {
                  badges.add(_buildBadge(context, localizations.profileBadgeUsedReferral, Icons.card_giftcard, Colors.blue));
                }
                if (referralCount >= 10) {
                  badges.add(_buildBadge(context, localizations.profileBadgeLegend(referralCount), Icons.workspace_premium, Colors.green));
                } else if (referralCount >= 5) {
                  badges.add(_buildBadge(context, localizations.profileBadgeInfluencer(referralCount), Icons.rocket, Colors.deepPurple));
                } else if (referralCount >= 3) {
                  badges.add(_buildBadge(context, localizations.profileBadgePromoter(referralCount), Icons.emoji_events, Colors.amber));
                }

                if (referralCount > 0) {
                     badges.add(_buildBadge(context, localizations.profileReferralCount(referralCount), Icons.group, Colors.orange));
                }
                if (extraSlots > 0) {
                     badges.add(_buildBadge(context, localizations.profileExtraSlots(extraSlots), Icons.star, Colors.teal));
                }

                if (badges.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: Text(
                          localizations.profileUnlockedRewardsTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      ...badges,
                    ],
                  );
                } else if (referralCount == 0 && !isVerifiedReviewer && extraSlots == 0 && !referredBy) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      localizations.profileInviteMoreForBadges,
                      style: TextStyle(color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder<Map<String, dynamic>?>(
            future: PremiumManager.getUserPremiumData(uid: user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text(localizations.profileErrorLoadingPremium);
              }
              final data = snapshot.data;
              final isPremium = data?['isPremium'] == true;

              DateTime? currentTrialStartDate;
              if (data?['trialStartDate'] is Timestamp) {
                  currentTrialStartDate = (data!['trialStartDate'] as Timestamp).toDate();
              }
              DateTime? currentPremiumUntilDate;
              if (data?['premiumUntil'] != null && data!['premiumUntil'] is String) {
                currentPremiumUntilDate = DateTime.tryParse(data['premiumUntil']);
              } else if (data?['premiumUntil'] is Timestamp) {
                currentPremiumUntilDate = (data!['premiumUntil'] as Timestamp).toDate();
              }
              if (currentTrialStartDate != null && data?['hasUsedTrial'] == true && currentPremiumUntilDate == null) {
                currentPremiumUntilDate = currentTrialStartDate.add(const Duration(days: 7));
              }

              if (!isPremium) return const SizedBox.shrink();

              int? daysLeftForTrialDisplay;
              bool isCurrentlyActiveTrial = false;
              if (currentTrialStartDate != null &&
                  data?['hasUsedTrial'] == true &&
                  currentPremiumUntilDate != null &&
                  currentPremiumUntilDate.isAfter(DateTime.now()) &&
                  currentPremiumUntilDate.isAtSameMomentAs(currentTrialStartDate.add(const Duration(days:7)))
                 ) {
                   final diff = currentPremiumUntilDate.difference(DateTime.now()).inDays;
                   daysLeftForTrialDisplay = diff >= 0 ? diff + 1 : null;
                   isCurrentlyActiveTrial = daysLeftForTrialDisplay != null;
              }

              return FutureBuilder<DateTime?>(
                future: PremiumManager.getLastBackupDate(user.uid),
                builder: (context, backupSnapshot) {
                  final lastBackup = backupSnapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8.0),
                            Text(localizations.profileUserIsPremium, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
                          ],
                        ),
                        if (isCurrentlyActiveTrial && daysLeftForTrialDisplay != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                localizations.profilePremiumTrialDaysLeft(daysLeftForTrialDisplay),
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: () async {
                             if (mounted) {
                                // Usa la funzione di dialogo da profile_actions.dart
                                showLoadingDialog(context, localizations.loadingText);
                              }
                            await PremiumManager.backupUserDataToCloud(user.uid);
                             if(mounted) {
                               closeLoadingDialog(context); // Usa la funzione di dialogo da profile_actions.dart
                             }
                            if (mounted) {
                              // Usa la funzione snackbar da profile_actions.dart
                              showSnackBarMessage(context, localizations.profileBackupComplete);
                              // setState per aggiornare la data dell'ultimo backup se la mostri dinamicamente
                              // basandoti su un valore di stato che viene aggiornato qui.
                              // Altrimenti, il FutureBuilder per getLastBackupDate si occuperà di riflettere
                              // il cambiamento dopo il prossimo rebuild (o se forzi un rebuild con setState).
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.backup),
                          label: Text(localizations.profileBackupCloudButton),
                        ),
                        if (lastBackup != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              localizations.profileLastBackupDate(_formatDateTime(context, lastBackup)),
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                        const SizedBox(height: 12.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ReviewStatsPage()),
                            );
                          },
                          icon: const Icon(Icons.bar_chart),
                          label: Text(localizations.profileAdvancedStatsButton),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined, color: Colors.blueGrey),
            title: Text(localizations.privacyPolicyLinkText),
            onTap: () => widget.launchUrlCallback('http://jetpin.salvo00786.it/privacy.html'),
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined, color: Colors.blueGrey),
            title: Text(localizations.termsOfServiceLinkText),
            onTap: () => widget.launchUrlCallback('http://jetpin.salvo00786.it/termini.html'),
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined, color: Colors.blueGrey),
            title: Text(localizations.supportContactText),
            onTap: () async {
              final S loc = S.of(context)!;
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'jetpin@salvo00786.it',
                queryParameters: {'subject': loc.supportEmailSubject},
              );
              widget.launchUrlCallback(emailLaunchUri.toString());
            },
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined, color: Theme.of(context).colorScheme.error),
            title: Text(
              localizations.deleteAccountButtonLabel,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () => _handleDeleteAccount(context), // Passa il context attuale
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.errorContainer),
            onPressed: () async {
              // _handleLogout ora chiama la funzione da profile_actions.dart
              await handleLogoutFlow(context, localizations);
            },
            icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.onErrorContainer),
            label: Text(localizations.logoutButton, style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              localizations.developedByText("Salvo00786"),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // _handleLogout è stato spostato in profile_actions.dart come handleLogoutFlow
}


class _PremiumTab extends StatelessWidget {
  final Function(String) launchUrlCallback;
  const _PremiumTab({required this.launchUrlCallback});

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;
    // Il contenuto di _PremiumTab rimane invariato
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Text(localizations.premiumTabTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16.0),
        ListTile(leading: const Icon(Icons.block_outlined, color: Colors.amber), title: Text(localizations.premiumFeatureNoAds)),
        ListTile(leading: const Icon(Icons.push_pin_outlined, color: Colors.indigo), title: Text(localizations.premiumFeatureUnlimitedPins)),
        ListTile(leading: const Icon(Icons.cloud_done_outlined, color: Colors.blue), title: Text(localizations.premiumFeatureCloudBackup)),
        ListTile(leading: const Icon(Icons.flight_outlined, color: Colors.teal), title: Text(localizations.premiumFeatureFlightTracking)),
        ListTile(leading: const Icon(Icons.auto_awesome_outlined, color: Colors.purple), title: Text(localizations.premiumFeatureAiFeatures)),
        const Divider(height: 40.0),
        ListTile(leading: const Icon(Icons.route_outlined), title: Text(localizations.premiumFeatureSmartItineraries)),
        ListTile(leading: const Icon(Icons.badge_outlined), title: Text(localizations.premiumFeatureSuperCreatorBadge)),
        const SizedBox(height: 24.0),
        Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.lock_open_outlined, color: Colors.white),
            label: Text(localizations.premiumTabDiscoverButton, style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpgradePremiumScreen()),
              );
            },
          ),
        ),
      ],
    );
  }
}