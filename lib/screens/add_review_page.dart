// screens/add_review_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/review.dart'; // Assicurati che importi la versione aggiornata
import '../services/review_service.dart';
import '../widgets/unlock_options_dialog.dart';
import '../ads/ad_manager.dart';
import '../utils/premium_manager.dart';
import '../utils/ad_frequency_manager.dart';
import 'package:jetpin_app/l10n/app_localizations.dart';

import '../utils/airline_data.dart'; // Importa i dati delle compagnie e la classe Airline

class AddReviewPage extends StatefulWidget {
  final Review? existingReview;

  const AddReviewPage({
    super.key,
    this.existingReview,
  });

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController _airlineNameController = TextEditingController(); // Controller per il nome
  Airline? _selectedAirline; // Per tenere traccia dell'oggetto Airline selezionato

  final _flightNumberController = TextEditingController();
  final _commentController = TextEditingController();
  final ReviewService _reviewService = ReviewService();
  final AdManager _adManager = AdManager();

  double _rating = 3.0;
  bool _isSaving = false;

  late Future<(bool isPremium, int extraSlots)> _userStatusFuture;
  bool _isPremiumCurrent = false;
  int _extraSlots = 0;

  bool _isEditMode = false;
  String? _editingReviewId;

  List<Airline> _airlineOptions = [];
  bool _isLoadingAirlines = true;
  final FocusNode _airlineFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _loadAirlineData();

    if (widget.existingReview != null) {
      _isEditMode = true;
      _editingReviewId = widget.existingReview!.id;
      _airlineNameController.text = widget.existingReview!.airline;
      // Il _selectedAirline verrà impostato in _loadAirlineData se c'è una corrispondenza
      _flightNumberController.text = widget.existingReview!.flightNumber;
      _commentController.text = widget.existingReview!.comment;
      _rating = widget.existingReview!.rating.toDouble();
    }

    _userStatusFuture = _reviewService.loadUserStatus().then((status) {
      if (mounted) {
        final isPremiumNow = status.$1;
        setState(() {
          _isPremiumCurrent = isPremiumNow;
          _extraSlots = status.$2;
        });
        if (!isPremiumNow && !_isEditMode) {
          print("[AddReviewPage] User is not premium, preloading interstitial ad in initState.");
          _adManager.preloadInterstitialAd(
            onAdLoaded: () => print("[AddReviewPage] Interstitial Ad preloaded."),
            onAdFailedToLoad: (String errorMessage) =>
                print("[AddReviewPage] Failed to preload Interstitial Ad: $errorMessage"));
        }
      }
      return status;
    });
  }

  Future<void> _loadAirlineData() async {
    setState(() => _isLoadingAirlines = true);
    _airlineOptions = await loadAirlinesData('assets/data/airlines.json');
    if (mounted) {
      setState(() {
        _isLoadingAirlines = false;
        if (_isEditMode && widget.existingReview != null) {
          final existingAirlineName = widget.existingReview!.airline;
          final existingAirlineIcao = widget.existingReview!.airlineIcao;
          try {
            // Prova prima con ICAO se disponibile e corrisponde a un'opzione
            if (existingAirlineIcao != null && existingAirlineIcao.isNotEmpty) {
                 _selectedAirline = _airlineOptions.firstWhere(
                    (airline) => airline.icao.toLowerCase() == existingAirlineIcao.toLowerCase() &&
                                 airline.name.toLowerCase() == existingAirlineName.toLowerCase(),
                  );
            } else { // Altrimenti cerca per nome
                 _selectedAirline = _airlineOptions.firstWhere(
                    (airline) => airline.name.toLowerCase() == existingAirlineName.toLowerCase(),
                 );
            }
            // Se selezionato, aggiorna il controller (sebbene dovrebbe già essere impostato)
            if (_selectedAirline != null) {
                 _airlineNameController.text = _selectedAirline!.name;
            }

          } catch (e) {
            print("Compagnia aerea esistente ('$existingAirlineName', ICAO: '$existingAirlineIcao') non trovata per preselezione: $e");
            _selectedAirline = null;
            // _airlineNameController.text rimane quello della recensione esistente
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _airlineNameController.dispose();
    _flightNumberController.dispose();
    _commentController.dispose();
    _airlineFocusNode.dispose();
    _adManager.disposeInterstitialAd();
    super.dispose();
  }

  bool _validateInputs() {
    if (_airlineNameController.text.trim().isEmpty) {
        // Se il campo è vuoto, non è valido
        return false;
    }
    // Se l'utente ha digitato qualcosa ma non ha selezionato un'opzione valida dall'autocomplete,
    // _selectedAirline potrebbe essere null o non corrispondere a _airlineNameController.text.
    // Decidi tu se vuoi permettere nomi di compagnie non presenti nella lista di autocompletamento.
    // Per ora, richiediamo solo che il campo non sia vuoto e che il numero di volo sia presente.
    // if (_selectedAirline == null || _selectedAirline!.name != _airlineNameController.text.trim()) {
    //   print("Attenzione: il nome della compagnia aerea inserito non corrisponde a una selezione valida.");
    //   // Potresti mostrare un errore o resettare _selectedAirline a null.
    //   // Per ora permettiamo anche testo libero, ma _selectedAirline.icao sarà null.
    // }
    return _flightNumberController.text.trim().isNotEmpty;
  }

  Future<void> _showAdAndPop(Review review) async {
    // (Codice invariato)
    final bool currentPremiumStatus = await PremiumManager.isPremium();
    if (!currentPremiumStatus && await AdFrequencyManager.canShowGenericInterstitial()) {
      print("[AddReviewPage] Attempting to show Interstitial Ad before pop.");
      _adManager.showInterstitialAdIfReady();
      await AdFrequencyManager.recordGenericInterstitialShown();
      await Future.delayed(const Duration(milliseconds: 700));
    }
    if (mounted) {
      Navigator.pop(context, review);
    }
  }

  Future<void> _submitReview() async {
    final S localizations = S.of(context)!;
    if (_isSaving) return;

    if (!_validateInputs()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.addReviewFillAllFields)),
        );
      }
      return;
    }

    final String airlineName = _airlineNameController.text.trim();
    // Se l'utente ha modificato il testo dopo una selezione, _selectedAirline potrebbe non essere più accurato.
    // Ricerchiamo l'opzione corrispondente al testo attuale per essere sicuri.
    Airline? currentSelectedAirline = _selectedAirline;
    if (currentSelectedAirline == null || currentSelectedAirline.name.toLowerCase() != airlineName.toLowerCase()){
        try {
            currentSelectedAirline = _airlineOptions.firstWhere((opt) => opt.name.toLowerCase() == airlineName.toLowerCase());
        } catch (e) {
            currentSelectedAirline = null; // Nessuna corrispondenza esatta trovata, l'ICAO sarà null
            print("Nessuna corrispondenza esatta per '$airlineName' nell'elenco, ICAO non sarà salvato.");
        }
    }
    final String? airlineIcao = currentSelectedAirline?.icao;


    if (mounted) setState(() => _isSaving = true);

    if (_isEditMode) {
      if (_editingReviewId == null || widget.existingReview == null) {
        _endSaving();
        return;
      }
      final updatedReview = Review(
        id: _editingReviewId!,
        airline: airlineName,
        airlineIcao: airlineIcao, // SALVA L'ICAO
        flightNumber: _flightNumberController.text.trim(),
        rating: _rating.toInt(),
        comment: _commentController.text.trim(),
        userId: widget.existingReview!.userId,
        userName: widget.existingReview!.userName, // Considerare se aggiornare il nome utente
        date: widget.existingReview!.date,
        helpfulCount: widget.existingReview!.helpfulCount,
      );

      bool success = await _reviewService.updateReview(_editingReviewId!, updatedReview, context);
      _endSaving();

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(localizations.reviewEditedSuccessMessage)));
          Navigator.pop(context, updatedReview);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(localizations.errorUpdatingReview)));
        }
      }
    } else {
      // Modalità Creazione
      final review = Review( // Costruiamo direttamente Review per includere airlineIcao
        airline: airlineName,
        airlineIcao: airlineIcao, // SALVA L'ICAO
        flightNumber: _flightNumberController.text.trim(),
        rating: _rating.toInt(),
        comment: _commentController.text.trim(),
        userId: FirebaseAuth.instance.currentUser?.uid ?? 'anonymous', // Gestisci utente non loggato
        userName: FirebaseAuth.instance.currentUser?.displayName ?? localizations.anonymousUser,
        date: DateTime.now(),
        helpfulCount: 0,
      );
      
      if (review.userId == 'anonymous' && FirebaseAuth.instance.currentUser == null) {
         // Prova a fare un login anonimo se necessario, o mostra un messaggio
         User? user = await _reviewService.ensureUserSignedIn();
         if (user == null) {
            if (mounted) {
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(localizations.errorUserNotLoggedInOrReviewBuildFailed)));
            }
            _endSaving();
            return;
         }
         // Se il login anonimo ha successo, potresti voler aggiornare review.userId e review.userName se il modello Review è immutabile
         // Per ora, assumiamo che buildReviewFromCurrentUser gestisca il login anonimo o che l'utente sia loggato.
         // La logica sopra ora gestisce direttamente il currentUser.
      }


      final result = await _reviewService.saveReview(
        context: context,
        review: review, // Passa la review direttamente
        isPremium: _isPremiumCurrent,
        extraSlots: _extraSlots,
        onSlotConsumed: (updatedSlots) {
          if (mounted) setState(() => _extraSlots = updatedSlots);
        },
      );

      if (!mounted) {
         _endSaving();
         return;
      }

      if (result == 'LIMIT_REACHED') {
        _endSaving();
        await _handleLimitReached(review.userId);
      } else if (result == null) {
        await _showAdAndPop(review);
        _endSaving();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
        _endSaving();
      }
    }
  }

  void _endSaving() {
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _handleLimitReached(String uid) async {
    // (Codice invariato)
     if (!mounted) return;
    final S localizations = S.of(context)!;

    await showUnlockOptionsDialog(
      context,
      onVideoUnlock: () async {
        final (_, updatedSlots) = await _reviewService.loadUserStatus();
        if (mounted) {
          setState(() => _extraSlots = updatedSlots);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.commonExtraSlotsGranted(3))),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;

    return WillPopScope(
      onWillPop: () async => !_isSaving,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditMode ? localizations.addReviewUpdatePageTitle : localizations.addReviewAppBarTitle),
        ),
        body: FutureBuilder<(bool isPremium, int extraSlots)>(
          future: _userStatusFuture,
          builder: (context, userStatusSnapshot) {
            if ((userStatusSnapshot.connectionState == ConnectionState.waiting || _isLoadingAirlines) && !_isEditMode) {
              return const Center(child: CircularProgressIndicator());
            }
            if (userStatusSnapshot.hasError && !_isEditMode) {
              return Center(child: Text(localizations.errorLoadingData));
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Autocomplete<Airline>(
                        fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController,
                                            FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                          // Assegna il controller e il focus node qui
                          // Questo è importante per far sì che il controller di Autocomplete sia lo stesso di _airlineNameController
                          // e per poter controllare il focus.
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                             if (_airlineNameController != fieldTextEditingController) {
                                // Sincronizza se sono diversi, anche se Autocomplete dovrebbe usare il controller fornito
                             }
                             if (_airlineFocusNode != fieldFocusNode) {
                                // Assegna il focus node
                             }
                          });
                          return TextField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            decoration: InputDecoration(
                              labelText: localizations.addReviewAirlineHint,
                              border: const OutlineInputBorder(),
                              suffixIcon: _isLoadingAirlines
                                ? const Padding(padding: EdgeInsets.all(10.0), child: SizedBox(width: 20, height: 20, child:CircularProgressIndicator(strokeWidth: 2)))
                                : (_airlineNameController.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: (){
                                    fieldTextEditingController.clear();
                                    setState(() {
                                      _selectedAirline = null;
                                    });
                                }) : null),
                            ),
                            textInputAction: TextInputAction.next,
                             onChanged: (text) {
                                // Se l'utente modifica il testo, _selectedAirline potrebbe non essere più valido
                                // Potresti voler resettare _selectedAirline qui se il testo non corrisponde più
                                if (_selectedAirline != null && _selectedAirline!.name != text) {
                                   setState(() {
                                     _selectedAirline = null;
                                   });
                                }
                             },
                          );
                        },
                        initialValue: TextEditingValue(text: _airlineNameController.text), // Usa il testo del controller
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (_isLoadingAirlines) {
                            // Non mostrare opzioni se stiamo caricando, il suffixIcon lo indica
                            return const Iterable<Airline>.empty();
                          }
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<Airline>.empty();
                          }
                          return _airlineOptions.where((Airline option) {
                            return option.name.toLowerCase().contains(textEditingValue.text.toLowerCase()) ||
                                   (option.iata?.toLowerCase().contains(textEditingValue.text.toLowerCase()) ?? false) ||
                                   option.icao.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        displayStringForOption: (Airline option) => option.name,
                        onSelected: (Airline selection) {
                          print('Selezionato: ${selection.name} (ICAO: ${selection.icao})');
                          setState(() {
                            _selectedAirline = selection;
                            _airlineNameController.text = selection.name; // Aggiorna il nostro controller
                          });
                           _airlineFocusNode.unfocus(); // Togli il focus dopo la selezione
                           // Vai al campo successivo
                           FocusScope.of(context).nextFocus();
                        },
                        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Airline> onSelected, Iterable<Airline> options) {
                           return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 250, maxWidth: MediaQuery.of(context).size.width - 48),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final Airline option = options.elementAt(index);
                                    return ListTile(
                                      title: Text(option.name),
                                      subtitle: Text("${option.icao} ${option.iata != null ? '/ ${option.iata}' : ''}"),
                                      onTap: () {
                                        onSelected(option);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _flightNumberController,
                        decoration: InputDecoration(
                          labelText: localizations.addReviewFlightNumberHint,
                          border: const OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text(localizations.addReviewRatingLabel, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 16.0),
                          RatingBar.builder(
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 32.0,
                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              setState(() => _rating = rating);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          labelText: localizations.addReviewCommentHint,
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _isSaving ? null : _submitReview(),
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton.icon(
                        onPressed: _isSaving ? null : _submitReview,
                        icon: _isSaving
                            ? Container(
                                width: 20, height: 20,
                                margin: const EdgeInsets.only(right: 8),
                                child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : Icon(_isEditMode ? Icons.edit_note : Icons.save),
                        label: Text(_isEditMode ? localizations.addReviewUpdateButton : localizations.addReviewSaveButton),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      if (!_isEditMode && !_isPremiumCurrent && _extraSlots > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            localizations.addReviewExtraSlotsAvailable(_extraSlots),
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                if (_isSaving)
                  Container(
                    color: Colors.black.withOpacity(0.26),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}