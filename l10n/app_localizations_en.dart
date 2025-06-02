// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'JetPin';

  @override
  String get navigationReviews => 'Reviews';

  @override
  String get navigationMyReviews => 'My Reviews';

  @override
  String get navigationProfile => 'Profile';

  @override
  String get logoNotFoundError => '⚠️ Logo not found';

  @override
  String get logoNotFoundErrorShort => 'Logo Error';

  @override
  String commonExtraSlotsGranted(Object count) {
    return '🎉 $count extra slots unlocked!';
  }

  @override
  String get rewardVideoLoadError => '⚠️ Error loading the video';

  @override
  String get rewardVideoShowError => '⚠️ Error showing the video';

  @override
  String get referralDialogTitle => 'Have an invite code?';

  @override
  String get referralDialogHint => 'Invite code (UID)';

  @override
  String get referralDialogSkipButton => 'Skip';

  @override
  String get referralDialogConfirmButton => 'Confirm';

  @override
  String get referralInvalidCode => 'Invalid or self-referral code.';

  @override
  String get referralInviterNotFound => 'Invite code not found.';

  @override
  String get referralSuccess => '🎉 Bonus received thanks to the invite code!';

  @override
  String rewardedAdAdsDisabled(Object minutes) {
    return '🎉 Ads disabled for $minutes minutes!';
  }

  @override
  String loginWelcomeBack(Object userName) {
    return 'Welcome back, $userName!';
  }

  @override
  String get guestUser => 'guest';

  @override
  String get anonymousUser => 'Anonymous';

  @override
  String get loginCancelled => 'Login cancelled.';

  @override
  String get addReviewSuccess => 'Review added!';

  @override
  String get searchReviewsHint => 'Search reviews...';

  @override
  String get watchAdToDisableAdsButton => 'Watch an ad to remove ads';

  @override
  String get reviewListPlaceholder => 'Reviews will be displayed here...';

  @override
  String get addReviewTooltip => 'Add review';

  @override
  String get loginButton => 'Login';

  @override
  String get logoutButton => 'Logout';

  @override
  String get addReviewAppBarTitle => 'Add Review';

  @override
  String get addReviewFillAllFields => 'Please fill in all required fields.';

  @override
  String get addReviewAirlineHint => 'Airline';

  @override
  String get addReviewFlightNumberHint => 'Flight number';

  @override
  String get addReviewRatingLabel => 'Rating';

  @override
  String get addReviewCommentHint => 'Comment (optional)';

  @override
  String get addReviewSaveButton => 'Save review';

  @override
  String addReviewExtraSlotsAvailable(Object count) {
    return '🎁 You have $count extra reviews available!';
  }

  @override
  String get errorLoadingData => 'Error loading data.';

  @override
  String get noDataAvailable => 'No data available.';

  @override
  String get myReviewsAppBarTitle => 'My Reviews';

  @override
  String get myReviewsLoginPrompt => 'Please log in to see your reviews.';

  @override
  String get myReviewsAdvancedFiltersButton => 'Advanced Filters';

  @override
  String get myReviewsStatsButton => 'Statistics';

  @override
  String get myReviewsNoReviews => 'You haven\'t written any reviews yet.';

  @override
  String get myReviewsSmartModalTitle => 'Discover Your Impact!';

  @override
  String myReviewsSmartModalContent(Object airlineName, Object count) {
    return 'You\'ve reviewed $count flights with $airlineName. With Premium, you can see the impact of your ratings on this airline!';
  }

  @override
  String get myReviewsSmartModalLaterButton => 'Not now';

  @override
  String get myReviewsSmartModalDiscoverButton => 'Discover Premium';

  @override
  String get profileAppBarTitle => 'Profile';

  @override
  String get profileTabLabel => 'Profile';

  @override
  String get profileTabPremiumLabel => 'Premium Only';

  @override
  String get profileNotLoggedIn =>
      'You are not logged in. Please log in to see your profile.';

  @override
  String get profileWelcomeMessage =>
      'Welcome to JetPin!\n\nUser info and recent activity will be shown here.';

  @override
  String profilePremiumTrialExpiresSoon(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '⏳ Your free trial expires in $days $_temp0!';
  }

  @override
  String profileBadgeLegend(Object count) {
    return '👑 JetPin Legend ($count+ friends)';
  }

  @override
  String profileBadgeInfluencer(Object count) {
    return '🚀 JetPin Influencer ($count+ friends)';
  }

  @override
  String profileBadgePromoter(Object count) {
    return '🎉 Super Promoter ($count+ friends)';
  }

  @override
  String get profileBadgeUsedReferral =>
      '🏡 You received a bonus from an invite!';

  @override
  String profileReferralCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'friends',
      one: 'friend',
    );
    return 'You\'ve invited $count $_temp0!';
  }

  @override
  String profileExtraSlots(Object count) {
    return 'You\'ve received $count bonus slots in total!';
  }

  @override
  String get profileUnlockedRewardsTitle => 'Unlocked Rewards:';

  @override
  String get profileInviteMoreForBadges =>
      '🎯 Invite more friends to unlock new badges!';

  @override
  String get profileErrorLoadingPremium => 'Error loading Premium status.';

  @override
  String get profileUserIsPremium => 'Premium User';

  @override
  String profilePremiumTrialDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days remaining',
      one: 'day remaining',
    );
    return '🏡 Free trial: $days $_temp0';
  }

  @override
  String get profileBackupComplete => 'Backup completed';

  @override
  String get profileBackupCloudButton => 'Cloud Backup';

  @override
  String profileLastBackupDate(Object dateTime) {
    return '☁️ Last backup: $dateTime';
  }

  @override
  String get atTimeConnector => 'at';

  @override
  String get profileAdvancedStatsButton => 'Advanced Statistics';

  @override
  String profileShareInviteMessage(Object referralCode) {
    return 'Join JetPin! Use this invite code ($referralCode) to get special bonuses!';
  }

  @override
  String get profileShareInviteButton => 'Invite a friend';

  @override
  String get profileWhatIsPremiumButton => 'What is JetPin Premium?';

  @override
  String get profileLogoutDialogTitle => 'Do you really want to log out?';

  @override
  String get profileLogoutDialogContent =>
      'You will lose access to features available only to logged-in users.';

  @override
  String get profileLogoutSuccess => 'Logged out successfully.';

  @override
  String get premiumTabTitle => 'JetPin Premium';

  @override
  String get premiumFeatureNoAds => 'No advertisements';

  @override
  String get premiumFeatureUnlimitedPins => 'Unlimited reviews';

  @override
  String get premiumFeatureCloudBackup => 'Automatic cloud backup';

  @override
  String get premiumFeatureFlightTracking =>
      'Flight & Itinerary Tracking (Coming Soon)';

  @override
  String get premiumFeatureAiFeatures => 'AI Features (Coming Soon)';

  @override
  String get premiumFeatureSmartItineraries =>
      'Smart Itineraries (Coming Soon)';

  @override
  String get premiumFeatureSuperCreatorBadge => 'Super Creator Badge';

  @override
  String get premiumTabDiscoverButton => 'Discover Premium';

  @override
  String get upgradePremiumAppBarTitle => 'Upgrade to Premium';

  @override
  String get loadingText => 'Loading...';

  @override
  String get upgradePremiumAlreadyPremium =>
      '✅ You are already a Premium user!';

  @override
  String get goBackButton => 'Go Back';

  @override
  String get upgradePremiumLimitReachedTitle =>
      '🚫 You\'ve reached the limits of your free account.';

  @override
  String get upgradePremiumBenefitPrompt =>
      'Upgrade to JetPin Premium to unlock all features!';

  @override
  String get upgradePremiumFeaturesTitle => '💎 What you get with Premium';

  @override
  String get premiumFeatureUnlimitedPinsDesc =>
      'Add as many reviews as you want, limitlessly.';

  @override
  String get premiumFeatureExportPdf => 'Export Reviews';

  @override
  String get premiumFeatureExportPdfDesc =>
      'Keep and share your reviews in PDF format.';

  @override
  String get premiumFeatureDetailedStats => 'Detailed Statistics';

  @override
  String get premiumFeatureDetailedStatsDesc =>
      'Understand the impact of your ratings.';

  @override
  String get premiumFeatureCloudBackupDesc =>
      'Protect your data with automatic cloud backups.';

  @override
  String upgradePremiumTrialActiveDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days remaining',
      one: 'day remaining',
    );
    return '📆 Free trial active: $days $_temp0.';
  }

  @override
  String get upgradePremiumTrialAvailable =>
      'You are eligible for a 7-day free trial!';

  @override
  String get upgradePremiumActivateTrialButton =>
      'Activate Free Trial (7 days)';

  @override
  String get upgradePremiumTrialNoCharge =>
      '🔒 No charges before the trial ends.';

  @override
  String get upgradePremiumTrialUsed =>
      'You have already used your free trial.';

  @override
  String get upgradePremiumActivateButton => 'Activate Premium Now';

  @override
  String priceInfo(Object billingPeriod, Object price) {
    return '$price$billingPeriod';
  }

  @override
  String get priceValue => '\$4.99';

  @override
  String get billingPeriodMonthly => '/month';

  @override
  String get cancelAnytime => 'cancel anytime';

  @override
  String upgradePremiumPriceInfoFull(
      Object cancellationPolicy, Object formattedPriceInfo) {
    return '$formattedPriceInfo — $cancellationPolicy';
  }

  @override
  String get workInProgressTitle => 'Work in Progress';

  @override
  String get workInProgressContent =>
      'Real purchases will be available in the final version of the app.';

  @override
  String get okButton => 'OK';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get applyButton => 'Apply';

  @override
  String get closeButton => 'Close';

  @override
  String get yesButton => 'Yes';

  @override
  String get noButton => 'No';

  @override
  String get logout => 'Logout';

  @override
  String get upgradePremiumLoginToActivateTrial =>
      'Please log in to activate the free trial.';

  @override
  String get upgradePremiumTrialActivatedSuccess =>
      '🎉 Free trial activated! Enjoy JetPin Premium.';

  @override
  String get upgradePremiumTrialAlreadyUsedError =>
      'Error: Free trial has already been used or could not be activated.';

  @override
  String get notificationChannelName => 'JetPin Reminders';

  @override
  String get notificationChannelDescription =>
      'Important reminders and notifications from the JetPin app.';

  @override
  String get notificationPermissionDialogTitle => 'Notification Permissions';

  @override
  String get notificationPermissionDialogContent =>
      'JetPin would like to send you notifications for helpful reminders and updates. Would you like to enable them?';

  @override
  String get reviewLimitWarningTitle => '📢 Review Limit Warning!';

  @override
  String reviewLimitWarningBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reviews',
      one: 'review',
    );
    return 'You\'re nearing your free review limit. Only $count $_temp0 left. Upgrade to Premium or watch a video for more slots!';
  }

  @override
  String get reviewLimitReachedTitle => '🚫 Review Limit Reached';

  @override
  String get reviewLimitReachedBody =>
      'You\'ve used all your free reviews. Upgrade to Premium or watch a video to continue writing!';

  @override
  String get errorSavingReview =>
      'An error occurred while saving your review. Please try again.';

  @override
  String get errorUpdatingSlotsAfterReward =>
      'Error updating slots after the video reward.';

  @override
  String get reviewFiltersDialogTitle => 'Advanced Review Filters';

  @override
  String get reviewFilterAll => 'All reviews';

  @override
  String get reviewFilter5Stars => '5 stars only';

  @override
  String get reviewFilter4PlusStars => '4 stars and up';

  @override
  String get reviewFilterNegative =>
      'Negative reviews only (less than 3 stars)';

  @override
  String get reviewStatsDialogTitle => 'Personal Statistics';

  @override
  String get reviewStatsTotalReviewsLabel => 'Total reviews:';

  @override
  String get reviewStatsAverageRatingLabel => 'Average rating:';

  @override
  String reviewStatsAverageRatingLabelFull(Object averageRating) {
    return '⭐ Average rating: $averageRating';
  }

  @override
  String get reviewStatsLongestReviewLabel => 'Most frequent review (example):';

  @override
  String get reviewStatsLongestReviewExample =>
      'Flight on time and very kind cabin crew.';

  @override
  String get reviewStatsNoLongestReview => 'No review data available.';

  @override
  String get themeSelectionClassicTheme => 'Classic Theme';

  @override
  String get themeSelectionPremiumTheme => 'Exclusive Premium Theme';

  @override
  String get unlockOptionsDialogTitle => 'Free Review Limit Reached';

  @override
  String get unlockOptionsDialogContent =>
      'To add more reviews, please choose one of the following options:';

  @override
  String get unlockOptionsGoPremium => 'Upgrade to Premium';

  @override
  String get unlockOptionsWatchVideoButton => 'Watch a Video (Extra Slots)';

  @override
  String get unlockOptionsInviteFriendButton => 'Invite a Friend (Bonus)';

  @override
  String get unlockOptionsLoginRequired =>
      '⚠️ Please log in to use this feature.';

  @override
  String get unlockOptionsShareDialogTitle => 'Share JetPin & Get Bonuses!';

  @override
  String get unlockOptionsErrorGeneratingInviteLink =>
      'Sorry, there was an error generating the invite link. Please try again later.';

  @override
  String get upgradePremiumModalTitle => 'Upgrade to JetPin Premium';

  @override
  String get upgradeFeatureMapFilter =>
      'Unlock advanced map filters with JetPin Premium!';

  @override
  String get upgradeFeaturePinStats =>
      'Access advanced statistics for your Pins only with Premium.';

  @override
  String get upgradeFeaturePinExport =>
      'Export your Pin data and back it up to the cloud with Premium.';

  @override
  String get upgradeFeatureBackupCloud =>
      'Securely back up your data to the cloud with JetPin Premium.';

  @override
  String get upgradeFeatureThemes =>
      'Customize the app with exclusive themes available only for Premium users!';

  @override
  String get upgradeFeaturePinAdd =>
      'You\'ve reached the free Pin limit. Upgrade to Premium to add more!';

  @override
  String get upgradeFeatureReviewLimit =>
      'You\'ve reached the free review limit. Upgrade to JetPin Premium to continue writing!';

  @override
  String get upgradeFeatureReviewFilters =>
      'Filter reviews by airline, rating, and date: only for Premium users!';

  @override
  String get upgradeFeatureReviewStats =>
      'Discover detailed statistics of your reviews with JetPin Premium!';

  @override
  String get upgradeFeatureReviewStatsHint =>
      'You\'ve reviewed many flights! With JetPin Premium, you can see your detailed impact on airlines.';

  @override
  String get upgradeFeatureDefault =>
      'This feature is only available with JetPin Premium. Upgrade to unlock it!';

  @override
  String get cloudBackupButtonLabel => 'Cloud Backup';

  @override
  String get cloudBackupSuccessMessage => 'Cloud backup successful!';

  @override
  String get cloudBackupFailedMessage =>
      'Cloud backup failed. Please try again.';

  @override
  String get exportDataButtonLabel => 'Export Data';

  @override
  String get exportDataButtonLabelPremiumRequired => 'Export Data (Premium)';

  @override
  String get jetpinAppBarLogoError => 'Logo Error';

  @override
  String get mapFiltersAllPins => 'All Pins';

  @override
  String get mapFiltersAdvanced => 'Advanced Filters';

  @override
  String pinAddLimitReachedMessage(Object limit) {
    return 'Only Premium users can add more than $limit Pins!';
  }

  @override
  String get pinAddUpgradeToPremiumButton => 'Upgrade to Premium';

  @override
  String get pinAddButtonLabel => 'Add Pin';

  @override
  String pinStatsTotalPins(Object count) {
    return 'Total Pins: $count';
  }

  @override
  String pinStatsLastPinDate(Object date) {
    return 'Last Pin added: $date';
  }

  @override
  String get pinStatsUnlockAdvancedButton => 'Unlock Advanced Pin Statistics';

  @override
  String get featureOnlyForPremiumUsers =>
      'This feature is available for Premium users only. Upgrade to access!';

  @override
  String get reviewStatsPageAppBarTitle => 'Review Statistics';

  @override
  String get reviewStatsByAirlineLabel => '✈️ Reviews by airline';

  @override
  String get reviewStatsByMonthLabel => '📊 Reviews by month';

  @override
  String get reviewStatsNoReviewsYet =>
      'You haven\'t written any reviews yet to display statistics.';

  @override
  String get reviewStatsNoAirlineData => 'No airline data available.';

  @override
  String get reviewStatsNoMonthlyData => 'No monthly review data available.';

  @override
  String get reviewStatsReviewSingular => 'review';

  @override
  String get reviewStatsReviewPlural => 'reviews';

  @override
  String get premiumPurchaseNotAvailable =>
      'In-app purchases are not available on this device.';

  @override
  String premiumPurchaseButtonIAP(Object price) {
    return 'Subscribe with $price';
  }

  @override
  String get premiumPurchaseButtonStripe => 'Pay with Stripe';

  @override
  String premiumPurchaseCannotLaunchUrl(Object url) {
    return 'Could not launch URL: $url';
  }

  @override
  String purchaseError(Object errorMessage) {
    return 'Purchase Error: $errorMessage';
  }

  @override
  String get purchaseFlowStartError => 'Could not start the purchase process.';

  @override
  String get referralShareWidgetTitle => '🎁 Invite a Friend!';

  @override
  String get referralShareWidgetDescription =>
      'Share your personal invite code. When a friend uses it to sign up for JetPin, you both get awesome benefits and rewards!';

  @override
  String get referralShareWidgetYourCodeLabel => 'Your invite code:';

  @override
  String get referralShareWidgetShareButton => 'Share Your Invite';

  @override
  String referralShareDefaultMessage(Object inviteLink, Object referralCode) {
    return 'Hey! Check out JetPin for reviewing your flights and travels. Use my invite code: $referralCode to get special bonuses!\nDownload the app here: $inviteLink';
  }

  @override
  String get premiumInfoDialogTitle => '✨ What JetPin Premium Includes';

  @override
  String get premiumInfoFeatureUnlimitedSlots => 'Unlimited reviews';

  @override
  String get premiumInfoFeaturePriorityAccess =>
      'Priority access to new features';

  @override
  String get premiumInfoDiscoverButton => 'Discover Premium';
}
