import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Non ci sono stringhe UI da localizzare direttamente in questo file.
// Il contenuto dell'annuncio è fornito dal network pubblicitario.

class StickyBannerAd extends StatefulWidget {
  const StickyBannerAd({super.key});

  @override
  State<StickyBannerAd> createState() => _StickyBannerAdState();
}

class _StickyBannerAdState extends State<StickyBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  // L'ID dell'unità pubblicitaria dovrebbe essere gestito in modo sicuro,
  // ad esempio tramite variabili d'ambiente o un file di configurazione,
  // specialmente per le versioni di produzione.
  // Per ora, usiamo l'ID di test come nell'originale.
  static const String _testAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  // static const String _productionAdUnitId = 'IL_TUO_ID_UNITA_PUBBLICITARIA_REALE';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      // Sostituire con l'ID reale in produzione
      // adUnitId: kReleaseMode ? _productionAdUnitId : _testAdUnitId,
      adUnitId: _testAdUnitId,
      size: AdSize.banner, // Può essere const
      request: const AdRequest(), // Può essere const
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('BannerAd loaded.');
          if (mounted) { // Controlla se il widget è ancora montato
            setState(() {
              _isLoaded = true;
            });
          } else {
            // Se il widget non è più montato quando l'annuncio carica,
            // assicurati di disporre l'annuncio per evitare memory leak.
            (ad as BannerAd).dispose();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('BannerAd failed to load: $error');
          ad.dispose(); // Libera le risorse
          // Potresti voler tentare di ricaricare l'annuncio dopo un ritardo
          // o gestire l'errore in altro modo.
        },
        // Altri listener utili:
        // onAdOpened: (Ad ad) => print('BannerAd opened.'),
        // onAdClosed: (Ad ad) => print('BannerAd closed.'),
        // onAdImpression: (Ad ad) => print('BannerAd impression.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink(); // Non occupa spazio se non caricato
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // Il colore di sfondo è gestito dal banner stesso,
        // ma un Container può essere utile per stili o dimensioni fisse.
        // color: Colors.transparent, // Opzionale
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}