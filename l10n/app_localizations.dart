import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'JetPin'**
  String get appTitle;

  /// No description provided for @navigationReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get navigationReviews;

  /// No description provided for @navigationMyReviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get navigationMyReviews;

  /// No description provided for @navigationProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navigationProfile;

  /// No description provided for @logoNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Logo not found'**
  String get logoNotFoundError;

  /// No description provided for @logoNotFoundErrorShort.
  ///
  /// In en, this message translates to:
  /// **'Logo Error'**
  String get logoNotFoundErrorShort;

  /// No description provided for @commonExtraSlotsGranted.
  ///
  /// In en, this message translates to:
  /// **'🎉 {count} extra slots unlocked!'**
  String commonExtraSlotsGranted(Object count);

  /// No description provided for @rewardVideoLoadError.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Error loading the video'**
  String get rewardVideoLoadError;

  /// No description provided for @rewardVideoShowError.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Error showing the video'**
  String get rewardVideoShowError;

  /// No description provided for @referralDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Have an invite code?'**
  String get referralDialogTitle;

  /// No description provided for @referralDialogHint.
  ///
  /// In en, this message translates to:
  /// **'Invite code (UID)'**
  String get referralDialogHint;

  /// No description provided for @referralDialogSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get referralDialogSkipButton;

  /// No description provided for @referralDialogConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get referralDialogConfirmButton;

  /// No description provided for @referralInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid or self-referral code.'**
  String get referralInvalidCode;

  /// No description provided for @referralInviterNotFound.
  ///
  /// In en, this message translates to:
  /// **'Invite code not found.'**
  String get referralInviterNotFound;

  /// No description provided for @referralSuccess.
  ///
  /// In en, this message translates to:
  /// **'🎉 Bonus received thanks to the invite code!'**
  String get referralSuccess;

  /// No description provided for @rewardedAdAdsDisabled.
  ///
  /// In en, this message translates to:
  /// **'🎉 Ads disabled for {minutes} minutes!'**
  String rewardedAdAdsDisabled(Object minutes);

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {userName}!'**
  String loginWelcomeBack(Object userName);

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'guest'**
  String get guestUser;

  /// No description provided for @anonymousUser.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymousUser;

  /// No description provided for @loginCancelled.
  ///
  /// In en, this message translates to:
  /// **'Login cancelled.'**
  String get loginCancelled;

  /// No description provided for @addReviewSuccess.
  ///
  /// In en, this message translates to:
  /// **'Review added!'**
  String get addReviewSuccess;

  /// No description provided for @searchReviewsHint.
  ///
  /// In en, this message translates to:
  /// **'Search reviews...'**
  String get searchReviewsHint;

  /// No description provided for @watchAdToDisableAdsButton.
  ///
  /// In en, this message translates to:
  /// **'Watch an ad to remove ads'**
  String get watchAdToDisableAdsButton;

  /// No description provided for @reviewListPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Reviews will be displayed here...'**
  String get reviewListPlaceholder;

  /// No description provided for @addReviewTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add review'**
  String get addReviewTooltip;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @addReviewAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewAppBarTitle;

  /// No description provided for @addReviewFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields.'**
  String get addReviewFillAllFields;

  /// No description provided for @addReviewAirlineHint.
  ///
  /// In en, this message translates to:
  /// **'Airline'**
  String get addReviewAirlineHint;

  /// No description provided for @addReviewFlightNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Flight number'**
  String get addReviewFlightNumberHint;

  /// No description provided for @addReviewRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get addReviewRatingLabel;

  /// No description provided for @addReviewCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get addReviewCommentHint;

  /// No description provided for @addReviewSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save review'**
  String get addReviewSaveButton;

  /// No description provided for @addReviewExtraSlotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'🎁 You have {count} extra reviews available!'**
  String addReviewExtraSlotsAvailable(Object count);

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data.'**
  String get errorLoadingData;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available.'**
  String get noDataAvailable;

  /// No description provided for @myReviewsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviewsAppBarTitle;

  /// No description provided for @myReviewsLoginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please log in to see your reviews.'**
  String get myReviewsLoginPrompt;

  /// No description provided for @myReviewsAdvancedFiltersButton.
  ///
  /// In en, this message translates to:
  /// **'Advanced Filters'**
  String get myReviewsAdvancedFiltersButton;

  /// No description provided for @myReviewsStatsButton.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get myReviewsStatsButton;

  /// No description provided for @myReviewsNoReviews.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t written any reviews yet.'**
  String get myReviewsNoReviews;

  /// No description provided for @myReviewsSmartModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover Your Impact!'**
  String get myReviewsSmartModalTitle;

  /// No description provided for @myReviewsSmartModalContent.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reviewed {count} flights with {airlineName}. With Premium, you can see the impact of your ratings on this airline!'**
  String myReviewsSmartModalContent(Object airlineName, Object count);

  /// No description provided for @myReviewsSmartModalLaterButton.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get myReviewsSmartModalLaterButton;

  /// No description provided for @myReviewsSmartModalDiscoverButton.
  ///
  /// In en, this message translates to:
  /// **'Discover Premium'**
  String get myReviewsSmartModalDiscoverButton;

  /// No description provided for @profileAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileAppBarTitle;

  /// No description provided for @profileTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTabLabel;

  /// No description provided for @profileTabPremiumLabel.
  ///
  /// In en, this message translates to:
  /// **'Premium Only'**
  String get profileTabPremiumLabel;

  /// No description provided for @profileNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You are not logged in. Please log in to see your profile.'**
  String get profileNotLoggedIn;

  /// No description provided for @profileWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to JetPin!\n\nUser info and recent activity will be shown here.'**
  String get profileWelcomeMessage;

  /// No description provided for @profilePremiumTrialExpiresSoon.
  ///
  /// In en, this message translates to:
  /// **'⏳ Your free trial expires in {days} {days, plural, =1{day} other{days}}!'**
  String profilePremiumTrialExpiresSoon(num days);

  /// No description provided for @profileBadgeLegend.
  ///
  /// In en, this message translates to:
  /// **'👑 JetPin Legend ({count}+ friends)'**
  String profileBadgeLegend(Object count);

  /// No description provided for @profileBadgeInfluencer.
  ///
  /// In en, this message translates to:
  /// **'🚀 JetPin Influencer ({count}+ friends)'**
  String profileBadgeInfluencer(Object count);

  /// No description provided for @profileBadgePromoter.
  ///
  /// In en, this message translates to:
  /// **'🎉 Super Promoter ({count}+ friends)'**
  String profileBadgePromoter(Object count);

  /// No description provided for @profileBadgeUsedReferral.
  ///
  /// In en, this message translates to:
  /// **'🏡 You received a bonus from an invite!'**
  String get profileBadgeUsedReferral;

  /// No description provided for @profileReferralCount.
  ///
  /// In en, this message translates to:
  /// **'You\'ve invited {count} {count, plural, =1{friend} other{friends}}!'**
  String profileReferralCount(num count);

  /// No description provided for @profileExtraSlots.
  ///
  /// In en, this message translates to:
  /// **'You\'ve received {count} bonus slots in total!'**
  String profileExtraSlots(Object count);

  /// No description provided for @profileUnlockedRewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlocked Rewards:'**
  String get profileUnlockedRewardsTitle;

  /// No description provided for @profileInviteMoreForBadges.
  ///
  /// In en, this message translates to:
  /// **'🎯 Invite more friends to unlock new badges!'**
  String get profileInviteMoreForBadges;

  /// No description provided for @profileErrorLoadingPremium.
  ///
  /// In en, this message translates to:
  /// **'Error loading Premium status.'**
  String get profileErrorLoadingPremium;

  /// No description provided for @profileUserIsPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium User'**
  String get profileUserIsPremium;

  /// No description provided for @profilePremiumTrialDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'🏡 Free trial: {days} {days, plural, =1{day remaining} other{days remaining}}'**
  String profilePremiumTrialDaysLeft(num days);

  /// No description provided for @profileBackupComplete.
  ///
  /// In en, this message translates to:
  /// **'Backup completed'**
  String get profileBackupComplete;

  /// No description provided for @profileBackupCloudButton.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get profileBackupCloudButton;

  /// No description provided for @profileLastBackupDate.
  ///
  /// In en, this message translates to:
  /// **'☁️ Last backup: {dateTime}'**
  String profileLastBackupDate(Object dateTime);

  /// No description provided for @atTimeConnector.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get atTimeConnector;

  /// No description provided for @profileAdvancedStatsButton.
  ///
  /// In en, this message translates to:
  /// **'Advanced Statistics'**
  String get profileAdvancedStatsButton;

  /// No description provided for @profileShareInviteMessage.
  ///
  /// In en, this message translates to:
  /// **'Join JetPin! Use this invite code ({referralCode}) to get special bonuses!'**
  String profileShareInviteMessage(Object referralCode);

  /// No description provided for @profileShareInviteButton.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend'**
  String get profileShareInviteButton;

  /// No description provided for @profileWhatIsPremiumButton.
  ///
  /// In en, this message translates to:
  /// **'What is JetPin Premium?'**
  String get profileWhatIsPremiumButton;

  /// No description provided for @profileLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to log out?'**
  String get profileLogoutDialogTitle;

  /// No description provided for @profileLogoutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You will lose access to features available only to logged-in users.'**
  String get profileLogoutDialogContent;

  /// No description provided for @profileLogoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully.'**
  String get profileLogoutSuccess;

  /// No description provided for @premiumTabTitle.
  ///
  /// In en, this message translates to:
  /// **'JetPin Premium'**
  String get premiumTabTitle;

  /// No description provided for @premiumFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No advertisements'**
  String get premiumFeatureNoAds;

  /// No description provided for @premiumFeatureUnlimitedPins.
  ///
  /// In en, this message translates to:
  /// **'Unlimited reviews'**
  String get premiumFeatureUnlimitedPins;

  /// No description provided for @premiumFeatureCloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Automatic cloud backup'**
  String get premiumFeatureCloudBackup;

  /// No description provided for @premiumFeatureFlightTracking.
  ///
  /// In en, this message translates to:
  /// **'Flight & Itinerary Tracking (Coming Soon)'**
  String get premiumFeatureFlightTracking;

  /// No description provided for @premiumFeatureAiFeatures.
  ///
  /// In en, this message translates to:
  /// **'AI Features (Coming Soon)'**
  String get premiumFeatureAiFeatures;

  /// No description provided for @premiumFeatureSmartItineraries.
  ///
  /// In en, this message translates to:
  /// **'Smart Itineraries (Coming Soon)'**
  String get premiumFeatureSmartItineraries;

  /// No description provided for @premiumFeatureSuperCreatorBadge.
  ///
  /// In en, this message translates to:
  /// **'Super Creator Badge'**
  String get premiumFeatureSuperCreatorBadge;

  /// No description provided for @premiumTabDiscoverButton.
  ///
  /// In en, this message translates to:
  /// **'Discover Premium'**
  String get premiumTabDiscoverButton;

  /// No description provided for @upgradePremiumAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradePremiumAppBarTitle;

  /// No description provided for @loadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingText;

  /// No description provided for @upgradePremiumAlreadyPremium.
  ///
  /// In en, this message translates to:
  /// **'✅ You are already a Premium user!'**
  String get upgradePremiumAlreadyPremium;

  /// No description provided for @goBackButton.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBackButton;

  /// No description provided for @upgradePremiumLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'🚫 You\'ve reached the limits of your free account.'**
  String get upgradePremiumLimitReachedTitle;

  /// No description provided for @upgradePremiumBenefitPrompt.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to JetPin Premium to unlock all features!'**
  String get upgradePremiumBenefitPrompt;

  /// No description provided for @upgradePremiumFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'💎 What you get with Premium'**
  String get upgradePremiumFeaturesTitle;

  /// No description provided for @premiumFeatureUnlimitedPinsDesc.
  ///
  /// In en, this message translates to:
  /// **'Add as many reviews as you want, limitlessly.'**
  String get premiumFeatureUnlimitedPinsDesc;

  /// No description provided for @premiumFeatureExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export Reviews'**
  String get premiumFeatureExportPdf;

  /// No description provided for @premiumFeatureExportPdfDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep and share your reviews in PDF format.'**
  String get premiumFeatureExportPdfDesc;

  /// No description provided for @premiumFeatureDetailedStats.
  ///
  /// In en, this message translates to:
  /// **'Detailed Statistics'**
  String get premiumFeatureDetailedStats;

  /// No description provided for @premiumFeatureDetailedStatsDesc.
  ///
  /// In en, this message translates to:
  /// **'Understand the impact of your ratings.'**
  String get premiumFeatureDetailedStatsDesc;

  /// No description provided for @premiumFeatureCloudBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Protect your data with automatic cloud backups.'**
  String get premiumFeatureCloudBackupDesc;

  /// No description provided for @upgradePremiumTrialActiveDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'📆 Free trial active: {days} {days, plural, =1{day remaining} other{days remaining}}.'**
  String upgradePremiumTrialActiveDaysLeft(num days);

  /// No description provided for @upgradePremiumTrialAvailable.
  ///
  /// In en, this message translates to:
  /// **'You are eligible for a 7-day free trial!'**
  String get upgradePremiumTrialAvailable;

  /// No description provided for @upgradePremiumActivateTrialButton.
  ///
  /// In en, this message translates to:
  /// **'Activate Free Trial (7 days)'**
  String get upgradePremiumActivateTrialButton;

  /// No description provided for @upgradePremiumTrialNoCharge.
  ///
  /// In en, this message translates to:
  /// **'🔒 No charges before the trial ends.'**
  String get upgradePremiumTrialNoCharge;

  /// No description provided for @upgradePremiumTrialUsed.
  ///
  /// In en, this message translates to:
  /// **'You have already used your free trial.'**
  String get upgradePremiumTrialUsed;

  /// No description provided for @upgradePremiumActivateButton.
  ///
  /// In en, this message translates to:
  /// **'Activate Premium Now'**
  String get upgradePremiumActivateButton;

  /// No description provided for @priceInfo.
  ///
  /// In en, this message translates to:
  /// **'{price}{billingPeriod}'**
  String priceInfo(Object billingPeriod, Object price);

  /// No description provided for @priceValue.
  ///
  /// In en, this message translates to:
  /// **'\$4.99'**
  String get priceValue;

  /// No description provided for @billingPeriodMonthly.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get billingPeriodMonthly;

  /// No description provided for @cancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'cancel anytime'**
  String get cancelAnytime;

  /// No description provided for @upgradePremiumPriceInfoFull.
  ///
  /// In en, this message translates to:
  /// **'{formattedPriceInfo} — {cancellationPolicy}'**
  String upgradePremiumPriceInfoFull(
      Object cancellationPolicy, Object formattedPriceInfo);

  /// No description provided for @workInProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Work in Progress'**
  String get workInProgressTitle;

  /// No description provided for @workInProgressContent.
  ///
  /// In en, this message translates to:
  /// **'Real purchases will be available in the final version of the app.'**
  String get workInProgressContent;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @applyButton.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyButton;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @yesButton.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesButton;

  /// No description provided for @noButton.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noButton;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @upgradePremiumLoginToActivateTrial.
  ///
  /// In en, this message translates to:
  /// **'Please log in to activate the free trial.'**
  String get upgradePremiumLoginToActivateTrial;

  /// No description provided for @upgradePremiumTrialActivatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'🎉 Free trial activated! Enjoy JetPin Premium.'**
  String get upgradePremiumTrialActivatedSuccess;

  /// No description provided for @upgradePremiumTrialAlreadyUsedError.
  ///
  /// In en, this message translates to:
  /// **'Error: Free trial has already been used or could not be activated.'**
  String get upgradePremiumTrialAlreadyUsedError;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'JetPin Reminders'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Important reminders and notifications from the JetPin app.'**
  String get notificationChannelDescription;

  /// No description provided for @notificationPermissionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Permissions'**
  String get notificationPermissionDialogTitle;

  /// No description provided for @notificationPermissionDialogContent.
  ///
  /// In en, this message translates to:
  /// **'JetPin would like to send you notifications for helpful reminders and updates. Would you like to enable them?'**
  String get notificationPermissionDialogContent;

  /// No description provided for @reviewLimitWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'📢 Review Limit Warning!'**
  String get reviewLimitWarningTitle;

  /// No description provided for @reviewLimitWarningBody.
  ///
  /// In en, this message translates to:
  /// **'You\'re nearing your free review limit. Only {count} {count, plural, =1{review} other{reviews}} left. Upgrade to Premium or watch a video for more slots!'**
  String reviewLimitWarningBody(num count);

  /// No description provided for @reviewLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'🚫 Review Limit Reached'**
  String get reviewLimitReachedTitle;

  /// No description provided for @reviewLimitReachedBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used all your free reviews. Upgrade to Premium or watch a video to continue writing!'**
  String get reviewLimitReachedBody;

  /// No description provided for @errorSavingReview.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving your review. Please try again.'**
  String get errorSavingReview;

  /// No description provided for @errorUpdatingSlotsAfterReward.
  ///
  /// In en, this message translates to:
  /// **'Error updating slots after the video reward.'**
  String get errorUpdatingSlotsAfterReward;

  /// No description provided for @reviewFiltersDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Review Filters'**
  String get reviewFiltersDialogTitle;

  /// No description provided for @reviewFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All reviews'**
  String get reviewFilterAll;

  /// No description provided for @reviewFilter5Stars.
  ///
  /// In en, this message translates to:
  /// **'5 stars only'**
  String get reviewFilter5Stars;

  /// No description provided for @reviewFilter4PlusStars.
  ///
  /// In en, this message translates to:
  /// **'4 stars and up'**
  String get reviewFilter4PlusStars;

  /// No description provided for @reviewFilterNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative reviews only (less than 3 stars)'**
  String get reviewFilterNegative;

  /// No description provided for @reviewStatsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Statistics'**
  String get reviewStatsDialogTitle;

  /// No description provided for @reviewStatsTotalReviewsLabel.
  ///
  /// In en, this message translates to:
  /// **'Total reviews:'**
  String get reviewStatsTotalReviewsLabel;

  /// No description provided for @reviewStatsAverageRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Average rating:'**
  String get reviewStatsAverageRatingLabel;

  /// No description provided for @reviewStatsAverageRatingLabelFull.
  ///
  /// In en, this message translates to:
  /// **'⭐ Average rating: {averageRating}'**
  String reviewStatsAverageRatingLabelFull(Object averageRating);

  /// No description provided for @reviewStatsLongestReviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Most frequent review (example):'**
  String get reviewStatsLongestReviewLabel;

  /// No description provided for @reviewStatsLongestReviewExample.
  ///
  /// In en, this message translates to:
  /// **'Flight on time and very kind cabin crew.'**
  String get reviewStatsLongestReviewExample;

  /// No description provided for @reviewStatsNoLongestReview.
  ///
  /// In en, this message translates to:
  /// **'No review data available.'**
  String get reviewStatsNoLongestReview;

  /// No description provided for @themeSelectionClassicTheme.
  ///
  /// In en, this message translates to:
  /// **'Classic Theme'**
  String get themeSelectionClassicTheme;

  /// No description provided for @themeSelectionPremiumTheme.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Premium Theme'**
  String get themeSelectionPremiumTheme;

  /// No description provided for @unlockOptionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Review Limit Reached'**
  String get unlockOptionsDialogTitle;

  /// No description provided for @unlockOptionsDialogContent.
  ///
  /// In en, this message translates to:
  /// **'To add more reviews, please choose one of the following options:'**
  String get unlockOptionsDialogContent;

  /// No description provided for @unlockOptionsGoPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get unlockOptionsGoPremium;

  /// No description provided for @unlockOptionsWatchVideoButton.
  ///
  /// In en, this message translates to:
  /// **'Watch a Video (Extra Slots)'**
  String get unlockOptionsWatchVideoButton;

  /// No description provided for @unlockOptionsInviteFriendButton.
  ///
  /// In en, this message translates to:
  /// **'Invite a Friend (Bonus)'**
  String get unlockOptionsInviteFriendButton;

  /// No description provided for @unlockOptionsLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please log in to use this feature.'**
  String get unlockOptionsLoginRequired;

  /// No description provided for @unlockOptionsShareDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Share JetPin & Get Bonuses!'**
  String get unlockOptionsShareDialogTitle;

  /// No description provided for @unlockOptionsErrorGeneratingInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there was an error generating the invite link. Please try again later.'**
  String get unlockOptionsErrorGeneratingInviteLink;

  /// No description provided for @upgradePremiumModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to JetPin Premium'**
  String get upgradePremiumModalTitle;

  /// No description provided for @upgradeFeatureMapFilter.
  ///
  /// In en, this message translates to:
  /// **'Unlock advanced map filters with JetPin Premium!'**
  String get upgradeFeatureMapFilter;

  /// No description provided for @upgradeFeaturePinStats.
  ///
  /// In en, this message translates to:
  /// **'Access advanced statistics for your Pins only with Premium.'**
  String get upgradeFeaturePinStats;

  /// No description provided for @upgradeFeaturePinExport.
  ///
  /// In en, this message translates to:
  /// **'Export your Pin data and back it up to the cloud with Premium.'**
  String get upgradeFeaturePinExport;

  /// No description provided for @upgradeFeatureBackupCloud.
  ///
  /// In en, this message translates to:
  /// **'Securely back up your data to the cloud with JetPin Premium.'**
  String get upgradeFeatureBackupCloud;

  /// No description provided for @upgradeFeatureThemes.
  ///
  /// In en, this message translates to:
  /// **'Customize the app with exclusive themes available only for Premium users!'**
  String get upgradeFeatureThemes;

  /// No description provided for @upgradeFeaturePinAdd.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the free Pin limit. Upgrade to Premium to add more!'**
  String get upgradeFeaturePinAdd;

  /// No description provided for @upgradeFeatureReviewLimit.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the free review limit. Upgrade to JetPin Premium to continue writing!'**
  String get upgradeFeatureReviewLimit;

  /// No description provided for @upgradeFeatureReviewFilters.
  ///
  /// In en, this message translates to:
  /// **'Filter reviews by airline, rating, and date: only for Premium users!'**
  String get upgradeFeatureReviewFilters;

  /// No description provided for @upgradeFeatureReviewStats.
  ///
  /// In en, this message translates to:
  /// **'Discover detailed statistics of your reviews with JetPin Premium!'**
  String get upgradeFeatureReviewStats;

  /// No description provided for @upgradeFeatureReviewStatsHint.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reviewed many flights! With JetPin Premium, you can see your detailed impact on airlines.'**
  String get upgradeFeatureReviewStatsHint;

  /// No description provided for @upgradeFeatureDefault.
  ///
  /// In en, this message translates to:
  /// **'This feature is only available with JetPin Premium. Upgrade to unlock it!'**
  String get upgradeFeatureDefault;

  /// No description provided for @cloudBackupButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackupButtonLabel;

  /// No description provided for @cloudBackupSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup successful!'**
  String get cloudBackupSuccessMessage;

  /// No description provided for @cloudBackupFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup failed. Please try again.'**
  String get cloudBackupFailedMessage;

  /// No description provided for @exportDataButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportDataButtonLabel;

  /// No description provided for @exportDataButtonLabelPremiumRequired.
  ///
  /// In en, this message translates to:
  /// **'Export Data (Premium)'**
  String get exportDataButtonLabelPremiumRequired;

  /// No description provided for @jetpinAppBarLogoError.
  ///
  /// In en, this message translates to:
  /// **'Logo Error'**
  String get jetpinAppBarLogoError;

  /// No description provided for @mapFiltersAllPins.
  ///
  /// In en, this message translates to:
  /// **'All Pins'**
  String get mapFiltersAllPins;

  /// No description provided for @mapFiltersAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced Filters'**
  String get mapFiltersAdvanced;

  /// No description provided for @pinAddLimitReachedMessage.
  ///
  /// In en, this message translates to:
  /// **'Only Premium users can add more than {limit} Pins!'**
  String pinAddLimitReachedMessage(Object limit);

  /// No description provided for @pinAddUpgradeToPremiumButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get pinAddUpgradeToPremiumButton;

  /// No description provided for @pinAddButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Pin'**
  String get pinAddButtonLabel;

  /// No description provided for @pinStatsTotalPins.
  ///
  /// In en, this message translates to:
  /// **'Total Pins: {count}'**
  String pinStatsTotalPins(Object count);

  /// No description provided for @pinStatsLastPinDate.
  ///
  /// In en, this message translates to:
  /// **'Last Pin added: {date}'**
  String pinStatsLastPinDate(Object date);

  /// No description provided for @pinStatsUnlockAdvancedButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock Advanced Pin Statistics'**
  String get pinStatsUnlockAdvancedButton;

  /// No description provided for @featureOnlyForPremiumUsers.
  ///
  /// In en, this message translates to:
  /// **'This feature is available for Premium users only. Upgrade to access!'**
  String get featureOnlyForPremiumUsers;

  /// No description provided for @reviewStatsPageAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Statistics'**
  String get reviewStatsPageAppBarTitle;

  /// No description provided for @reviewStatsByAirlineLabel.
  ///
  /// In en, this message translates to:
  /// **'✈️ Reviews by airline'**
  String get reviewStatsByAirlineLabel;

  /// No description provided for @reviewStatsByMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'📊 Reviews by month'**
  String get reviewStatsByMonthLabel;

  /// No description provided for @reviewStatsNoReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t written any reviews yet to display statistics.'**
  String get reviewStatsNoReviewsYet;

  /// No description provided for @reviewStatsNoAirlineData.
  ///
  /// In en, this message translates to:
  /// **'No airline data available.'**
  String get reviewStatsNoAirlineData;

  /// No description provided for @reviewStatsNoMonthlyData.
  ///
  /// In en, this message translates to:
  /// **'No monthly review data available.'**
  String get reviewStatsNoMonthlyData;

  /// No description provided for @reviewStatsReviewSingular.
  ///
  /// In en, this message translates to:
  /// **'review'**
  String get reviewStatsReviewSingular;

  /// No description provided for @reviewStatsReviewPlural.
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get reviewStatsReviewPlural;

  /// No description provided for @premiumPurchaseNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are not available on this device.'**
  String get premiumPurchaseNotAvailable;

  /// No description provided for @premiumPurchaseButtonIAP.
  ///
  /// In en, this message translates to:
  /// **'Subscribe with {price}'**
  String premiumPurchaseButtonIAP(Object price);

  /// No description provided for @premiumPurchaseButtonStripe.
  ///
  /// In en, this message translates to:
  /// **'Pay with Stripe'**
  String get premiumPurchaseButtonStripe;

  /// No description provided for @premiumPurchaseCannotLaunchUrl.
  ///
  /// In en, this message translates to:
  /// **'Could not launch URL: {url}'**
  String premiumPurchaseCannotLaunchUrl(Object url);

  /// No description provided for @purchaseError.
  ///
  /// In en, this message translates to:
  /// **'Purchase Error: {errorMessage}'**
  String purchaseError(Object errorMessage);

  /// No description provided for @purchaseFlowStartError.
  ///
  /// In en, this message translates to:
  /// **'Could not start the purchase process.'**
  String get purchaseFlowStartError;

  /// No description provided for @referralShareWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'🎁 Invite a Friend!'**
  String get referralShareWidgetTitle;

  /// No description provided for @referralShareWidgetDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your personal invite code. When a friend uses it to sign up for JetPin, you both get awesome benefits and rewards!'**
  String get referralShareWidgetDescription;

  /// No description provided for @referralShareWidgetYourCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Your invite code:'**
  String get referralShareWidgetYourCodeLabel;

  /// No description provided for @referralShareWidgetShareButton.
  ///
  /// In en, this message translates to:
  /// **'Share Your Invite'**
  String get referralShareWidgetShareButton;

  /// No description provided for @referralShareDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Hey! Check out JetPin for reviewing your flights and travels. Use my invite code: {referralCode} to get special bonuses!\nDownload the app here: {inviteLink}'**
  String referralShareDefaultMessage(Object inviteLink, Object referralCode);

  /// No description provided for @premiumInfoDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'✨ What JetPin Premium Includes'**
  String get premiumInfoDialogTitle;

  /// No description provided for @premiumInfoFeatureUnlimitedSlots.
  ///
  /// In en, this message translates to:
  /// **'Unlimited reviews'**
  String get premiumInfoFeatureUnlimitedSlots;

  /// No description provided for @premiumInfoFeaturePriorityAccess.
  ///
  /// In en, this message translates to:
  /// **'Priority access to new features'**
  String get premiumInfoFeaturePriorityAccess;

  /// No description provided for @premiumInfoDiscoverButton.
  ///
  /// In en, this message translates to:
  /// **'Discover Premium'**
  String get premiumInfoDiscoverButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
