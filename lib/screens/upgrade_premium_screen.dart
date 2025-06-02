import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/premium_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import per la localizzazione CORRETTO per la tua struttura (file in lib/l10n/)
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class UpgradePremiumScreen extends StatefulWidget {
  const UpgradePremiumScreen({super.key});

  @override
  State<UpgradePremiumScreen> createState() => _UpgradePremiumScreenState();
}

class _UpgradePremiumScreenState extends State<UpgradePremiumScreen> {
  bool _isPremium = false;
  bool _hasUsedTrial = false;
  bool _loading = true; // Assicurati che questa variabile sia definita
  int? _daysLeftInTrial;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        setState(() => _loading = false);
      }
      return;
    }

    final isPremiumFromManager = await PremiumManager.isPremium();
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userDoc = await userDocRef.get();
    final data = userDoc.data();

    final hasUsedTrialFirestore = data?['hasUsedTrial'] == true;
    int? calculatedDaysLeft;
    bool isCurrentlyInActiveTrial = false;

    final Timestamp? trialStartTimestamp = data?['trialStartDate'] as Timestamp?;
    DateTime? localTrialStartDate;
    if (trialStartTimestamp != null) {
      localTrialStartDate = trialStartTimestamp.toDate();
    }

    if (isPremiumFromManager && localTrialStartDate != null && hasUsedTrialFirestore) {
      final trialEndDate = localTrialStartDate.add(const Duration(days: 7));
      final difference = trialEndDate.difference(DateTime.now());
      if (!difference.isNegative) {
        calculatedDaysLeft = difference.inDays + 1;
        isCurrentlyInActiveTrial = true;
      }
    }

    if (mounted) {
      setState(() {
        _isPremium = isPremiumFromManager;
        _hasUsedTrial = hasUsedTrialFirestore;
        _daysLeftInTrial = calculatedDaysLeft;
        _loading = false; // Corretto
      });

      bool isEffectivelyPaidPremium = isPremiumFromManager && !isCurrentlyInActiveTrial;
      // Logica di Pop se l'utente è già premium pagante (non in prova attiva)
      // e ha già usato la prova (per evitare pop per nuovi utenti che non hanno ancora dati di prova)
      if (isEffectivelyPaidPremium && hasUsedTrialFirestore) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!; // CORREZIONE: Aggiunto '!'

    if (_loading) { // Corretto: accesso a _loading
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(localizations.loadingText, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    bool isEffectivelyPaidPremium = _isPremium && !(_daysLeftInTrial != null && _daysLeftInTrial! > 0 && _hasUsedTrial);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.upgradePremiumAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isEffectivelyPaidPremium)
                Column(
                  children: [
                    Center(
                      child: Chip(
                        label: Text(localizations.upgradePremiumAlreadyPremium),
                        backgroundColor: Colors.greenAccent,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.home),
                        label: Text(localizations.goBackButton),
                      ),
                    ),
                  ],
                )
              else ...[
                Text(
                  localizations.upgradePremiumLimitReachedTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 12),
                Text(
                  localizations.upgradePremiumBenefitPrompt,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                Text(
                  localizations.upgradePremiumFeaturesTitle,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildFeatureListTile(
                    icon: Icons.push_pin,
                    color: Colors.indigo,
                    title: localizations.premiumFeatureUnlimitedPins,
                    subtitle: localizations.premiumFeatureUnlimitedPinsDesc),
                _buildFeatureListTile(
                    icon: Icons.picture_as_pdf,
                    color: Colors.blue,
                    title: localizations.premiumFeatureExportPdf,
                    subtitle: localizations.premiumFeatureExportPdfDesc),
                _buildFeatureListTile(
                    icon: Icons.bar_chart,
                    color: Colors.teal,
                    title: localizations.premiumFeatureDetailedStats,
                    subtitle: localizations.premiumFeatureDetailedStatsDesc),
                _buildFeatureListTile(
                    icon: Icons.cloud_upload,
                    color: Colors.purple,
                    title: localizations.premiumFeatureCloudBackup,
                    subtitle: localizations.premiumFeatureCloudBackupDesc),
                const SizedBox(height: 24),

                if (!_isPremium && !_hasUsedTrial) 
                  ..._buildActivateTrialSection(context, localizations)
                else if (_isPremium && _daysLeftInTrial != null && _daysLeftInTrial! > 0 && _hasUsedTrial) 
                   ..._buildTrialActiveSection(context, localizations, _daysLeftInTrial!)
                else if (_hasUsedTrial && !_isPremium) 
                  Center(
                    child: Text(
                      localizations.upgradePremiumTrialUsed,
                      style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                const SizedBox(height: 24),

                if (!isEffectivelyPaidPremium)
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _startPurchaseFlow(context),
                      icon: const Icon(Icons.star),
                      label: Text(localizations.upgradePremiumActivateButton),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                if (!isEffectivelyPaidPremium)
                  Center(
                    child: Text(
                      localizations.upgradePremiumPriceInfoFull(
                        localizations.priceInfo(
                            localizations.priceValue,
                            localizations.billingPeriodMonthly
                        ),
                        localizations.cancelAnytime
                      ),
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActivateTrialSection(BuildContext context, S localizations) {
    // Non c'è bisogno di S.of(context) qui perché 'localizations' è già passato come parametro
    return [
      Center(
        child: Text(
          localizations.upgradePremiumTrialAvailable,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 12),
      Center(
        child: ElevatedButton.icon(
          onPressed: () => _activateFreeTrial(context),
          icon: const Icon(Icons.card_giftcard),
          label: Text(localizations.upgradePremiumActivateTrialButton),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Center(
        child: Text(
          localizations.upgradePremiumTrialNoCharge,
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

 List<Widget> _buildTrialActiveSection(BuildContext context, S localizations, int daysLeft) {
    // Non c'è bisogno di S.of(context) qui
    return [
      Center(
        child: Text(
          localizations.upgradePremiumTrialActiveDaysLeft(daysLeft),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 12),
    ];
  }

  Widget _buildFeatureListTile({required IconData icon, required Color color, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 28),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }

  void _startPurchaseFlow(BuildContext context) {
    final S localizations = S.of(context)!; // CORREZIONE: Aggiunto '!'
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final S dialogLocalizations = S.of(dialogContext)!; // CORREZIONE: Aggiunto '!'
        return AlertDialog(
          title: Text(dialogLocalizations.workInProgressTitle),
          content: Text(dialogLocalizations.workInProgressContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(dialogLocalizations.okButton),
            )
          ],
        );
      },
    );
  }

  Future<void> _activateFreeTrial(BuildContext context) async {
    if (!mounted) return;
    final S localizations = S.of(context)!; // CORREZIONE: Aggiunto '!'
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.upgradePremiumLoginToActivateTrial)),
      );
      return;
    }

    final success = await PremiumManager.activateFreeTrial(user.uid);
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.upgradePremiumTrialActivatedSuccess)),
      );
      _loadStatus(); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.upgradePremiumTrialAlreadyUsedError)),
      );
       _loadStatus(); 
    }
  }
}