// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class SIt extends S {
  SIt([String locale = 'it']) : super(locale);

  @override
  String get accountDeleteRequiresRecentLogin =>
      'L\'eliminazione dell\'account è fallita. Questa operazione potrebbe richiedere un accesso recente. Prova a fare nuovamente il login e riprova.';

  @override
  String get accountDeletedErrorMessage =>
      'Errore durante l\'eliminazione dell\'account. Riprova.';

  @override
  String get accountDeletionAllDeletedSuccessMessage =>
      'Account e tutte le recensioni eliminati con successo.';

  @override
  String get accountDeletionAnonymizedSuccessMessage =>
      'Account eliminato e recensioni anonimizzate con successo.';

  @override
  String get accountDeletionConfirmButton => 'Conferma Eliminazione';

  @override
  String get accountDeletionFailedReviewOperationMessage =>
      'Errore durante l\'operazione sulle recensioni. L\'account non è stato modificato.';

  @override
  String get accountDeletionOptionAnonymizeDescription =>
      'Il tuo account verrà eliminato, ma le tue recensioni rimarranno visibili in forma anonima.';

  @override
  String get accountDeletionOptionAnonymizeLabel =>
      'Elimina account e anonimizza recensioni';

  @override
  String get accountDeletionOptionDeleteAllDescription =>
      'Questa azione è irreversibile. Tutti i tuoi dati e le tue recensioni verranno rimossi definitivamente.';

  @override
  String get accountDeletionOptionDeleteAllLabel =>
      'Elimina account e tutte le recensioni';

  @override
  String get accountDeletionOptionsDialogMessage =>
      'Scegli come procedere con l\'eliminazione del tuo account:';

  @override
  String get accountDeletionOptionsDialogTitle =>
      'Opzioni Eliminazione Account';

  @override
  String get accountDeletionRequestedMessage =>
      'La tua richiesta di eliminazione dell\'account è stata registrata. L\'account sarà processato per l\'eliminazione.';

  @override
  String get accountDeletionRetrySuccessMessage =>
      'Ri-autenticazione riuscita. Account eliminato con successo.';

  @override
  String get addReviewAirlineHint => 'Compagnia aerea';

  @override
  String get addReviewAppBarTitle => 'Aggiungi Recensione';

  @override
  String get addReviewCommentHint => 'Commento (opzionale)';

  @override
  String addReviewExtraSlotsAvailable(Object count) {
    return '🎁 Hai $count recensioni extra disponibili!';
  }

  @override
  String get addReviewFillAllFields => 'Compila tutti i campi obbligatori.';

  @override
  String get addReviewFlightNumberHint => 'Numero volo';

  @override
  String get addReviewRatingLabel => 'Valutazione';

  @override
  String get addReviewSaveButton => 'Salva recensione';

  @override
  String get addReviewSuccess => 'Recensione aggiunta!';

  @override
  String get addReviewTooltip => 'Aggiungi recensione';

  @override
  String get addReviewUpdateButton => 'Aggiorna Recensione';

  @override
  String get addReviewUpdatePageTitle => 'Modifica Recensione';

  @override
  String get anonymousUser => 'Utente Anonimo';

  @override
  String get appTitle => 'JetPin';

  @override
  String get applyButton => 'Applica';

  @override
  String get atTimeConnector => 'alle';

  @override
  String get billingPeriodMonthly => '/mese';

  @override
  String get cancelAnytime => 'cancellazione in ogni momento';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get closeButton => 'Chiudi';

  @override
  String get cloudBackupButtonLabel => 'Backup su Cloud';

  @override
  String get cloudBackupFailedMessage =>
      'Errore durante il backup su cloud. Riprova.';

  @override
  String get cloudBackupSuccessMessage =>
      'Backup su cloud effettuato con successo!';

  @override
  String commonExtraSlotsGranted(Object count) {
    return '🎉 $count slot extra sbloccati!';
  }

  @override
  String get deleteAccountButtonLabel => 'Elimina Account';

  @override
  String get deleteAccountConfirmMessage =>
      'Sei sicuro di voler eliminare il tuo account e tutti i tuoi dati (recensioni, profilo, ecc.)? Questa azione è irreversibile.';

  @override
  String get deleteAccountConfirmTitle => 'Conferma Eliminazione Account';

  @override
  String get deleteButton => 'Elimina';

  @override
  String get deleteReviewButtonLabel => 'Elimina';

  @override
  String get deleteReviewConfirmMessage =>
      'Sei sicuro di voler eliminare questa recensione? L\'azione è irreversibile.';

  @override
  String get deleteReviewConfirmTitle => 'Conferma Eliminazione Recensione';

  @override
  String developedByText(String developerName) {
    return 'Sviluppato da $developerName';
  }

  @override
  String get editReviewButtonLabel => 'Modifica';

  @override
  String get errorDeletingReview =>
      'Errore durante l\'eliminazione della recensione.';

  @override
  String get errorLoadingData => 'Errore durante il caricamento dei dati.';

  @override
  String get errorSavingReview =>
      'Si è verificato un errore durante il salvataggio della recensione. Riprova.';

  @override
  String get errorSendingReply => 'Errore durante l\'invio della risposta.';

  @override
  String get errorUpdatingReview =>
      'Errore durante l\'aggiornamento della recensione.';

  @override
  String get errorUpdatingSlotsAfterReward =>
      'Errore durante l\'aggiornamento degli slot dopo il video.';

  @override
  String get errorUserNotLoggedInOrReviewBuildFailed =>
      'Utente non loggato o errore nella creazione della recensione. Riprova.';

  @override
  String get exportDataButtonLabel => 'Esporta Dati';

  @override
  String get exportDataButtonLabelPremiumRequired => 'Esporta Dati (Premium)';

  @override
  String get featureOnlyForPremiumUsers =>
      'Questa funzionalità è disponibile solo per gli utenti Premium. Esegui l\'upgrade per accedere!';

  @override
  String get goBackButton => 'Torna indietro';

  @override
  String get guestUser => 'utente';

  @override
  String get hideRepliesButtonLabel => 'Nascondi risposte';

  @override
  String get interstitialAdShowError =>
      '⚠️ Errore nella visualizzazione dell\'annuncio';

  @override
  String get jetpinAppBarLogoError => 'Errore Logo';

  @override
  String get loadingReauthenticating => 'Ri-autenticazione in corso...';

  @override
  String get loadingRetryingDelete => 'Nuovo tentativo eliminazione account...';

  @override
  String get loadingText => 'Caricamento...';

  @override
  String get loginButton => 'Login';

  @override
  String get loginCancelled => 'Login annullato.';

  @override
  String get loginFailed => 'Login fallito. Riprova.';

  @override
  String loginWelcomeBack(Object userName) {
    return 'Bentornato, $userName!';
  }

  @override
  String get logoNotFoundError => '⚠️ Logo non trovato';

  @override
  String get logoNotFoundErrorShort => 'Errore Logo';

  @override
  String get logoutButton => 'Logout';

  @override
  String get mapFiltersAdvanced => 'Filtri Avanzati';

  @override
  String get mapFiltersAllPins => 'Tutti i Pin';

  @override
  String get myReviewsAdvancedFiltersButton => 'Filtri Avanzati';

  @override
  String get myReviewsAppBarTitle => 'Le mie recensioni';

  @override
  String get myReviewsLoginPrompt =>
      'Effettua il login per vedere le tue recensioni.';

  @override
  String get myReviewsNoReviews => 'Non hai ancora scritto recensioni.';

  @override
  String myReviewsSmartModalContent(Object airlineName, Object count) {
    return 'Hai recensito $count voli con $airlineName. Con Premium puoi vedere l’impatto del tuo punteggio su questa compagnia!';
  }

  @override
  String get myReviewsSmartModalDiscoverButton => 'Scopri Premium';

  @override
  String get myReviewsSmartModalLaterButton => 'Non ora';

  @override
  String get myReviewsSmartModalTitle => 'Scopri il tuo impatto!';

  @override
  String get myReviewsStatsButton => 'Statistiche';

  @override
  String get navigationMyReviews => 'Le mie';

  @override
  String get navigationProfile => 'Profilo';

  @override
  String get navigationReviews => 'Recensioni';

  @override
  String get noButton => 'No';

  @override
  String get noDataAvailable => 'Nessun dato disponibile.';

  @override
  String get notificationChannelDescription =>
      'Promemoria e notifiche importanti dall\'app JetPin.';

  @override
  String get notificationChannelName => 'Promemoria JetPin';

  @override
  String get notificationPermissionDialogContent =>
      'JetPin vorrebbe inviarti notifiche per promemoria utili e aggiornamenti. Vuoi abilitarli?';

  @override
  String get notificationPermissionDialogTitle => 'Permessi Notifica';

  @override
  String get okButton => 'OK';

  @override
  String get pinAddButtonLabel => 'Aggiungi Pin';

  @override
  String pinAddLimitReachedMessage(Object limit) {
    return 'Solo gli utenti Premium possono aggiungere più di $limit Pin!';
  }

  @override
  String get pinAddUpgradeToPremiumButton => 'Passa a Premium';

  @override
  String pinStatsLastPinDate(Object date) {
    return 'Ultimo Pin aggiunto: $date';
  }

  @override
  String pinStatsTotalPins(Object count) {
    return 'Numero totale di Pin: $count';
  }

  @override
  String get pinStatsUnlockAdvancedButton =>
      'Sblocca Statistiche Avanzate dei Pin';

  @override
  String get premiumFeatureAiFeatures => 'Funzionalità AI (Prossimamente)';

  @override
  String get premiumFeatureCloudBackup => 'Backup automatico su cloud';

  @override
  String get premiumFeatureCloudBackupDesc =>
      'Proteggi i tuoi dati con backup automatici nel cloud.';

  @override
  String get premiumFeatureDetailedStats => 'Statistiche Dettagliate';

  @override
  String get premiumFeatureDetailedStatsDesc =>
      'Comprendi l’impatto delle tue valutazioni.';

  @override
  String get premiumFeatureExportPdf => 'Esporta Recensioni';

  @override
  String get premiumFeatureExportPdfDesc =>
      'Conserva e condividi le tue recensioni in formato PDF.';

  @override
  String get premiumFeatureFlightTracking =>
      'Tracking voli e itinerari (Prossimamente)';

  @override
  String get premiumFeatureNoAds => 'Nessuna pubblicità';

  @override
  String get premiumFeatureSmartItineraries =>
      'Itinerari intelligenti (Prossimamente)';

  @override
  String get premiumFeatureSuperCreatorBadge => 'Badge Super Creator';

  @override
  String get premiumFeatureUnlimitedPins => 'Recensioni illimitate';

  @override
  String get premiumFeatureUnlimitedPinsDesc =>
      'Aggiungi tutte le recensioni che vuoi, senza limiti.';

  @override
  String get premiumInfoDiscoverButton => 'Scopri Premium';

  @override
  String get premiumInfoFeaturePriorityAccess =>
      'Accesso prioritario a nuove funzioni';

  @override
  String get premiumInfoFeatureUnlimitedSlots => 'Recensioni illimitate';

  @override
  String get premiumInfoDialogTitle => '✨ Cosa include JetPin Premium';

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
  String get premiumPurchaseNotAvailable =>
      'Gli acquisti in-app non sono disponibili su questo dispositivo.';

  @override
  String get premiumTabDiscoverButton => 'Scopri Premium';

  @override
  String get premiumTabTitle => 'JetPin Premium';

  @override
  String priceInfo(Object billingPeriod, Object price) {
    return '$price$billingPeriod';
  }

  @override
  String get priceValue => '€4,99';

  @override
  String get privacyPolicyLinkText => 'Informativa sulla Privacy';

  @override
  String get profileAdvancedStatsButton => 'Statistiche avanzate';

  @override
  String get profileAppBarTitle => 'Profilo';

  @override
  String get profileBackupCloudButton => 'Backup su cloud';

  @override
  String get profileBackupComplete => 'Backup completato';

  @override
  String profileBadgeInfluencer(Object count) {
    return '🚀 Influencer JetPin ($count+ amici)';
  }

  @override
  String profileBadgeLegend(Object count) {
    return '👑 Leggenda JetPin ($count+ amici)';
  }

  @override
  String profileBadgePromoter(Object count) {
    return '🎉 Super Promotore ($count+ amici)';
  }

  @override
  String get profileBadgeUsedReferral =>
      '🏡 Hai ricevuto un bonus da un invito!';

  @override
  String get profileErrorLoadingPremium =>
      'Errore nel caricamento dello stato Premium.';

  @override
  String profileExtraSlots(Object count) {
    return 'Hai ricevuto $count slot bonus in totale!';
  }

  @override
  String get profileInviteMoreForBadges =>
      '🎯 Invita altri amici per sbloccare nuovi badge!';

  @override
  String profileLastBackupDate(Object dateTime) {
    return '☁️ Ultimo backup: $dateTime';
  }

  @override
  String get profileLogoutDialogContent =>
      'Perderai l\'accesso alle funzioni disponibili solo per utenti loggati.';

  @override
  String get profileLogoutDialogTitle => 'Vuoi davvero uscire?';

  @override
  String get profileLogoutSuccess => 'Logout effettuato.';

  @override
  String get profileNotLoggedIn =>
      'Non sei loggato. Effettua il login per vedere il tuo profilo.';

  @override
  String profilePremiumTrialDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni rimanenti',
      one: '1 giorno rimanente',
    );
    return '🏡 Prova gratuita: $_temp0';
  }

  @override
  String profilePremiumTrialExpiresSoon(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni',
      one: '1 giorno',
    );
    return '⏳ La tua prova gratuita scade tra $_temp0!';
  }

  @override
  String profileReferralCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count amici',
      one: '1 amico',
    );
    return 'Hai invitato $_temp0!';
  }

  @override
  String get profileShareInviteButton => 'Invita un amico';

  @override
  String profileShareInviteMessage(Object inviteLink, Object referralCode) {
    return 'Unisciti a JetPin! Inserisci questo codice invito ($referralCode) per ricevere bonus speciali!\nScarica l\'app qui: $inviteLink';
  }

  @override
  String get profileTabLabel => 'Profilo';

  @override
  String get profileTabPremiumLabel => 'Solo per Premium';

  @override
  String get profileUnlockedRewardsTitle => 'Ricompense sbloccate:';

  @override
  String get profileUserIsPremium => 'Utente Premium';

  @override
  String get profileWelcomeMessage =>
      'Benvenuto in JetPin!\n\nQui verranno mostrate le info utente e attività recenti.';

  @override
  String get profileWhatIsPremiumButton => 'Cos\'è JetPin Premium?';

  @override
  String purchaseError(Object errorMessage) {
    return 'Errore durante l\'acquisto: $errorMessage';
  }

  @override
  String get purchaseFlowStartError =>
      'Impossibile avviare il processo di acquisto.';

  @override
  String get reauthenticateButton => 'Accedi di Nuovo';

  @override
  String get reauthenticationFailedMessage =>
      'Ri-autenticazione fallita. Riprova.';

  @override
  String get reauthenticationRequiredMessage =>
      'Per la tua sicurezza, è necessario accedere di nuovo prima di poter eliminare il tuo account. Vuoi procedere con il login?';

  @override
  String get reauthenticationRequiredTitle => 'Autenticazione Richiesta';

  @override
  String get referralDialogConfirmButton => 'Conferma';

  @override
  String get referralDialogHint => 'Codice invito (UID)';

  @override
  String get referralDialogSkipButton => 'Salta';

  @override
  String get referralDialogTitle => 'Hai un codice invito?';

  @override
  String get referralInvalidCode => 'Codice invito non valido o auto-riferito.';

  @override
  String get referralInviterNotFound => 'Codice invito non trovato.';

  @override
  String referralShareDefaultMessage(Object inviteLink, Object referralCode) {
    return 'Ehi! Prova JetPin per recensire i tuoi voli e viaggi. Usa il mio codice invito: $referralCode per ottenere bonus speciali!\nScarica l\'app qui: $inviteLink';
  }

  @override
  String get referralShareWidgetDescription =>
      'Condividi il tuo codice invito personale. Quando un amico lo usa per iscriversi a JetPin, entrambi ricevete fantastici vantaggi e ricompense!';

  @override
  String get referralShareWidgetShareButton => 'Condividi il tuo invito';

  @override
  String get referralShareWidgetTitle => '🎁 Invita un Amico!';

  @override
  String get referralShareWidgetYourCodeLabel => 'Il tuo codice invito:';

  @override
  String get referralSuccess => '🎉 Bonus ricevuto grazie al codice invito!';

  @override
  String get repliesSectionTitle => 'Risposte';

  @override
  String get replyButtonLabel => 'Rispondi';

  @override
  String get replySentSuccessMessage => 'Risposta inviata con successo!';

  @override
  String get rewardVideoLoadError => '⚠️ Errore nel caricamento del video';

  @override
  String get rewardVideoShowError =>
      '⚠️ Errore nella visualizzazione del video';

  @override
  String rewardedAdAdsDisabled(Object minutes) {
    return '🎉 Pubblicità disattivate per $minutes minuti!';
  }

  @override
  String reviewCardEditedOn(String date) {
    return 'Modificato il $date';
  }

  @override
  String get reviewDeletedSuccessMessage =>
      'Recensione eliminata con successo.';

  @override
  String get reviewEditedSuccessMessage =>
      'Recensione modificata con successo!';

  @override
  String get reviewFilter4PlusStars => '4 stelle e oltre';

  @override
  String get reviewFilter5Stars => 'Solo 5 stelle';

  @override
  String get reviewFilterAll => 'Tutte le recensioni';

  @override
  String get reviewFilterNegative =>
      'Solo recensioni negative (meno di 3 stelle)';

  @override
  String get reviewFiltersDialogTitle => 'Filtri Avanzati Recensioni';

  @override
  String get reviewLimitReachedBody =>
      'Hai usato tutte le tue recensioni gratuite. Passa a Premium o guarda un video per continuare a scrivere!';

  @override
  String get reviewLimitReachedTitle => '🚫 Limite Recensioni Raggiunto';

  @override
  String reviewLimitWarningBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recensioni',
      one: '1 recensione',
    );
    return 'Hai quasi raggiunto il limite gratuito. Ti rimangono solo $_temp0. Passa a Premium o guarda un video per più slot!';
  }

  @override
  String get reviewLimitWarningTitle => '📢 Attenzione Limite Recensioni!';

  @override
  String get reviewListPlaceholder =>
      'Qui verranno visualizzate le recensioni...';

  @override
  String get reviewStatsAverageRatingLabel => 'Media voto:';

  @override
  String reviewStatsAverageRatingLabelFull(Object averageRating) {
    return '⭐ Media voto: $averageRating';
  }

  @override
  String get reviewStatsByAirlineLabel => '✈️ Recensioni per compagnia aerea';

  @override
  String get reviewStatsByMonthLabel => '📊 Recensioni per mese';

  @override
  String get reviewStatsDialogTitle => 'Statistiche Personali';

  @override
  String get reviewStatsLongestReviewExample =>
      'Volo puntuale e personale di bordo molto gentile.';

  @override
  String get reviewStatsLongestReviewLabel =>
      'Recensione più frequente (esempio):';

  @override
  String get reviewStatsNoAirlineData =>
      'Nessun dato disponibile per le compagnie aeree.';

  @override
  String get reviewStatsNoLongestReview => 'Nessuna recensione disponibile.';

  @override
  String get reviewStatsNoMonthlyData =>
      'Nessun dato disponibile per le recensioni mensili.';

  @override
  String get reviewStatsNoReviewsYet =>
      'Non hai ancora scritto recensioni per visualizzare le statistiche.';

  @override
  String get reviewStatsPageAppBarTitle => 'Statistiche Recensioni';

  @override
  String get reviewStatsReviewPlural => 'recensioni';

  @override
  String get reviewStatsReviewSingular => 'recensione';

  @override
  String get reviewStatsTotalReviewsLabel => 'Totale recensioni:';

  @override
  String get searchReviewsHint => 'Cerca recensioni...';

  @override
  String get sendReplyButtonLabel => 'Invia';

  @override
  String get supportContactText => 'Supporto: jetpin@salvo00786.it';

  @override
  String get supportEmailSubject => 'Supporto App JetPin';

  @override
  String get termsOfServiceLinkText => 'Termini di Servizio';

  @override
  String get themeSelectionClassicTheme => 'Tema Classico';

  @override
  String get themeSelectionPremiumTheme => 'Tema Premium Esclusivo';

  @override
  String get unlockOptionsDialogContent =>
      'Per aggiungere altre recensioni, scegli una delle seguenti opzioni:';

  @override
  String get unlockOptionsDialogTitle => 'Limite Recensioni Gratuite Raggiunto';

  @override
  String get unlockOptionsErrorGeneratingInviteLink =>
      'Spiacenti, errore nella generazione del link d\'invito. Riprova più tardi.';

  @override
  String get unlockOptionsGoPremium => 'Passa a Premium';

  @override
  String get unlockOptionsInviteFriendButton => 'Invita un Amico (Bonus)';

  @override
  String get unlockOptionsLoginRequired =>
      '⚠️ Effettua il login per usare questa funzione.';

  @override
  String get unlockOptionsShareDialogTitle =>
      'Condividi JetPin e Ottieni Bonus!';

  @override
  String get unlockOptionsWatchVideoButton => 'Guarda un Video (Slot Extra)';

  @override
  String get upgradeFeatureBackupCloud =>
      'Effettua il backup sicuro dei tuoi dati nel cloud con JetPin Premium.';

  @override
  String get upgradeFeatureDefault =>
      'Questa funzionalità è disponibile solo con JetPin Premium. Esegui l\'upgrade per sbloccarla!';

  @override
  String get upgradeFeatureMapFilter =>
      'Sblocca i filtri avanzati della mappa con JetPin Premium!';

  @override
  String get upgradeFeaturePinAdd =>
      'Hai raggiunto il limite di Pin gratuiti. Passa a Premium per aggiungerne altri!';

  @override
  String get upgradeFeaturePinExport =>
      'Esporta i tuoi dati Pin e fai il backup nel cloud con Premium.';

  @override
  String get upgradeFeaturePinStats =>
      'Accedi alle statistiche avanzate dei tuoi Pin solo con Premium.';

  @override
  String get upgradeFeatureReviewFilters =>
      'Filtra le recensioni per compagnia, punteggio e data: solo per utenti Premium!';

  @override
  String get upgradeFeatureReviewLimit =>
      'Hai raggiunto il limite gratuito di recensioni. Passa a JetPin Premium per continuare a scrivere!';

  @override
  String get upgradeFeatureReviewStats =>
      'Scopri le statistiche dettagliate delle tue recensioni con JetPin Premium!';

  @override
  String get upgradeFeatureReviewStatsHint =>
      'Hai già recensito molti voli! Con JetPin Premium puoi vedere il tuo impatto dettagliato sulle compagnie.';

  @override
  String get upgradeFeatureThemes =>
      'Personalizza l\'app con i temi esclusivi disponibili solo per gli utenti Premium!';

  @override
  String get upgradePremiumActivateButton => 'Attiva Premium Ora';

  @override
  String get upgradePremiumActivateTrialButton =>
      'Attiva la prova gratuita (7 giorni)';

  @override
  String get upgradePremiumAlreadyPremium => '✅ Sei già un utente Premium!';

  @override
  String get upgradePremiumAppBarTitle => 'Passa a Premium';

  @override
  String get upgradePremiumBenefitPrompt =>
      'Passa a JetPin Premium per sbloccare tutte le funzioni!';

  @override
  String get upgradePremiumFeaturesTitle => '💎 Cosa ottieni con Premium';

  @override
  String get upgradePremiumLimitReachedTitle =>
      '🚫 Hai raggiunto i limiti del tuo account gratuito.';

  @override
  String get upgradePremiumLoginToActivateTrial =>
      'Effettua il login per attivare la prova gratuita.';

  @override
  String get upgradePremiumModalTitle => 'Passa a JetPin Premium';

  @override
  String upgradePremiumPriceInfoFull(
      Object cancellationPolicy, Object formattedPriceInfo) {
    return '$formattedPriceInfo — $cancellationPolicy';
  }

  @override
  String get upgradePremiumTrialActivatedSuccess =>
      '🎉 Prova gratuita attivata! Goditi JetPin Premium.';

  @override
  String upgradePremiumTrialActiveDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days giorni rimanenti',
      one: '1 giorno rimanente',
    );
    return '📆 Prova gratuita attiva: hai $_temp0.';
  }

  @override
  String get upgradePremiumTrialAlreadyUsedError =>
      'Errore: la prova gratuita è già stata utilizzata o non è stato possibile attivarla.';

  @override
  String get upgradePremiumTrialAvailable =>
      'Hai diritto alla prova gratuita di 7 giorni!';

  @override
  String get upgradePremiumTrialNoCharge =>
      '🔒 Nessun addebito prima della scadenza della prova.';

  @override
  String get upgradePremiumTrialUsed =>
      'Hai già utilizzato la tua prova gratuita.';

  @override
  String get viewRepliesButtonLabel_one => 'Vedi 1 risposta';

  @override
  String viewRepliesButtonLabel_other(int count) {
    return 'Vedi $count risposte';
  }

  @override
  String get viewRepliesButtonLabel_zero => 'Nessuna risposta';

  @override
  String get watchAdToDisableAdsButton =>
      'Guarda un video per rimuovere gli annunci';

  @override
  String get workInProgressContent =>
      'L\'acquisto reale sarà disponibile nella versione finale dell\'app.';

  @override
  String get workInProgressTitle => 'Work in Progress';

  @override
  String get writeReplyHintText => 'Scrivi una risposta...';

  @override
  String get yesButton => 'Sì';

  @override
  String get deleteAccountOptionsDialogTitle => 'Opzioni Eliminazione Account';

  @override
  String get deleteAccountOptionDialogMessage =>
      'Scegli come procedere con l\'eliminazione del tuo account:';

  @override
  String get deleteAccountOptionDeleteAllLabel =>
      'Elimina account e tutte le recensioni';

  @override
  String get deleteAccountOptionDeleteAllDescription =>
      'Questa azione è irreversibile. Tutti i tuoi dati e le tue recensioni verranno rimossi definitivamente.';

  @override
  String get deleteAccountOptionAnonymizeLabel =>
      'Elimina account e anonimizza recensioni';

  @override
  String get deleteAccountOptionAnonymizeDescription =>
      'Il tuo account verrà eliminato, ma le tue recensioni rimarranno visibili in forma anonima.';

  @override
  String get deleteAccountConfirmButton => 'Conferma Eliminazione';

  @override
  String get markAsHelpfulButtonTooltip => 'Segnala come utile';

  @override
  String helpfulVotesLabel(Object count) {
    return '$count utili';
  }

  @override
  String reviewSearchNoResults(String searchTerm) {
    return 'Nessuna recensione trovata per \'$searchTerm\'.';
  }

  @override
  String get reviewSearchOverallNoReviews =>
      'Non ci sono ancora recensioni su JetPin. Sii il primo!';

  @override
  String get searchFlightStatusButtonLabel => 'Stato Volo';

  @override
  String get searchFlightStatusTooltip =>
      'Cerca lo stato attuale del volo online (Premium)';

  @override
  String cannotLaunchUrlError(String url) {
    return 'Impossibile aprire l\'URL: $url';
  }

  @override
  String get editReplyButtonTooltip => 'Modifica risposta';

  @override
  String get deleteReplyButtonTooltip => 'Elimina risposta';

  @override
  String get editReplyDialogTitle => 'Modifica la tua risposta';

  @override
  String get updateReplyButtonLabel => 'Aggiorna';

  @override
  String get deleteReplyConfirmTitle => 'Conferma Eliminazione Risposta';

  @override
  String get deleteReplyConfirmMessage =>
      'Sei sicuro di voler eliminare questa risposta? L\'azione è irreversibile.';

  @override
  String get replyUpdatedSuccessMessage => 'Risposta aggiornata con successo!';

  @override
  String get replyDeletedSuccessMessage => 'Risposta eliminata con successo!';

  @override
  String get errorUpdatingReply =>
      'Errore durante l\'aggiornamento della risposta.';

  @override
  String get errorDeletingReply =>
      'Errore durante l\'eliminazione della risposta.';

  @override
  String replyCardEditedOn(Object date) {
    return 'Modificata il $date';
  }

  @override
  String get comingSoonDialogTitle => 'Funzionalità in Arrivo';

  @override
  String get comingSoonDialogMessage =>
      'Questa funzionalità è in fase di sviluppo e sarà disponibile in un futuro aggiornamento. Grazie per la tua pazienza!';

  @override
  String get congratsVerifiedReviewer =>
      '🎉 Congratulazioni! Sei ora un Recensore Verificato!';

  @override
  String get profileBadgeVerifiedReviewer => '🏅 Recensore Verificato';

  @override
  String get referralApplyGeneralError =>
      'Si è verificato un errore generale durante l\'applicazione del codice referral.';

  @override
  String get accountDeletionProcessingReviewsMessage =>
      'Elaborazione delle recensioni per la cancellazione dell\'account in corso...';

  @override
  String get accountDeletingMessage =>
      'Cancellazione dell\'account in corso...';

  @override
  String get noRepliesYet => 'Nessuna risposta ancora.';
}
