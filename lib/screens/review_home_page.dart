// Copyright 2025 Salvo00786 Jetpin. Tutti i diritti riservati.
// Per informazioni sulla licenza, vedere il file LICENSE.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/review.dart'; 
import '../widgets/review_card.dart'; 
import '../widgets/sticky_banner_ad.dart';
import '../services/auth_service.dart';
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:jetpin_app/utils/referral_manager.dart'; // << IMPORT PER REFERRAL_MANAGER

import 'package:jetpin_app/l10n/app_localizations.dart';

class ReviewHomePage extends StatefulWidget {
  const ReviewHomePage({super.key});

  @override
  State<ReviewHomePage> createState() => _ReviewHomePageState();
}

class _ReviewHomePageState extends State<ReviewHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  String _searchTerm = '';
  RewardedAd? _rewardedAd;
  DateTime? adsDisabledUntil;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
    _loadAdPrefs();
    _checkCloudAdStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkFirstLoginReferral();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _referralController.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  Future<void> _checkFirstLoginReferral() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || !mounted) return;

    final S localizations = S.of(context)!;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final userData = userDoc.exists ? userDoc.data() as Map<String, dynamic>? : null;
    final isNew = user.metadata.creationTime?.millisecondsSinceEpoch == user.metadata.lastSignInTime?.millisecondsSinceEpoch;
    
    // Controlla se 'referredBy' è già stato impostato, oltre a 'usedReferral'.
    // 'usedReferral' potrebbe essere un vecchio campo, 'referredBy' è quello impostato da ReferralManager.
    final hasAlreadyBeenReferred = userData?['referredBy'] != null || userData?['usedReferral'] != null;


    if (isNew && !hasAlreadyBeenReferred && mounted) {
      final referralCode = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          final S dialogLocalizations = S.of(dialogContext)!;
          return AlertDialog(
            title: Text(dialogLocalizations.referralDialogTitle),
            content: TextField(
              controller: _referralController,
              decoration: InputDecoration(labelText: dialogLocalizations.referralDialogHint),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(null),
                child: Text(dialogLocalizations.referralDialogSkipButton),
              ),
              ElevatedButton(
                onPressed: () {
                  final code = _referralController.text.trim();
                  Navigator.of(dialogContext).pop(code);
                },
                child: Text(dialogLocalizations.referralDialogConfirmButton),
              ),
            ],
          );
        },
      );

      if (!mounted || referralCode == null || referralCode.isEmpty) {
        // Se l'utente chiude il dialogo (referralCode == null) o non inserisce nulla (referralCode.isEmpty),
        // non mostrare messaggi di errore, semplicemente non si applica il referral.
        // Mostra errore solo se il codice è palesemente invalido dopo un tentativo.
        // Questa parte era già gestita sotto, quindi qui si esce silenziosamente.
        return;
      }

      if (referralCode == user.uid) { // Auto-referral
        if (mounted) {
          _showSnackBar(localizations.referralInvalidCode);
        }
        return;
      }
      
      // --- INTEGRAZIONE DI REFERRALMANAGER.APPLYREFERRAL ---
      _showLoadingDialog(localizations.loadingText); // Mostra caricamento

      bool appliedSuccessfully = await ReferralManager.applyReferral(referralCode, user.uid);
      
      _closeLoadingDialog(); // Chiudi caricamento

      if (mounted) {
        if (appliedSuccessfully) {
          _showSnackBar(localizations.referralSuccess);
          // Non c'è bisogno di aggiornare manualmente i conteggi qui (es. addExtraSlots, update adsDisabledUntil)
          // perché ReferralManager.applyReferral chiama già PremiumManager.activateFreeTrial
          // e PremiumManager.checkAndUnlockRewards(referrerId) che gestiscono i bonus.
          // _checkCloudAdStatus() e setState() potrebbero essere utili per riflettere immediatamente
          // lo stato premium/ads se il referral concede questi benefici direttamente e sono locali.
          // Per ora, il messaggio di successo è sufficiente, i dati si sincronizzeranno.
           if (mounted) setState((){}); // Per forzare un refresh della UI se necessario
        } else {
          // ReferralManager.applyReferral potrebbe fallire se l'invitante non esiste
          // o se il nuovo utente ha già un 'referredBy'.
          // ReferralManager stampa già errori in console.
          // Possiamo mostrare un messaggio più generico qui o uno specifico se ReferralManager
          // restituisse codici di errore più granulari.
          // Il controllo 'inviterDoc.exists' è ora implicito in applyReferral.
           _showSnackBar(localizations.referralApplyGeneralError); // NUOVA CHIAVE ARB
        }
      }
      // La vecchia logica manuale per addExtraSlots, inviterRef.set, ecc. qui sotto
      // è ora gestita da ReferralManager.applyReferral.
      // --- FINE INTEGRAZIONE ---
    }
  }

  Future<void> _loadAdPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('ads_disabled_until');
    if (saved != null && mounted) {
      setState(() {
        adsDisabledUntil = DateTime.tryParse(saved);
      });
    }
  }

  Future<void> _checkCloudAdStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    String? cloudDateStr;
    if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        cloudDateStr = data?['adsDisabledUntil'] as String?;
    }

    if (cloudDateStr != null) {
      final cloudDate = DateTime.tryParse(cloudDateStr);
      final prefs = await SharedPreferences.getInstance();
      final localDateStr = prefs.getString('ads_disabled_until');
      final localDate = localDateStr != null ? DateTime.tryParse(localDateStr) : null;

      if (cloudDate != null && (localDate == null || cloudDate.isAfter(localDate))) {
        await prefs.setString('ads_disabled_until', cloudDate.toIso8601String());
        if (mounted) {
          setState(() {
            adsDisabledUntil = cloudDate;
          });
        }
      }
    }
  }

  Future<void> _setAdsDisabled(Duration duration) async {
    final newAdsDisabledUntil = DateTime.now().add(duration);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ads_disabled_until', newAdsDisabledUntil.toIso8601String());
    if (mounted) {
      setState(() {
        adsDisabledUntil = newAdsDisabledUntil;
      });
    }
  }

  bool get _adsDisabled {
    if (adsDisabledUntil == null) return false;
    return DateTime.now().isBefore(adsDisabledUntil!);
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() { _rewardedAd = ad; });
          } else {
            ad.dispose();
          }
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

   void _showRewardedAd() async {
    if (!mounted || _rewardedAd == null) return;
    final S localizations = S.of(context)!;
    
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        _loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _loadRewardedAd();
      },
    );

    await _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      // Logica ricompensa (es. disabilitare annunci o dare slot)
      final user = FirebaseAuth.instance.currentUser;
      const int slotsEarned = 3; // Esempio, potrebbe essere diverso
      if (user != null) {
        await PremiumManager.addExtraSlots(user.uid, slotsEarned); // Assumendo che la ricompensa siano slot
         if (mounted) _showSnackBar(localizations.commonExtraSlotsGranted(slotsEarned));
      }
      await _setAdsDisabled(const Duration(minutes: 30));
      if(mounted) _showSnackBar(localizations.rewardedAdAdsDisabled(30));
    });
    _rewardedAd = null; // L'annuncio è stato usato
  }

  void _handleLogin() async {
    final user = await signInWithGoogle();
    if (!mounted) return;
    final S localizations = S.of(context)!;

    if (user != null) {
      _showSnackBar(localizations.loginWelcomeBack(user.displayName ?? localizations.guestUser));
      _checkCloudAdStatus();
      _checkFirstLoginReferral(); 
    } else {
      _showSnackBar(localizations.loginCancelled);
    }
    if (mounted) {
     setState(() {});
    }
  }

  void _handleLogout() async {
    await signOut();
    if (!mounted) return;
    if (mounted) {
      setState(() {});
    }
  }

  void _goToAddReview() async {
    final S localizations = S.of(context)!;
    final newReview = await Navigator.pushNamed(context, '/add-review');
    if (!mounted) return;
    if (newReview != null) {
      _showSnackBar(localizations.addReviewSuccess);
    }
  }
  
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  // Helper per dialoghi di caricamento
  void _showLoadingDialog(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const CircularProgressIndicator(), const SizedBox(width: 20), Text(message),
          ]),
        ),
      ),
    );
  }

  void _closeLoadingDialog() {
    if (mounted && Navigator.of(context).canPop()) { // Controlla se un dialogo è effettivamente aperto
      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final S localizations = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/jetpin_logo.png',
          height: 40,
          fit: BoxFit.contain,
           errorBuilder: (context, error, stackTrace) => Text(localizations.logoNotFoundErrorShort, style: const TextStyle(fontSize: 12, color: Colors.red))
        ),
        centerTitle: false,
        actions: [
          if (user == null)
            TextButton(onPressed: _handleLogin, child: Text(localizations.loginButton))
          else
            TextButton(onPressed: _handleLogout, child: Text(localizations.logoutButton)),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: !_adsDisabled && user != null ? 80.0 : 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          _searchTerm = value.toLowerCase().trim();
                        });
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: localizations.searchReviewsHint,
                      border: const OutlineInputBorder(),
                      suffixIcon: _searchTerm.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchTerm = '');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                if (!_adsDisabled && user != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: _rewardedAd != null ? _showRewardedAd : null,
                      icon: const Icon(Icons.video_collection),
                      label: Text(localizations.watchAdToDisableAdsButton),
                      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                    ),
                  ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('reviews')
                        .orderBy('date', descending: true)
                        .limit(50)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print("Errore StreamBuilder ReviewHomePage: ${snapshot.error}");
                        return Center(child: Text(localizations.errorLoadingData));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text(localizations.reviewSearchOverallNoReviews));
                      }

                      List<Review> allReviews = snapshot.data!.docs.map((doc) {
                        return Review.fromMap(doc.data() as Map<String, dynamic>, doc.id);
                      }).toList();

                      final List<Review> filteredReviews = _searchTerm.isEmpty
                          ? allReviews
                          : allReviews.where((review) {
                              return (review.airline.toLowerCase().contains(_searchTerm) ||
                                  review.flightNumber.toLowerCase().contains(_searchTerm) ||
                                  review.comment.toLowerCase().contains(_searchTerm) ||
                                  review.userName.toLowerCase().contains(_searchTerm));
                            }).toList();

                      if (filteredReviews.isEmpty && _searchTerm.isNotEmpty) {
                        return Center(child: Text(localizations.reviewSearchNoResults(_searchTerm)));
                      }
                       if (filteredReviews.isEmpty && _searchTerm.isEmpty) {
                        return Center(child: Text(localizations.reviewSearchOverallNoReviews));
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80.0, top: 0), 
                        itemCount: filteredReviews.length,
                        itemBuilder: (context, index) {
                          final review = filteredReviews[index];
                          return ReviewCard(review: review);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (!_adsDisabled && user != null)
            const Align(
              alignment: Alignment.bottomCenter,
              child: StickyBannerAd(),
            ),
          if (user != null)
            Positioned(
              bottom: !_adsDisabled && user != null ? 96.0 : 24.0,
              right: 24.0,
              child: FloatingActionButton(
                onPressed: _goToAddReview,
                tooltip: localizations.addReviewTooltip,
                child: const Icon(Icons.add),
              ),
            ),
        ],
      ),
    );
  }
}