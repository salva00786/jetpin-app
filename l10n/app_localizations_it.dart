// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'JetPin';

  @override
  String get navigationReviews => 'Recensioni';

  @override
  String get navigationMyReviews => 'Le mie';

  @override
  String get navigationProfile => 'Profilo';

  @override
  String get logoNotFoundError => '⚠️ Logo non trovato';

  @override
  String get logoNotFoundErrorShort => 'Errore Logo';

  @override
  String commonExtraSlotsGranted(Object count) {
    return '🎉 $count slot extra sbloccati!';
  }

  @override
  String get rewardVideoLoadError => '⚠️ Errore nel caricamento del video';

  @override
  String get rewardVideoShowError =>
      '⚠️ Errore nella visualizzazione del video';

  @override
  String get referralDialogTitle => 'Hai un codice invito?';

  @override
  String get referralDialogHint => 'Codice invito (UID)';

  @override
  String get referralDialogSkipButton => 'Salta';

  @override
  String get referralDialogConfirmButton => 'Conferma';

  @override
  String get referralInvalidCode => 'Codice invito non valido o auto-riferito.';

  @override
  String get referralInviterNotFound => 'Codice invito non trovato.';

  @override
  String get referralSuccess => '🎉 Bonus ricevuto grazie al codice invito!';

  @override
  String rewardedAdAdsDisabled(Object minutes) {
    return '🎉 Pubblicità disattivate per $minutes minuti!';
  }

  @override
  String loginWelcomeBack(Object userName) {
    return 'Bentornato, $userName!';
  }

  @override
  String get guestUser => 'utente';

  @override
  String get anonymousUser => 'Anonimo';

  @override
  String get loginCancelled => 'Login annullato.';

  @override
  String get addReviewSuccess => 'Recensione aggiunta!';

  @override
  String get searchReviewsHint => 'Cerca recensioni...';

  @override
  String get watchAdToDisableAdsButton =>
      'Guarda un video per rimuovere gli annunci';

  @override
  String get reviewListPlaceholder =>
      'Qui verranno visualizzate le recensioni...';

  @override
  String get addReviewTooltip => 'Aggiungi recensione';

  @override
  String get loginButton => 'Login';

  @override
  String get logoutButton => 'Logout';

  @override
  String get addReviewAppBarTitle => 'Aggiungi Recensione';

  @override
  String get addReviewFillAllFields => 'Compila tutti i campi obbligatori.';

  @override
  String get addReviewAirlineHint => 'Compagnia aerea';

  @override
  String get addReviewFlightNumberHint => 'Numero volo';

  @override
  String get addReviewRatingLabel => 'Valutazione';

  @override
  String get addReviewCommentHint => 'Commento (opzionale)';

  @override
  String get addReviewSaveButton => 'Salva recensione';

  @override
  String addReviewExtraSlotsAvailable(Object count) {
    return '🎁 Hai $count recensioni extra disponibili!';
  }

  @override
  String get errorLoadingData => 'Errore durante il caricamento dei dati.';

  @override
  String get noDataAvailable => 'Nessun dato disponibile.';

  @override
  String get myReviewsAppBarTitle => 'Le mie recensioni';

  @override
  String get myReviewsLoginPrompt =>
      'Effettua il login per vedere le tue recensioni.';

  @override
  String get myReviewsAdvancedFiltersButton => 'Filtri Avanzati';

  @override
  String get myReviewsStatsButton => 'Statistiche';

  @override
  String get myReviewsNoReviews => 'Non hai ancora scritto recensioni.';

  @override
  String get myReviewsSmartModalTitle => 'Scopri il tuo impatto!';

  @override
  String myReviewsSmartModalContent(Object airlineName, Object count) {
    return 'Hai recensito $count voli con $airlineName. Con Premium puoi vedere l’impatto del tuo punteggio su questa compagnia!';
  }

  @override
  String get myReviewsSmartModalLaterButton => 'Non ora';

  @override
  String get myReviewsSmartModalDiscoverButton => 'Scopri Premium';

  @override
  String get profileAppBarTitle => 'Profilo';

  @override
  String get profileTabLabel => 'Profilo';

  @override
  String get profileTabPremiumLabel => 'Solo per Premium';

  @override
  String get profileNotLoggedIn =>
      'Non sei loggato. Effettua il login per vedere il tuo profilo.';

  @override
  String get profileWelcomeMessage =>
      'Benvenuto in JetPin!\n\nQui verranno mostrate le info utente e attività recenti.';

  @override
  String profilePremiumTrialExpiresSoon(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'giorni',
      one: 'giorno',
    );
    return '⏳ La tua prova gratuita scade tra $days $_temp0!';
  }

  @override
  String profileBadgeLegend(Object count) {
    return '👑 Leggenda JetPin ($count+ amici)';
  }

  @override
  String profileBadgeInfluencer(Object count) {
    return '🚀 Influencer JetPin ($count+ amici)';
  }

  @override
  String profileBadgePromoter(Object count) {
    return '🎉 Super Promotore ($count+ amici)';
  }

  @override
  String get profileBadgeUsedReferral =>
      '🏡 Hai ricevuto un bonus da un invito!';

  @override
  String profileReferralCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'amici',
      one: 'amico',
    );
    return 'Hai invitato $count $_temp0!';
  }

  @override
  String profileExtraSlots(Object count) {
    return 'Hai ricevuto $count slot bonus in totale!';
  }

  @override
  String get profileUnlockedRewardsTitle => 'Ricompense sbloccate:';

  @override
  String get profileInviteMoreForBadges =>
      '🎯 Invita altri amici per sbloccare nuovi badge!';

  @override
  String get profileErrorLoadingPremium =>
      'Errore nel caricamento dello stato Premium.';

  @override
  String get profileUserIsPremium => 'Utente Premium';

  @override
  String profilePremiumTrialDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'giorni rimanenti',
      one: 'giorno rimanente',
    );
    return '🏡 Prova gratuita: $days $_temp0';
  }

  @override
  String get profileBackupComplete => 'Backup completato';

  @override
  String get profileBackupCloudButton => 'Backup su cloud';

  @override
  String profileLastBackupDate(Object dateTime) {
    return '☁️ Ultimo backup: $dateTime';
  }

  @override
  String get atTimeConnector => 'alle';

  @override
  String get profileAdvancedStatsButton => 'Statistiche avanzate';

  @override
  String profileShareInviteMessage(Object referralCode) {
    return 'Unisciti a JetPin! Inserisci questo codice invito ($referralCode) per ricevere bonus speciali!';
  }

  @override
  String get profileShareInviteButton => 'Invita un amico';

  @override
  String get profileWhatIsPremiumButton => 'Cos\'è JetPin Premium?';

  @override
  String get profileLogoutDialogTitle => 'Vuoi davvero uscire?';

  @override
  String get profileLogoutDialogContent =>
      'Perderai l\'accesso alle funzioni disponibili solo per utenti loggati.';

  @override
  String get profileLogoutSuccess => 'Logout effettuato.';

  @override
  String get premiumTabTitle => 'JetPin Premium';

  @override
  String get premiumFeatureNoAds => 'Nessuna pubblicità';

  @override
  String get premiumFeatureUnlimitedPins => 'Recensioni illimitate';

  @override
  String get premiumFeatureCloudBackup => 'Backup automatico su cloud';

  @override
  String get premiumFeatureFlightTracking =>
      'Tracking voli e itinerari (Prossimamente)';

  @override
  String get premiumFeatureAiFeatures => 'Funzionalità AI (Prossimamente)';

  @override
  String get premiumFeatureSmartItineraries =>
      'Itinerari intelligenti (Prossimamente)';

  @override
  String get premiumFeatureSuperCreatorBadge => 'Badge Super Creator';

  @override
  String get premiumTabDiscoverButton => 'Scopri Premium';

  @override
  String get upgradePremiumAppBarTitle => 'Passa a Premium';

  @override
  String get loadingText => 'Caricamento...';

  @override
  String get upgradePremiumAlreadyPremium => '✅ Sei già un utente Premium!';

  @override
  String get goBackButton => 'Torna indietro';

  @override
  String get upgradePremiumLimitReachedTitle =>
      '🚫 Hai raggiunto i limiti del tuo account gratuito.';

  @override
  String get upgradePremiumBenefitPrompt =>
      'Passa a JetPin Premium per sbloccare tutte le funzioni!';

  @override
  String get upgradePremiumFeaturesTitle => '💎 Cosa ottieni con Premium';

  @override
  String get premiumFeatureUnlimitedPinsDesc =>
      'Aggiungi tutte le recensioni che vuoi, senza limiti.';

  @override
  String get premiumFeatureExportPdf => 'Esporta Recensioni';

  @override
  String get premiumFeatureExportPdfDesc =>
      'Conserva e condividi le tue recensioni in formato PDF.';

  @override
  String get premiumFeatureDetailedStats => 'Statistiche Dettagliate';

  @override
  String get premiumFeatureDetailedStatsDesc =>
      'Comprendi l’impatto delle tue valutazioni.';

  @override
  String get premiumFeatureCloudBackupDesc =>
      'Proteggi i tuoi dati con backup automatici nel cloud.';

  @override
  String upgradePremiumTrialActiveDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'giorni rimanenti',
      one: 'giorno rimanente',
    );
    return '📆 Prova gratuita attiva: hai $days $_temp0.';
  }

  @override
  String get upgradePremiumTrialAvailable =>
      'Hai diritto alla prova gratuita di 7 giorni!';

  @override
  String get upgradePremiumActivateTrialButton =>
      'Attiva la prova gratuita (7 giorni)';

  @override
  String get upgradePremiumTrialNoCharge =>
      '🔒 Nessun addebito prima della scadenza della prova.';

  @override
  String get upgradePremiumTrialUsed =>
      'Hai già utilizzato la tua prova gratuita.';

  @override
  String get upgradePremiumActivateButton => 'Attiva Premium Ora';

  @override
  String priceInfo(Object billingPeriod, Object price) {
    return '$price$billingPeriod';
  }

  @override
  String get priceValue => '€4.99';

  @override
  String get billingPeriodMonthly => '/mese';

  @override
  String get cancelAnytime => 'cancellazione in ogni momento';

  @override
  String upgradePremiumPriceInfoFull(
      Object cancellationPolicy, Object formattedPriceInfo) {
    return '$formattedPriceInfo — $cancellationPolicy';
  }

  @override
  String get workInProgressTitle => 'Work in Progress';

  @override
  String get workInProgressContent =>
      'L\'acquisto reale sarà disponibile nella versione finale dell\'app.';

  @override
  String get okButton => 'OK';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get applyButton => 'Applica';

  @override
  String get closeButton => 'Chiudi';

  @override
  String get yesButton => 'Sì';

  @override
  String get noButton => 'No';

  @override
  String get logout => 'Logout';

  @override
  String get upgradePremiumLoginToActivateTrial =>
      'Effettua il login per attivare la prova gratuita.';

  @override
  String get upgradePremiumTrialActivatedSuccess =>
      '🎉 Prova gratuita attivata! Goditi JetPin Premium.';

  @override
  String get upgradePremiumTrialAlreadyUsedError =>
      'Errore: la prova gratuita è già stata utilizzata o non è stato possibile attivarla.';

  @override
  String get notificationChannelName => 'Promemoria JetPin';

  @override
  String get notificationChannelDescription =>
      'Promemoria e notifiche importanti dall\'app JetPin.';

  @override
  String get notificationPermissionDialogTitle => 'Permessi Notifica';

  @override
  String get notificationPermissionDialogContent =>
      'JetPin vorrebbe inviarti notifiche per promemoria utili e aggiornamenti. Vuoi abilitarli?';

  @override
  String get reviewLimitWarningTitle => '📢 Attenzione Limite Recensioni!';

  @override
  String reviewLimitWarningBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'recensioni',
      one: 'recensione',
    );
    return 'Hai quasi raggiunto il limite gratuito. Ti rimangono solo $count $_temp0. Passa a Premium o guarda un video per più slot!';
  }

  @override
  String get reviewLimitReachedTitle => '🚫 Limite Recensioni Raggiunto';

  @override
  String get reviewLimitReachedBody =>
      'Hai usato tutte le tue recensioni gratuite. Passa a Premium o guarda un video per continuare a scrivere!';

  @override
  String get errorSavingReview =>
      'Si è verificato un errore durante il salvataggio della recensione. Riprova.';

  @override
  String get errorUpdatingSlotsAfterReward =>
      'Errore durante l\'aggiornamento degli slot dopo il video.';

  @override
  String get reviewFiltersDialogTitle => 'Filtri Avanzati Recensioni';

  @override
  String get reviewFilterAll => 'Tutte le recensioni';

  @override
  String get reviewFilter5Stars => 'Solo 5 stelle';

  @override
  String get reviewFilter4PlusStars => '4 stelle e oltre';

  @override
  String get reviewFilterNegative =>
      'Solo recensioni negative (meno di 3 stelle)';

  @override
  String get reviewStatsDialogTitle => 'Statistiche Personali';

  @override
  String get reviewStatsTotalReviewsLabel => 'Totale recensioni:';

  @override
  String get reviewStatsAverageRatingLabel => 'Media voto:';

  @override
  String reviewStatsAverageRatingLabelFull(Object averageRating) {
    return '⭐ Media voto: $averageRating';
  }

  @override
  String get reviewStatsLongestReviewLabel =>
      'Recensione più frequente (esempio):';

  @override
  String get reviewStatsLongestReviewExample =>
      'Volo puntuale e personale di bordo molto gentile.';

  @override
  String get reviewStatsNoLongestReview => 'Nessuna recensione disponibile.';

  @override
  String get themeSelectionClassicTheme => 'Tema Classico';

  @override
  String get themeSelectionPremiumTheme => 'Tema Premium Esclusivo';

  @override
  String get unlockOptionsDialogTitle => 'Limite Recensioni Gratuite Raggiunto';

  @override
  String get unlockOptionsDialogContent =>
      'Per aggiungere altre recensioni, scegli una delle seguenti opzioni:';

  @override
  String get unlockOptionsGoPremium => 'Passa a Premium';

  @override
  String get unlockOptionsWatchVideoButton => 'Guarda un Video (Slot Extra)';

  @override
  String get unlockOptionsInviteFriendButton => 'Invita un Amico (Bonus)';

  @override
  String get unlockOptionsLoginRequired =>
      '⚠️ Effettua il login per usare questa funzione.';

  @override
  String get unlockOptionsShareDialogTitle =>
      'Condividi JetPin e Ottieni Bonus!';

  @override
  String get unlockOptionsErrorGeneratingInviteLink =>
      'Spiacenti, errore nella generazione del link d\'invito. Riprova più tardi.';

  @override
  String get upgradePremiumModalTitle => 'Passa a JetPin Premium';

  @override
  String get upgradeFeatureMapFilter =>
      'Sblocca i filtri avanzati della mappa con JetPin Premium!';

  @override
  String get upgradeFeaturePinStats =>
      'Accedi alle statistiche avanzate dei tuoi Pin solo con Premium.';

  @override
  String get upgradeFeaturePinExport =>
      'Esporta i tuoi dati Pin e fai il backup nel cloud con Premium.';

  @override
  String get upgradeFeatureBackupCloud =>
      'Effettua il backup sicuro dei tuoi dati nel cloud con JetPin Premium.';

  @override
  String get upgradeFeatureThemes =>
      'Personalizza l\'app con i temi esclusivi disponibili solo per gli utenti Premium!';

  @override
  String get upgradeFeaturePinAdd =>
      'Hai raggiunto il limite di Pin gratuiti. Passa a Premium per aggiungerne altri!';

  @override
  String get upgradeFeatureReviewLimit =>
      'Hai raggiunto il limite gratuito di recensioni. Passa a JetPin Premium per continuare a scrivere!';

  @override
  String get upgradeFeatureReviewFilters =>
      'Filtra le recensioni per compagnia, punteggio e data: solo per utenti Premium!';

  @override
  String get upgradeFeatureReviewStats =>
      'Scopri le statistiche dettagliate delle tue recensioni con JetPin Premium!';

  @override
  String get upgradeFeatureReviewStatsHint =>
      'Hai già recensito molti voli! Con JetPin Premium puoi vedere il tuo impatto dettagliato sulle compagnie.';

  @override
  String get upgradeFeatureDefault =>
      'Questa funzionalità è disponibile solo con JetPin Premium. Esegui l\'upgrade per sbloccarla!';

  @override
  String get cloudBackupButtonLabel => 'Backup su Cloud';

  @override
  String get cloudBackupSuccessMessage =>
      'Backup su cloud effettuato con successo!';

  @override
  String get cloudBackupFailedMessage =>
      'Errore durante il backup su cloud. Riprova.';

  @override
  String get exportDataButtonLabel => 'Esporta Dati';

  @override
  String get exportDataButtonLabelPremiumRequired => 'Esporta Dati (Premium)';

  @override
  String get jetpinAppBarLogoError => 'Errore Logo';

  @override
  String get mapFiltersAllPins => 'Tutti i Pin';

  @override
  String get mapFiltersAdvanced => 'Filtri Avanzati';

  @override
  String pinAddLimitReachedMessage(Object limit) {
    return 'Solo gli utenti Premium possono aggiungere più di $limit Pin!';
  }

  @override
  String get pinAddUpgradeToPremiumButton => 'Passa a Premium';

  @override
  String get pinAddButtonLabel => 'Aggiungi Pin';

  @override
  String pinStatsTotalPins(Object count) {
    return 'Numero totale di Pin: $count';
  }

  @override
  String pinStatsLastPinDate(Object date) {
    return 'Ultimo Pin aggiunto: $date';
  }

  @override
  String get pinStatsUnlockAdvancedButton =>
      'Sblocca Statistiche Avanzate dei Pin';

  @override
  String get featureOnlyForPremiumUsers =>
      'Questa funzionalità è disponibile solo per gli utenti Premium. Esegui l\'upgrade per accedere!';

  @override
  String get reviewStatsPageAppBarTitle => 'Statistiche Recensioni';

  @override
  String get reviewStatsByAirlineLabel => '✈️ Recensioni per compagnia aerea';

  @override
  String get reviewStatsByMonthLabel => '📊 Recensioni per mese';

  @override
  String get reviewStatsNoReviewsYet =>
      'Non hai ancora scritto recensioni per visualizzare le statistiche.';

  @override
  String get reviewStatsNoAirlineData =>
      'Nessun dato disponibile per le compagnie aeree.';

  @override
  String get reviewStatsNoMonthlyData =>
      'Nessun dato disponibile per le recensioni mensili.';

  @override
  String get reviewStatsReviewSingular => 'recensione';

  @override
  String get reviewStatsReviewPlural => 'recensioni';

  @override
  String get premiumPurchaseNotAvailable =>
      'Gli acquisti in-app non sono disponibili su questo dispositivo.';

  @override
  String premiumPurchaseButtonIAP(Object price) {
    return 'Abbonati con $price';
  }

  @override
  String get premiumPurchaseButtonStripe => 'Paga con Stripe';

  @override
  String premiumPurchaseCannotLaunchUrl(Object url) {
    return 'Impossibile aprire l\'URL: $url';
  }

  @override
  String purchaseError(Object errorMessage) {
    return 'Errore durante l\'acquisto: $errorMessage';
  }

  @override
  String get purchaseFlowStartError =>
      'Impossibile avviare il processo di acquisto.';

  @override
  String get referralShareWidgetTitle => '🎁 Invita un Amico!';

  @override
  String get referralShareWidgetDescription =>
      'Condividi il tuo codice invito personale. Quando un amico lo usa per iscriversi a JetPin, entrambi ricevete fantastici vantaggi e ricompense!';

  @override
  String get referralShareWidgetYourCodeLabel => 'Il tuo codice invito:';

  @override
  String get referralShareWidgetShareButton => 'Condividi il tuo invito';

  @override
  String referralShareDefaultMessage(Object inviteLink, Object referralCode) {
    return 'Ehi! Prova JetPin per recensire i tuoi voli e viaggi. Usa il mio codice invito: $referralCode per ottenere bonus speciali!\nScarica l\'app qui: $inviteLink';
  }

  @override
  String get premiumInfoDialogTitle => '✨ Cosa include JetPin Premium';

  @override
  String get premiumInfoFeatureUnlimitedSlots => 'Recensioni illimitate';

  @override
  String get premiumInfoFeaturePriorityAccess =>
      'Accesso prioritario a nuove funzioni';

  @override
  String get premiumInfoDiscoverButton => 'Scopri Premium';
}
