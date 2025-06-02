import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jetpin_app/utils/premium_manager.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class PremiumPurchaseButton extends StatefulWidget {
  const PremiumPurchaseButton({super.key});

  @override
  State<PremiumPurchaseButton> createState() => _PremiumPurchaseButtonState();
}

class _PremiumPurchaseButtonState extends State<PremiumPurchaseButton> {
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _isIapAvailable = false;
  bool _isLoading = false;
  // Assicurati che questo ID prodotto sia corretto per i tuoi store
  static const String _productId = 'jetpin_premium_subscription_monthly'; // Esempio
  ProductDetails? _productDetails;
  late StreamSubscription<List<PurchaseDetails>> _purchaseSubscription;

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _purchaseSubscription = purchaseUpdated.listen(
      _handlePurchaseUpdate,
      onDone: () => _purchaseSubscription.cancel(),
      onError: (error) {
        debugPrint("Errore nello stream degli acquisti: $error");
        if (mounted && _isLoading) { // Resetta isLoading anche in caso di errore stream
          setState(() => _isLoading = false);
        }
      },
    );
    _initializeIap();
  }

  @override
  void dispose() {
    _purchaseSubscription.cancel();
    super.dispose();
  }

  Future<void> _initializeIap() async {
    final bool available = await _iap.isAvailable();
    if (!mounted) return;

    if (!available) {
      setState(() => _isIapAvailable = false);
      return;
    }

    final ProductDetailsResponse response = await _iap.queryProductDetails({_productId});
    if (!mounted) return;

    if (response.productDetails.isNotEmpty) {
      setState(() {
        _isIapAvailable = true;
        _productDetails = response.productDetails.firstWhere(
          (details) => details.id == _productId,
          // orElse: () => null, // Se potesse non essere trovato, ma queryProductDetails dovrebbe restituirlo se esiste
        );
      });
    } else {
      debugPrint("Nessun dettaglio prodotto trovato per ID: $_productId");
      setState(() => _isIapAvailable = false); 
    }
  }

  void _handlePurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        
        final String? uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          await PremiumManager.setPremium(true);
          await PremiumManager.syncPremiumFromCloud(uid); 
          debugPrint('✅ Acquisto Premium ($_productId) registrato e sincronizzato per $uid');
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetails);
          debugPrint('Acquisto completato per: ${purchaseDetails.productID}');
        }
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        debugPrint('Errore acquisto: ${purchaseDetails.error?.message}');
        if (mounted) {
          // CORREZIONE: Aggiunto '!'
          final S localizations = S.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.purchaseError(purchaseDetails.error?.message ?? 'Unknown error'))),
          );
        }
      } else if (purchaseDetails.status == PurchaseStatus.canceled) {
        debugPrint('Acquisto annullato: ${purchaseDetails.productID}');
        // Qui potresti voler mostrare un messaggio all'utente se lo desideri
      }
    }
    if (mounted && _isLoading) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _buyProduct(ProductDetails productDetails) async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    try {
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint("Errore durante l'avvio del flusso di acquisto: $e");
      if (mounted) {
        // CORREZIONE: Aggiunto '!'
        final S localizations = S.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.purchaseFlowStartError)),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _openStripeCheckout() async {
    const String stripeCheckoutUrl = 'https://jetpin.com/premium'; // URL Esempio
    final Uri url = Uri.parse(stripeCheckoutUrl);

    if (!mounted) return; // Controllo mounted prima di operazioni asincrone o che usano context
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Impossibile lanciare URL: $stripeCheckoutUrl');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.premiumPurchaseCannotLaunchUrl(stripeCheckoutUrl))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    if (!_isIapAvailable) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(localizations.premiumPurchaseNotAvailable, textAlign: TextAlign.center),
          ),
          OutlinedButton(
            onPressed: _isLoading ? null : _openStripeCheckout,
            child: _isLoading 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                : Text(localizations.premiumPurchaseButtonStripe),
          ),
        ],
      );
    }

    if (_productDetails == null) {
      // IAP disponibile ma dettagli prodotto non ancora caricati o prodotto specifico non trovato
      return const Center(child: CircularProgressIndicator());
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : () => _buyProduct(_productDetails!),
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0)),
          child: _isLoading
              ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white))
              : Text(localizations.premiumPurchaseButtonIAP(_productDetails!.price)),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: _isLoading ? null : _openStripeCheckout,
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12.0)),
          child: Text(localizations.premiumPurchaseButtonStripe),
        ),
      ],
    );
  }
}