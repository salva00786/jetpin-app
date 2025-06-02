import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
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
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

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

  /// No description provided for @accountDeleteRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'Account deletion failed. This operation may require a recent login. Please try logging in again and retry.'**
  String get accountDeleteRequiresRecentLogin;

  /// No description provided for @accountDeletedErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error deleting account. Please try again.'**
  String get accountDeletedErrorMessage;

  /// No description provided for @accountDeletionAllDeletedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Account and all reviews deleted successfully.'**
  String get accountDeletionAllDeletedSuccessMessage;

  /// No description provided for @accountDeletionAnonymizedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Account deleted and reviews anonymized successfully.'**
  String get accountDeletionAnonymizedSuccessMessage;

  /// No description provided for @accountDeletionConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get accountDeletionConfirmButton;

  /// No description provided for @accountDeletionFailedReviewOperationMessage.
  ///
  /// In en, this message translates to:
  /// **'Error during review operation. Account not modified.'**
  String get accountDeletionFailedReviewOperationMessage;

  /// No description provided for @accountDeletionOptionAnonymizeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account will be deleted, but your reviews will remain visible anonymously.'**
  String get accountDeletionOptionAnonymizeDescription;

  /// No description provided for @accountDeletionOptionAnonymizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account and anonymize reviews'**
  String get accountDeletionOptionAnonymizeLabel;

  /// No description provided for @accountDeletionOptionDeleteAllDescription.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. All your data and reviews will be permanently removed.'**
  String get accountDeletionOptionDeleteAllDescription;

  /// No description provided for @accountDeletionOptionDeleteAllLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account and all reviews'**
  String get accountDeletionOptionDeleteAllLabel;

  /// No description provided for @accountDeletionOptionsDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose how to proceed with deleting your account:'**
  String get accountDeletionOptionsDialogMessage;

  /// No description provided for @accountDeletionOptionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Deletion Options'**
  String get accountDeletionOptionsDialogTitle;

  /// No description provided for @accountDeletionRequestedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account deletion request has been registered. The account will be processed for deletion.'**
  String get accountDeletionRequestedMessage;

  /// No description provided for @accountDeletionRetrySuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Re-authentication successful. Account deleted successfully.'**
  String get accountDeletionRetrySuccessMessage;

  /// No description provided for @addReviewAirlineHint.
  ///
  /// In en, this message translates to:
  /// **'Airline'**
  String get addReviewAirlineHint;

  /// No description provided for @addReviewAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewAppBarTitle;

  /// No description provided for @addReviewCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get addReviewCommentHint;

  /// No description provided for @addReviewExtraSlotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'🎁 You have {count} extra reviews available!'**
  String addReviewExtraSlotsAvailable(Object count);

  /// No description provided for @addReviewFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields.'**
  String get addReviewFillAllFields;

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

  /// No description provided for @addReviewSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Review'**
  String get addReviewSaveButton;

  /// No description provided for @addReviewSuccess.
  ///
  /// In en, this message translates to:
  /// **'Review added!'**
  String get addReviewSuccess;

  /// No description provided for @addReviewTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add review'**
  String get addReviewTooltip;

  /// No description provided for @addReviewUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update Review'**
  String get addReviewUpdateButton;

  /// No description provided for @addReviewUpdatePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get addReviewUpdatePageTitle;

  /// No description provided for @anonymousUser.
  ///
  /// In en, this message translates to:
  /// **'Anonymous User'**
  String get anonymousUser;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'JetPin'**
  String get appTitle;

  /// No description provided for @applyButton.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyButton;

  /// No description provided for @atTimeConnector.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get atTimeConnector;

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

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @cloudBackupButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackupButtonLabel;

  /// No description provided for @cloudBackupFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Error during cloud backup. Please try again.'**
  String get cloudBackupFailedMessage;

  /// No description provided for @cloudBackupSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup successful!'**
  String get cloudBackupSuccessMessage;

  /// No description provided for @commonExtraSlotsGranted.
  ///
  /// In en, this message translates to:
  /// **'🎉 {count} extra slots unlocked!'**
  String commonExtraSlotsGranted(Object count);

  /// No description provided for @deleteAccountButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountButtonLabel;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account and all your data (reviews, profile, etc.)? This action is irreversible.'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Account Deletion'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @deleteReviewButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteReviewButtonLabel;

  /// No description provided for @deleteReviewConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this review? This action cannot be undone.'**
  String get deleteReviewConfirmMessage;

  /// No description provided for @deleteReviewConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Review Deletion'**
  String get deleteReviewConfirmTitle;

  /// Text indicating who developed the app, with a placeholder for the developer's name.
  ///
  /// In en, this message translates to:
  /// **'Developed by {developerName}'**
  String developedByText(String developerName);

  /// No description provided for @editReviewButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editReviewButtonLabel;

  /// No description provided for @errorDeletingReview.
  ///
  /// In en, this message translates to:
  /// **'Error deleting review.'**
  String get errorDeletingReview;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data.'**
  String get errorLoadingData;

  /// No description provided for @errorSavingReview.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving the review. Please try again.'**
  String get errorSavingReview;

  /// No description provided for @errorSendingReply.
  ///
  /// In en, this message translates to:
  /// **'Error sending reply.'**
  String get errorSendingReply;

  /// No description provided for @errorUpdatingReview.
  ///
  /// In en, this message translates to:
  /// **'Error updating review.'**
  String get errorUpdatingReview;

  /// No description provided for @errorUpdatingSlotsAfterReward.
  ///
  /// In en, this message translates to:
  /// **'Error updating slots after the video reward.'**
  String get errorUpdatingSlotsAfterReward;

  /// No description provided for @errorUserNotLoggedInOrReviewBuildFailed.
  ///
  /// In en, this message translates to:
  /// **'User not logged in or error creating review. Please try again.'**
  String get errorUserNotLoggedInOrReviewBuildFailed;

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

  /// No description provided for @featureOnlyForPremiumUsers.
  ///
  /// In en, this message translates to:
  /// **'This feature is only available for Premium users. Upgrade to access!'**
  String get featureOnlyForPremiumUsers;

  /// No description provided for @goBackButton.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBackButton;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'user'**
  String get guestUser;

  /// No description provided for @hideRepliesButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Hide replies'**
  String get hideRepliesButtonLabel;

  /// No description provided for @interstitialAdShowError.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Error showing ad'**
  String get interstitialAdShowError;

  /// No description provided for @jetpinAppBarLogoError.
  ///
  /// In en, this message translates to:
  /// **'Logo Error'**
  String get jetpinAppBarLogoError;

  /// No description provided for @loadingReauthenticating.
  ///
  /// In en, this message translates to:
  /// **'Re-authenticating...'**
  String get loadingReauthenticating;

  /// No description provided for @loadingRetryingDelete.
  ///
  /// In en, this message translates to:
  /// **'Retrying account deletion...'**
  String get loadingRetryingDelete;

  /// No description provided for @loadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingText;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginCancelled.
  ///
  /// In en, this message translates to:
  /// **'Login cancelled.'**
  String get loginCancelled;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailed;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {userName}!'**
  String loginWelcomeBack(Object userName);

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

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @mapFiltersAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced Filters'**
  String get mapFiltersAdvanced;

  /// No description provided for @mapFiltersAllPins.
  ///
  /// In en, this message translates to:
  /// **'All Pins'**
  String get mapFiltersAllPins;

  /// No description provided for @myReviewsAdvancedFiltersButton.
  ///
  /// In en, this message translates to:
  /// **'Advanced Filters'**
  String get myReviewsAdvancedFiltersButton;

  /// No description provided for @myReviewsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviewsAppBarTitle;

  /// No description provided for @myReviewsLoginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Log in to see your reviews.'**
  String get myReviewsLoginPrompt;

  /// No description provided for @myReviewsNoReviews.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t written any reviews yet.'**
  String get myReviewsNoReviews;

  /// No description provided for @myReviewsSmartModalContent.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reviewed {count} flights with {airlineName}. With Premium, you can see the impact of your rating on this airline!'**
  String myReviewsSmartModalContent(Object airlineName, Object count);

  /// No description provided for @myReviewsSmartModalDiscoverButton.
  ///
  /// In en, this message translates to:
  /// **'Discover Premium'**
  String get myReviewsSmartModalDiscoverButton;

  /// No description provided for @myReviewsSmartModalLaterButton.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get myReviewsSmartModalLaterButton;

  /// No description provided for @myReviewsSmartModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover Your Impact!'**
  String get myReviewsSmartModalTitle;

  /// No description provided for @myReviewsStatsButton.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get myReviewsStatsButton;

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

  /// No description provided for @navigationReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get navigationReviews;

  /// No description provided for @noButton.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noButton;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available.'**
  String get noDataAvailable;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Important reminders and notifications from the JetPin app.'**
  String get notificationChannelDescription;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'JetPin Reminders'**
  String get notificationChannelName;

  /// No description provided for @notificationPermissionDialogContent.
  ///
  /// In en, this message translates to:
  /// **'JetPin would like to send you notifications for useful reminders and updates. Would you like to enable them?'**
  String get notificationPermissionDialogContent;

  /// No description provided for @notificationPermissionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get notificationPermissionDialogTitle;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @pinAddButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Pin'**
  String get pinAddButtonLabel;

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

  /// No description provided for @pinStatsLastPinDate.
  ///
  /// In en, this message translates to:
  /// **'Last Pin added: {date}'**
  String pinStatsLastPinDate(Object date);

  /// No description provided for @pinStatsTotalPins.
  ///
  /// In en, this message translates to:
  /// **'Total number of Pins: {count}'**
  String pinStatsTotalPins(Object count);

  /// No description provided for @pinStatsUnlockAdvancedButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock Advanced Pin Statistics'**
  String get pinStatsUnlockAdvancedButton;

  /// No description provided for @premiumFeatureAiFeatures.
  ///
  /// In en, this message translates to:
  /// **'AI Features (Coming Soon)'**
  String get premiumFeatureAiFeatures;

  /// No description provided for @premiumFeatureCloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Automatic Cloud Backup'**
  String get premiumFeatureCloudBackup;

  /// No description provided for @premiumFeatureCloudBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Protect your data with automatic cloud backups.'**
  String get premiumFeatureCloudBackupDesc;

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

  /// No description provided for @premiumFeatureFlightTracking.
  ///
  /// In en, this message translates to:
  /// **'Flight Tracking & Itineraries (Coming Soon)'**
  String get premiumFeatureFlightTracking;

  /// No description provided for @premiumFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get premiumFeatureNoAds;

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

  /// No description provided for @premiumFeatureUnlimitedPins.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Reviews'**
  String get premiumFeatureUnlimitedPins;

  /// No description provided for @premiumFeatureUnlimitedPinsDesc.
  ///
  /// In en, this message translates to:
  /// **'Add as many reviews as you want, without limits.'**
  String get premiumFeatureUnlimitedPinsDesc;

  /// No description provided for @premiumInfoDiscoverButton.
  ///
  /// In en, this message translates to:
  /// **'Discover Premium'**
  String get premiumInfoDiscoverButton;

  /// No description provided for @premiumInfoFeaturePriorityAccess.
  ///
  /// In en, this message translates to:
  /// **'Priority access to new features'**
  String get premiumInfoFeaturePriorityAccess;

  /// No description provided for @premiumInfoFeatureUnlimitedSlots.
  ///
  /// In en, this message translates to:
  /// **'Unlimited reviews'**
  String get premiumInfoFeatureUnlimitedSlots;

  /// No description provided for @premiumInfoDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'✨ What JetPin Premium Includes'**
  String get premiumInfoDialogTitle;

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

  /// No description provided for @premiumPurchaseNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are not available on this device.'**
  String get premiumPurchaseNotAvailable;

  /// No description provided for @premiumTabDiscoverButton.
  ///
  /// In en, this message translates to:
  /// **'Discover Premium'**
  String get premiumTabDiscoverButton;

  /// No description provided for @premiumTabTitle.
  ///
  /// In en, this message translates to:
  /// **'JetPin Premium'**
  String get premiumTabTitle;

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

  /// No description provided for @privacyPolicyLinkText.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLinkText;

  /// No description provided for @profileAdvancedStatsButton.
  ///
  /// In en, this message translates to:
  /// **'Advanced Statistics'**
  String get profileAdvancedStatsButton;

  /// No description provided for @profileAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileAppBarTitle;

  /// No description provided for @profileBackupCloudButton.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get profileBackupCloudButton;

  /// No description provided for @profileBackupComplete.
  ///
  /// In en, this message translates to:
  /// **'Backup completed'**
  String get profileBackupComplete;

  /// No description provided for @profileBadgeInfluencer.
  ///
  /// In en, this message translates to:
  /// **'🚀 JetPin Influencer ({count}+ friends)'**
  String profileBadgeInfluencer(Object count);

  /// No description provided for @profileBadgeLegend.
  ///
  /// In en, this message translates to:
  /// **'👑 JetPin Legend ({count}+ friends)'**
  String profileBadgeLegend(Object count);

  /// No description provided for @profileBadgePromoter.
  ///
  /// In en, this message translates to:
  /// **'🎉 Super Promoter ({count}+ friends)'**
  String profileBadgePromoter(Object count);

  /// No description provided for @profileBadgeUsedReferral.
  ///
  /// In en, this message translates to:
  /// **'🏡 You received a bonus from an invitation!'**
  String get profileBadgeUsedReferral;

  /// No description provided for @profileErrorLoadingPremium.
  ///
  /// In en, this message translates to:
  /// **'Error loading Premium status.'**
  String get profileErrorLoadingPremium;

  /// No description provided for @profileExtraSlots.
  ///
  /// In en, this message translates to:
  /// **'You\'ve received {count} total bonus slots!'**
  String profileExtraSlots(Object count);

  /// No description provided for @profileInviteMoreForBadges.
  ///
  /// In en, this message translates to:
  /// **'🎯 Invite more friends to unlock new badges!'**
  String get profileInviteMoreForBadges;

  /// No description provided for @profileLastBackupDate.
  ///
  /// In en, this message translates to:
  /// **'☁️ Last backup: {dateTime}'**
  String profileLastBackupDate(Object dateTime);

  /// No description provided for @profileLogoutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You will lose access to features available only to logged-in users.'**
  String get profileLogoutDialogContent;

  /// No description provided for @profileLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to log out?'**
  String get profileLogoutDialogTitle;

  /// No description provided for @profileLogoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logout successful.'**
  String get profileLogoutSuccess;

  /// No description provided for @profileNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You are not logged in. Please log in to see your profile.'**
  String get profileNotLoggedIn;

  /// No description provided for @profilePremiumTrialDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'🏡 Free trial: {days, plural, =1{1 day remaining} other{{days} days remaining}}'**
  String profilePremiumTrialDaysLeft(num days);

  /// No description provided for @profilePremiumTrialExpiresSoon.
  ///
  /// In en, this message translates to:
  /// **'⏳ Your free trial expires in {days, plural, =1{1 day} other{{days} days}}!'**
  String profilePremiumTrialExpiresSoon(num days);

  /// No description provided for @profileReferralCount.
  ///
  /// In en, this message translates to:
  /// **'You\'ve invited {count, plural, =1{1 friend} other{{count} friends}}!'**
  String profileReferralCount(num count);

  /// No description provided for @profileShareInviteButton.
  ///
  /// In en, this message translates to:
  /// **'Invite a Friend'**
  String get profileShareInviteButton;

  /// No description provided for @profileShareInviteMessage.
  ///
  /// In en, this message translates to:
  /// **'Join JetPin! Enter this invitation code ({referralCode}) to receive special bonuses!\nDownload the app here: {inviteLink}'**
  String profileShareInviteMessage(Object inviteLink, Object referralCode);

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

  /// No description provided for @profileUnlockedRewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlocked Rewards:'**
  String get profileUnlockedRewardsTitle;

  /// No description provided for @profileUserIsPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium User'**
  String get profileUserIsPremium;

  /// No description provided for @profileWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to JetPin!\n\nUser info and recent activity will be shown here.'**
  String get profileWelcomeMessage;

  /// No description provided for @profileWhatIsPremiumButton.
  ///
  /// In en, this message translates to:
  /// **'What is JetPin Premium?'**
  String get profileWhatIsPremiumButton;

  /// No description provided for @purchaseError.
  ///
  /// In en, this message translates to:
  /// **'Error during purchase: {errorMessage}'**
  String purchaseError(Object errorMessage);

  /// No description provided for @purchaseFlowStartError.
  ///
  /// In en, this message translates to:
  /// **'Could not start the purchase process.'**
  String get purchaseFlowStartError;

  /// No description provided for @reauthenticateButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In Again'**
  String get reauthenticateButton;

  /// No description provided for @reauthenticationFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Re-authentication failed. Please try again.'**
  String get reauthenticationFailedMessage;

  /// No description provided for @reauthenticationRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'For your security, you need to sign in again before your account can be deleted. Do you want to proceed with signing in?'**
  String get reauthenticationRequiredMessage;

  /// No description provided for @reauthenticationRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication Required'**
  String get reauthenticationRequiredTitle;

  /// No description provided for @referralDialogConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get referralDialogConfirmButton;

  /// No description provided for @referralDialogHint.
  ///
  /// In en, this message translates to:
  /// **'Invitation code (UID)'**
  String get referralDialogHint;

  /// No description provided for @referralDialogSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get referralDialogSkipButton;

  /// No description provided for @referralDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you have an invitation code?'**
  String get referralDialogTitle;

  /// No description provided for @referralInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid or self-referred invitation code.'**
  String get referralInvalidCode;

  /// No description provided for @referralInviterNotFound.
  ///
  /// In en, this message translates to:
  /// **'Invitation code not found.'**
  String get referralInviterNotFound;

  /// No description provided for @referralShareDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Hey! Try JetPin to review your flights and travels. Use my invitation code: {referralCode} to get special bonuses!\nDownload the app here: {inviteLink}'**
  String referralShareDefaultMessage(Object inviteLink, Object referralCode);

  /// No description provided for @referralShareWidgetDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your personal invitation code. When a friend uses it to sign up for JetPin, you both get fantastic benefits and rewards!'**
  String get referralShareWidgetDescription;

  /// No description provided for @referralShareWidgetShareButton.
  ///
  /// In en, this message translates to:
  /// **'Share Your Invitation'**
  String get referralShareWidgetShareButton;

  /// No description provided for @referralShareWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'🎁 Invite a Friend!'**
  String get referralShareWidgetTitle;

  /// No description provided for @referralShareWidgetYourCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Your invitation code:'**
  String get referralShareWidgetYourCodeLabel;

  /// No description provided for @referralSuccess.
  ///
  /// In en, this message translates to:
  /// **'🎉 Bonus received thanks to the invitation code!'**
  String get referralSuccess;

  /// No description provided for @repliesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Replies'**
  String get repliesSectionTitle;

  /// No description provided for @replyButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get replyButtonLabel;

  /// No description provided for @replySentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Reply sent successfully!'**
  String get replySentSuccessMessage;

  /// No description provided for @rewardVideoLoadError.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Error loading video'**
  String get rewardVideoLoadError;

  /// No description provided for @rewardVideoShowError.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Error showing video'**
  String get rewardVideoShowError;

  /// No description provided for @rewardedAdAdsDisabled.
  ///
  /// In en, this message translates to:
  /// **'🎉 Ads disabled for {minutes} minutes!'**
  String rewardedAdAdsDisabled(Object minutes);

  /// Label to show when a review was last edited, {date} is the placeholder for the formatted date.
  ///
  /// In en, this message translates to:
  /// **'Edited on {date}'**
  String reviewCardEditedOn(String date);

  /// No description provided for @reviewDeletedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Review deleted successfully.'**
  String get reviewDeletedSuccessMessage;

  /// No description provided for @reviewEditedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Review edited successfully!'**
  String get reviewEditedSuccessMessage;

  /// No description provided for @reviewFilter4PlusStars.
  ///
  /// In en, this message translates to:
  /// **'4 stars and up'**
  String get reviewFilter4PlusStars;

  /// No description provided for @reviewFilter5Stars.
  ///
  /// In en, this message translates to:
  /// **'5 stars only'**
  String get reviewFilter5Stars;

  /// No description provided for @reviewFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All reviews'**
  String get reviewFilterAll;

  /// No description provided for @reviewFilterNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative reviews only (less than 3 stars)'**
  String get reviewFilterNegative;

  /// No description provided for @reviewFiltersDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Review Filters'**
  String get reviewFiltersDialogTitle;

  /// No description provided for @reviewLimitReachedBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used all your free reviews. Upgrade to Premium or watch a video to keep writing!'**
  String get reviewLimitReachedBody;

  /// No description provided for @reviewLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'🚫 Review Limit Reached'**
  String get reviewLimitReachedTitle;

  /// No description provided for @reviewLimitWarningBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ve almost reached your free limit. You only have {count, plural, =1{1 review} other{{count} reviews}} left. Upgrade to Premium or watch a video for more slots!'**
  String reviewLimitWarningBody(num count);

  /// No description provided for @reviewLimitWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'📢 Review Limit Warning!'**
  String get reviewLimitWarningTitle;

  /// No description provided for @reviewListPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Reviews will be displayed here...'**
  String get reviewListPlaceholder;

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

  /// No description provided for @reviewStatsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Statistics'**
  String get reviewStatsDialogTitle;

  /// No description provided for @reviewStatsLongestReviewExample.
  ///
  /// In en, this message translates to:
  /// **'Flight on time and very kind cabin crew.'**
  String get reviewStatsLongestReviewExample;

  /// No description provided for @reviewStatsLongestReviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Most frequent review (example):'**
  String get reviewStatsLongestReviewLabel;

  /// No description provided for @reviewStatsNoAirlineData.
  ///
  /// In en, this message translates to:
  /// **'No data available for airlines.'**
  String get reviewStatsNoAirlineData;

  /// No description provided for @reviewStatsNoLongestReview.
  ///
  /// In en, this message translates to:
  /// **'No reviews available.'**
  String get reviewStatsNoLongestReview;

  /// No description provided for @reviewStatsNoMonthlyData.
  ///
  /// In en, this message translates to:
  /// **'No data available for monthly reviews.'**
  String get reviewStatsNoMonthlyData;

  /// No description provided for @reviewStatsNoReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t written any reviews yet to display statistics.'**
  String get reviewStatsNoReviewsYet;

  /// No description provided for @reviewStatsPageAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Statistics'**
  String get reviewStatsPageAppBarTitle;

  /// No description provided for @reviewStatsReviewPlural.
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get reviewStatsReviewPlural;

  /// No description provided for @reviewStatsReviewSingular.
  ///
  /// In en, this message translates to:
  /// **'review'**
  String get reviewStatsReviewSingular;

  /// No description provided for @reviewStatsTotalReviewsLabel.
  ///
  /// In en, this message translates to:
  /// **'Total reviews:'**
  String get reviewStatsTotalReviewsLabel;

  /// No description provided for @searchReviewsHint.
  ///
  /// In en, this message translates to:
  /// **'Search reviews...'**
  String get searchReviewsHint;

  /// No description provided for @sendReplyButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendReplyButtonLabel;

  /// No description provided for @supportContactText.
  ///
  /// In en, this message translates to:
  /// **'Support: jetpin@salvo00786.it'**
  String get supportContactText;

  /// No description provided for @supportEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'JetPin App Support'**
  String get supportEmailSubject;

  /// No description provided for @termsOfServiceLinkText.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceLinkText;

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

  /// No description provided for @unlockOptionsDialogContent.
  ///
  /// In en, this message translates to:
  /// **'To add more reviews, please choose one of the following options:'**
  String get unlockOptionsDialogContent;

  /// No description provided for @unlockOptionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Review Limit Reached'**
  String get unlockOptionsDialogTitle;

  /// No description provided for @unlockOptionsErrorGeneratingInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there was an error generating the invitation link. Please try again later.'**
  String get unlockOptionsErrorGeneratingInviteLink;

  /// No description provided for @unlockOptionsGoPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get unlockOptionsGoPremium;

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

  /// No description provided for @unlockOptionsWatchVideoButton.
  ///
  /// In en, this message translates to:
  /// **'Watch a Video (Extra Slots)'**
  String get unlockOptionsWatchVideoButton;

  /// No description provided for @upgradeFeatureBackupCloud.
  ///
  /// In en, this message translates to:
  /// **'Securely back up your data to the cloud with JetPin Premium.'**
  String get upgradeFeatureBackupCloud;

  /// No description provided for @upgradeFeatureDefault.
  ///
  /// In en, this message translates to:
  /// **'This feature is only available with JetPin Premium. Upgrade to unlock it!'**
  String get upgradeFeatureDefault;

  /// No description provided for @upgradeFeatureMapFilter.
  ///
  /// In en, this message translates to:
  /// **'Unlock advanced map filters with JetPin Premium!'**
  String get upgradeFeatureMapFilter;

  /// No description provided for @upgradeFeaturePinAdd.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the free Pin limit. Upgrade to Premium to add more!'**
  String get upgradeFeaturePinAdd;

  /// No description provided for @upgradeFeaturePinExport.
  ///
  /// In en, this message translates to:
  /// **'Export your Pin data and back it up to the cloud with Premium.'**
  String get upgradeFeaturePinExport;

  /// No description provided for @upgradeFeaturePinStats.
  ///
  /// In en, this message translates to:
  /// **'Access advanced statistics for your Pins only with Premium.'**
  String get upgradeFeaturePinStats;

  /// No description provided for @upgradeFeatureReviewFilters.
  ///
  /// In en, this message translates to:
  /// **'Filter reviews by airline, rating, and date: only for Premium users!'**
  String get upgradeFeatureReviewFilters;

  /// No description provided for @upgradeFeatureReviewLimit.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the free review limit. Upgrade to JetPin Premium to keep writing!'**
  String get upgradeFeatureReviewLimit;

  /// No description provided for @upgradeFeatureReviewStats.
  ///
  /// In en, this message translates to:
  /// **'Discover detailed statistics of your reviews with JetPin Premium!'**
  String get upgradeFeatureReviewStats;

  /// No description provided for @upgradeFeatureReviewStatsHint.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already reviewed many flights! With JetPin Premium you can see your detailed impact on airlines.'**
  String get upgradeFeatureReviewStatsHint;

  /// No description provided for @upgradeFeatureThemes.
  ///
  /// In en, this message translates to:
  /// **'Customize the app with exclusive themes available only for Premium users!'**
  String get upgradeFeatureThemes;

  /// No description provided for @upgradePremiumActivateButton.
  ///
  /// In en, this message translates to:
  /// **'Activate Premium Now'**
  String get upgradePremiumActivateButton;

  /// No description provided for @upgradePremiumActivateTrialButton.
  ///
  /// In en, this message translates to:
  /// **'Activate Free Trial (7 days)'**
  String get upgradePremiumActivateTrialButton;

  /// No description provided for @upgradePremiumAlreadyPremium.
  ///
  /// In en, this message translates to:
  /// **'✅ You are already a Premium user!'**
  String get upgradePremiumAlreadyPremium;

  /// No description provided for @upgradePremiumAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradePremiumAppBarTitle;

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

  /// No description provided for @upgradePremiumLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'🚫 You\'ve reached the limits of your free account.'**
  String get upgradePremiumLimitReachedTitle;

  /// No description provided for @upgradePremiumLoginToActivateTrial.
  ///
  /// In en, this message translates to:
  /// **'Please log in to activate the free trial.'**
  String get upgradePremiumLoginToActivateTrial;

  /// No description provided for @upgradePremiumModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to JetPin Premium'**
  String get upgradePremiumModalTitle;

  /// No description provided for @upgradePremiumPriceInfoFull.
  ///
  /// In en, this message translates to:
  /// **'{formattedPriceInfo} — {cancellationPolicy}'**
  String upgradePremiumPriceInfoFull(
      Object cancellationPolicy, Object formattedPriceInfo);

  /// No description provided for @upgradePremiumTrialActivatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'🎉 Free trial activated! Enjoy JetPin Premium.'**
  String get upgradePremiumTrialActivatedSuccess;

  /// No description provided for @upgradePremiumTrialActiveDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'📆 Free trial active: you have {days, plural, =1{1 day remaining} other{{days} days remaining}}.'**
  String upgradePremiumTrialActiveDaysLeft(num days);

  /// No description provided for @upgradePremiumTrialAlreadyUsedError.
  ///
  /// In en, this message translates to:
  /// **'Error: Free trial has already been used or could not be activated.'**
  String get upgradePremiumTrialAlreadyUsedError;

  /// No description provided for @upgradePremiumTrialAvailable.
  ///
  /// In en, this message translates to:
  /// **'You are eligible for a 7-day free trial!'**
  String get upgradePremiumTrialAvailable;

  /// No description provided for @upgradePremiumTrialNoCharge.
  ///
  /// In en, this message translates to:
  /// **'🔒 No charge before the trial ends.'**
  String get upgradePremiumTrialNoCharge;

  /// No description provided for @upgradePremiumTrialUsed.
  ///
  /// In en, this message translates to:
  /// **'You have already used your free trial.'**
  String get upgradePremiumTrialUsed;

  /// No description provided for @viewRepliesButtonLabel_one.
  ///
  /// In en, this message translates to:
  /// **'View 1 reply'**
  String get viewRepliesButtonLabel_one;

  /// Label for viewing replies, {count} is the number of replies.
  ///
  /// In en, this message translates to:
  /// **'View {count} replies'**
  String viewRepliesButtonLabel_other(int count);

  /// No description provided for @viewRepliesButtonLabel_zero.
  ///
  /// In en, this message translates to:
  /// **'No replies'**
  String get viewRepliesButtonLabel_zero;

  /// No description provided for @watchAdToDisableAdsButton.
  ///
  /// In en, this message translates to:
  /// **'Watch a video to remove ads'**
  String get watchAdToDisableAdsButton;

  /// No description provided for @workInProgressContent.
  ///
  /// In en, this message translates to:
  /// **'Actual purchasing will be available in the final version of the app.'**
  String get workInProgressContent;

  /// No description provided for @workInProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Work in Progress'**
  String get workInProgressTitle;

  /// No description provided for @writeReplyHintText.
  ///
  /// In en, this message translates to:
  /// **'Write a reply...'**
  String get writeReplyHintText;

  /// No description provided for @yesButton.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesButton;

  /// No description provided for @deleteAccountOptionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Deletion Options'**
  String get deleteAccountOptionsDialogTitle;

  /// No description provided for @deleteAccountOptionDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose how to proceed with deleting your account:'**
  String get deleteAccountOptionDialogMessage;

  /// No description provided for @deleteAccountOptionDeleteAllLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account and all reviews'**
  String get deleteAccountOptionDeleteAllLabel;

  /// No description provided for @deleteAccountOptionDeleteAllDescription.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. All your data and reviews will be permanently removed.'**
  String get deleteAccountOptionDeleteAllDescription;

  /// No description provided for @deleteAccountOptionAnonymizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account and anonymize reviews'**
  String get deleteAccountOptionAnonymizeLabel;

  /// No description provided for @deleteAccountOptionAnonymizeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account will be deleted, but your reviews will remain visible anonymously.'**
  String get deleteAccountOptionAnonymizeDescription;

  /// No description provided for @deleteAccountConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get deleteAccountConfirmButton;

  /// No description provided for @markAsHelpfulButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Mark as helpful'**
  String get markAsHelpfulButtonTooltip;

  /// No description provided for @helpfulVotesLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} helpful'**
  String helpfulVotesLabel(Object count);

  /// Message when review search yields no results.
  ///
  /// In en, this message translates to:
  /// **'No reviews found for \'{searchTerm}\'.'**
  String reviewSearchNoResults(String searchTerm);

  /// No description provided for @reviewSearchOverallNoReviews.
  ///
  /// In en, this message translates to:
  /// **'There are no reviews on JetPin yet. Be the first!'**
  String get reviewSearchOverallNoReviews;

  /// No description provided for @searchFlightStatusButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Flight Status'**
  String get searchFlightStatusButtonLabel;

  /// No description provided for @searchFlightStatusTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search current flight status online (Premium)'**
  String get searchFlightStatusTooltip;

  /// Error message when an URL cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'Could not launch URL: {url}'**
  String cannotLaunchUrlError(String url);

  /// No description provided for @editReplyButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit reply'**
  String get editReplyButtonTooltip;

  /// No description provided for @deleteReplyButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete reply'**
  String get deleteReplyButtonTooltip;

  /// No description provided for @editReplyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit your reply'**
  String get editReplyDialogTitle;

  /// No description provided for @updateReplyButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateReplyButtonLabel;

  /// No description provided for @deleteReplyConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Reply Deletion'**
  String get deleteReplyConfirmTitle;

  /// No description provided for @deleteReplyConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this reply? This action cannot be undone.'**
  String get deleteReplyConfirmMessage;

  /// No description provided for @replyUpdatedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Reply updated successfully!'**
  String get replyUpdatedSuccessMessage;

  /// No description provided for @replyDeletedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Reply deleted successfully!'**
  String get replyDeletedSuccessMessage;

  /// No description provided for @errorUpdatingReply.
  ///
  /// In en, this message translates to:
  /// **'Error updating reply.'**
  String get errorUpdatingReply;

  /// No description provided for @errorDeletingReply.
  ///
  /// In en, this message translates to:
  /// **'Error deleting reply.'**
  String get errorDeletingReply;

  /// No description provided for @replyCardEditedOn.
  ///
  /// In en, this message translates to:
  /// **'Edited on {date}'**
  String replyCardEditedOn(Object date);

  /// No description provided for @comingSoonDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Feature Coming Soon'**
  String get comingSoonDialogTitle;

  /// No description provided for @comingSoonDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature is under development and will be available in a future update. Thanks for your patience!'**
  String get comingSoonDialogMessage;

  /// No description provided for @congratsVerifiedReviewer.
  ///
  /// In en, this message translates to:
  /// **'🎉 Congratulations! You are now a Verified Reviewer!'**
  String get congratsVerifiedReviewer;

  /// No description provided for @profileBadgeVerifiedReviewer.
  ///
  /// In en, this message translates to:
  /// **'🏅 Verified Reviewer'**
  String get profileBadgeVerifiedReviewer;

  /// No description provided for @referralApplyGeneralError.
  ///
  /// In en, this message translates to:
  /// **'A general error occurred while applying the referral code.'**
  String get referralApplyGeneralError;

  /// No description provided for @accountDeletionProcessingReviewsMessage.
  ///
  /// In en, this message translates to:
  /// **'Processing reviews for account deletion in progress...'**
  String get accountDeletionProcessingReviewsMessage;

  /// No description provided for @accountDeletingMessage.
  ///
  /// In en, this message translates to:
  /// **'Deleting account in progress...'**
  String get accountDeletingMessage;

  /// Text shown when there are no replies to a review
  ///
  /// In en, this message translates to:
  /// **'No replies yet.'**
  String get noRepliesYet;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'it':
      return SIt();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
