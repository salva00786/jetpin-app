// lib/ads/ad_manager.dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// Gli import di premium_manager e firebase_auth sono ora decommentati
import 'package:jetpin_app/utils/premium_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Import per la localizzazione
// Assicurati che questo path sia corretto per il tuo file S generato
import 'package:jetpin_app/l10n/app_localizations.dart';

class AdManager {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _isInterstitialLoading = false;
  bool _isInterstitialAdReady = false;

  // ID Annunci (Usa i tuoi ID di produzione quando rilasci)
  // Per ora, usiamo gli ID di test.
  static const String _testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';

  AdManager() {
    print("[AdManager] Instance created.");
    // Potresti voler pre-caricare un interstitial all'istanziazione
    // se appropriato per la tua app, ad esempio:
    // preloadInterstitialAd();
  }

  /// Pre-carica un annuncio interstitial.
  ///
  /// [onAdLoaded] viene chiamato quando l'annuncio è caricato con successo.
  /// [onAdFailedToLoad] viene chiamato se il caricamento fallisce, passando un messaggio di errore.
  void preloadInterstitialAd({
    VoidCallback? onAdLoaded,
    Function(String errorMessage)? onAdFailedToLoad // MODIFICATO: Accetta una stringa per il messaggio di errore
  }) {
    if (_isInterstitialAdReady || _isInterstitialLoading) {
      print("[AdManager] PreloadInterstitialAd: Ad already ready or loading.");
      // Se è già pronto e onAdLoaded è fornito, eseguilo.
      // È buona norma chiamarlo in un post-frame callback se modifica lo stato della UI
      // per evitare errori durante il build.
      if (_isInterstitialAdReady && onAdLoaded != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_isInterstitialAdReady) { // Ricontrolla, lo stato potrebbe essere cambiato
            onAdLoaded();
          }
        });
      }
      return;
    }
    _isInterstitialLoading = true;
    print("[AdManager] Preloading Interstitial Ad...");

    InterstitialAd.load(
      adUnitId: _testInterstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('[AdManager] InterstitialAd loaded successfully: ${ad.adUnitId}');
          _interstitialAd?.dispose(); // Dispone l'annuncio precedente se esistente
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          _isInterstitialLoading = false;
          _setupInterstitialAdCallbacks();
          onAdLoaded?.call();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('[AdManager] InterstitialAd failed to load: $error');
          _interstitialAd = null; // Assicura che sia null
          _isInterstitialAdReady = false;
          _isInterstitialLoading = false;
          onAdFailedToLoad?.call(error.message); // MODIFICATO: Passa error.message alla callback
        },
      ),
    );
  }

  void _setupInterstitialAdCallbacks() {
    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print('[AdManager] InterstitialAd showed.');
        // L'annuncio è stato mostrato, resettiamo _isInterstitialAdReady
        // e l'annuncio stesso, per forzare un nuovo caricamento la prossima volta.
        _isInterstitialAdReady = false;
        // _interstitialAd = null; // Non annullare qui, ad.dispose() lo farà
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('[AdManager] InterstitialAd dismissed.');
        ad.dispose();
        _interstitialAd = null;
        _isInterstitialAdReady = false;
        // Opzionale: carica il prossimo annuncio qui se la tua logica lo richiede
        // preloadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('[AdManager] InterstitialAd failed to show: $error');
        ad.dispose();
        _interstitialAd = null;
        _isInterstitialAdReady = false;
      },
    );
  }

  /// Mostra l'annuncio interstitial se è pronto.
  void showInterstitialAdIfReady() {
    if (_interstitialAd != null && _isInterstitialAdReady) {
      print('[AdManager] Showing Interstitial Ad.');
      _interstitialAd!.show();
      // _isInterstitialAdReady sarà impostato a false e _interstitialAd a null
      // nei callback onAdShowedFullScreenContent o onAdDismissedFullScreenContent.
    } else {
      print('[AdManager] Interstitial ad not ready or null. Consider preloading.');
      // Se non è pronto e non sta già caricando, tenta un caricamento per la prossima volta.
      if (!_isInterstitialLoading) {
         preloadInterstitialAd();
      }
    }
  }

  /// Carica e mostra un annuncio con premio.
  ///
  /// [context] è necessario per S.of(context) e ScaffoldMessenger.
  /// [onReward] viene chiamato quando l'utente guadagna il premio.
  /// [onAdFailedToLoad] (NUOVO) viene chiamato se il caricamento dell'annuncio fallisce, passando un messaggio di errore.
  /// [onAdFailedToShow] (NUOVO) viene chiamato se l'annuncio carica ma non riesce a mostrarsi.
  void showRewardedAd({
    required BuildContext context,
    VoidCallback? onReward,
    Function(String message)? onAdFailedToLoad, // Callback per fallimento caricamento
    Function(String message)? onAdFailedToShow, // Callback per fallimento visualizzazione
  }) {
    // Assicurati che S.of(context) sia disponibile e non nullo
    final S? localizations = S.of(context);
    if (localizations == null) {
      print("[AdManager] ERRORE: Localizations (S) non disponibili per showRewardedAd.");
      // Potresti voler chiamare onAdFailedToLoad o onAdFailedToShow con un messaggio di errore interno.
      onAdFailedToLoad?.call("Errore interno: localizzazioni non disponibili.");
      return;
    }

    print("[AdManager] Attempting to load Rewarded Ad...");
    RewardedAd.load(
      adUnitId: _testRewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('[AdManager] RewardedAd loaded.');
          _rewardedAd?.dispose(); // Dispone il precedente se esistente
          _rewardedAd = ad;

          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) => print('[AdManager] RewardedAd showed.'),
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('[AdManager] RewardedAd dismissed.');
              ad.dispose();
              _rewardedAd = null;
              // Potrebbe essere utile ricaricare un altro rewarded ad qui se la logica lo prevede
              // loadRewardedAd(); // Se crei una funzione separata per il solo caricamento
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('[AdManager] RewardedAd failed to show: $error');
              ad.dispose();
              _rewardedAd = null;
              onAdFailedToShow?.call(error.message); // Chiama la callback specifica
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(localizations.rewardVideoShowError)),
                );
              }
            },
          );

          // Mostra l'annuncio
          _rewardedAd!.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
              print('[AdManager] User earned reward. Type: ${reward.type}, Amount: ${reward.amount}');

              // Esempio di logica ricompensa:
              const int slotsEarned = 3; // Questo potrebbe dipendere da reward.amount se configurato
              final user = FirebaseAuth.instance.currentUser; // Assicurati che FirebaseAuth sia disponibile se necessario
              if (user != null) {
                  // Assicurati che PremiumManager sia accessibile e la sua logica corretta
                  await PremiumManager.addExtraSlots(user.uid, slotsEarned);
                   if (context.mounted) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(localizations.commonExtraSlotsGranted(slotsEarned))),
                     );
                   }
              } else {
                  print("[AdManager] Utente non loggato, ricompensa non applicata a Firestore.");
              }
              onReward?.call(); // Chiama la callback generica onReward
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('[AdManager] RewardedAd failed to load: $error');
          _rewardedAd = null; // Assicura che sia null
          onAdFailedToLoad?.call(error.message); // Chiama la callback specifica
          if (context.mounted) { // Mostra comunque lo snackbar generico
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.rewardVideoLoadError)),
            );
          }
        },
      ),
    );
  }

  /// Dispone l'annuncio interstitial corrente.
  void disposeInterstitialAd() {
    print("[AdManager] Disposing Interstitial Ad.");
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isInterstitialAdReady = false; // Resetta lo stato
    _isInterstitialLoading = false; // Resetta lo stato
  }

  /// Dispone l'annuncio rewarded corrente.
  void disposeRewardedAd() {
    print("[AdManager] Disposing Rewarded Ad.");
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}