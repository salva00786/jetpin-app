// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get accountDeleteRequiresRecentLogin =>
      'Account deletion failed. This operation may require a recent login. Please try logging in again and retry.';

  @override
  String get accountDeletedErrorMessage =>
      'Error deleting account. Please try again.';

  @override
  String get accountDeletionAllDeletedSuccessMessage =>
      'Account and all reviews deleted successfully.';

  @override
  String get accountDeletionAnonymizedSuccessMessage =>
      'Account deleted and reviews anonymized successfully.';

  @override
  String get accountDeletionConfirmButton => 'Confirm Deletion';

  @override
  String get accountDeletionFailedReviewOperationMessage =>
      'Error during review operation. Account not modified.';

  @override
  String get accountDeletionOptionAnonymizeDescription =>
      'Your account will be deleted, but your reviews will remain visible anonymously.';

  @override
  String get accountDeletionOptionAnonymizeLabel =>
      'Delete account and anonymize reviews';

  @override
  String get accountDeletionOptionDeleteAllDescription =>
      'This action is irreversible. All your data and reviews will be permanently removed.';

  @override
  String get accountDeletionOptionDeleteAllLabel =>
      'Delete account and all reviews';

  @override
  String get accountDeletionOptionsDialogMessage =>
      'Choose how to proceed with deleting your account:';

  @override
  String get accountDeletionOptionsDialogTitle => 'Account Deletion Options';

  @override
  String get accountDeletionRequestedMessage =>
      'Your account deletion request has been registered. The account will be processed for deletion.';

  @override
  String get accountDeletionRetrySuccessMessage =>
      'Re-authentication successful. Account deleted successfully.';

  @override
  String get addReviewAirlineHint => 'Airline';

  @override
  String get addReviewAppBarTitle => 'Add Review';

  @override
  String get addReviewCommentHint => 'Comment (optional)';

  @override
  String addReviewExtraSlotsAvailable(Object count) {
    return '🎁 You have $count extra reviews available!';
  }

  @override
  String get addReviewFillAllFields => 'Please fill in all required fields.';

  @override
  String get addReviewFlightNumberHint => 'Flight number';

  @override
  String get addReviewRatingLabel => 'Rating';

  @override
  String get addReviewSaveButton => 'Save Review';

  @override
  String get addReviewSuccess => 'Review added!';

  @override
  String get addReviewTooltip => 'Add review';

  @override
  String get addReviewUpdateButton => 'Update Review';

  @override
  String get addReviewUpdatePageTitle => 'Edit Review';

  @override
  String get anonymousUser => 'Anonymous User';

  @override
  String get appTitle => 'JetPin';

  @override
  String get applyButton => 'Apply';

  @override
  String get atTimeConnector => 'at';

  @override
  String get billingPeriodMonthly => '/month';

  @override
  String get cancelAnytime => 'cancel anytime';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get closeButton => 'Close';

  @override
  String get cloudBackupButtonLabel => 'Cloud Backup';

  @override
  String get cloudBackupFailedMessage =>
      'Error during cloud backup. Please try again.';

  @override
  String get cloudBackupSuccessMessage => 'Cloud backup successful!';

  @override
  String commonExtraSlotsGranted(Object count) {
    return '🎉 $count extra slots unlocked!';
  }

  @override
  String get deleteAccountButtonLabel => 'Delete Account';

  @override
  String get deleteAccountConfirmMessage =>
      'Are you sure you want to delete your account and all your data (reviews, profile, etc.)? This action is irreversible.';

  @override
  String get deleteAccountConfirmTitle => 'Confirm Account Deletion';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deleteReviewButtonLabel => 'Delete';

  @override
  String get deleteReviewConfirmMessage =>
      'Are you sure you want to delete this review? This action cannot be undone.';

  @override
  String get deleteReviewConfirmTitle => 'Confirm Review Deletion';

  @override
  String developedByText(String developerName) {
    return 'Developed by $developerName';
  }

  @override
  String get editReviewButtonLabel => 'Edit';

  @override
  String get errorDeletingReview => 'Error deleting review.';

  @override
  String get errorLoadingData => 'Error loading data.';

  @override
  String get errorSavingReview =>
      'An error occurred while saving the review. Please try again.';

  @override
  String get errorSendingReply => 'Error sending reply.';

  @override
  String get errorUpdatingReview => 'Error updating review.';

  @override
  String get errorUpdatingSlotsAfterReward =>
      'Error updating slots after the video reward.';

  @override
  String get errorUserNotLoggedInOrReviewBuildFailed =>
      'User not logged in or error creating review. Please try again.';

  @override
  String get exportDataButtonLabel => 'Export Data';

  @override
  String get exportDataButtonLabelPremiumRequired => 'Export Data (Premium)';

  @override
  String get featureOnlyForPremiumUsers =>
      'This feature is only available for Premium users. Upgrade to access!';

  @override
  String get goBackButton => 'Go back';

  @override
  String get guestUser => 'user';

  @override
  String get hideRepliesButtonLabel => 'Hide replies';

  @override
  String get interstitialAdShowError => '⚠️ Error showing ad';

  @override
  String get jetpinAppBarLogoError => 'Logo Error';

  @override
  String get loadingReauthenticating => 'Re-authenticating...';

  @override
  String get loadingRetryingDelete => 'Retrying account deletion...';

  @override
  String get loadingText => 'Loading...';

  @override
  String get loginButton => 'Login';

  @override
  String get loginCancelled => 'Login cancelled.';

  @override
  String get loginFailed => 'Login failed. Please try again.';

  @override
  String loginWelcomeBack(Object userName) {
    return 'Welcome back, $userName!';
  }

  @override
  String get logoNotFoundError => '⚠️ Logo not found';

  @override
  String get logoNotFoundErrorShort => 'Logo Error';

  @override
  String get logoutButton => 'Logout';

  @override
  String get mapFiltersAdvanced => 'Advanced Filters';

  @override
  String get mapFiltersAllPins => 'All Pins';

  @override
  String get myReviewsAdvancedFiltersButton => 'Advanced Filters';

  @override
  String get myReviewsAppBarTitle => 'My Reviews';

  @override
  String get myReviewsLoginPrompt => 'Log in to see your reviews.';

  @override
  String get myReviewsNoReviews => 'You haven\'t written any reviews yet.';

  @override
  String myReviewsSmartModalContent(Object airlineName, Object count) {
    return 'You\'ve reviewed $count flights with $airlineName. With Premium, you can see the impact of your rating on this airline!';
  }

  @override
  String get myReviewsSmartModalDiscoverButton => 'Discover Premium';

  @override
  String get myReviewsSmartModalLaterButton => 'Not now';

  @override
  String get myReviewsSmartModalTitle => 'Discover Your Impact!';

  @override
  String get myReviewsStatsButton => 'Statistics';

  @override
  String get navigationMyReviews => 'My Reviews';

  @override
  String get navigationProfile => 'Profile';

  @override
  String get navigationReviews => 'Reviews';

  @override
  String get noButton => 'No';

  @override
  String get noDataAvailable => 'No data available.';

  @override
  String get notificationChannelDescription =>
      'Important reminders and notifications from the JetPin app.';

  @override
  String get notificationChannelName => 'JetPin Reminders';

  @override
  String get notificationPermissionDialogContent =>
      'JetPin would like to send you notifications for useful reminders and updates. Would you like to enable them?';

  @override
  String get notificationPermissionDialogTitle => 'Notification Permission';

  @override
  String get okButton => 'OK';

  @override
  String get pinAddButtonLabel => 'Add Pin';

  @override
  String pinAddLimitReachedMessage(Object limit) {
    return 'Only Premium users can add more than $limit Pins!';
  }

  @override
  String get pinAddUpgradeToPremiumButton => 'Upgrade to Premium';

  @override
  String pinStatsLastPinDate(Object date) {
    return 'Last Pin added: $date';
  }

  @override
  String pinStatsTotalPins(Object count) {
    return 'Total number of Pins: $count';
  }

  @override
  String get pinStatsUnlockAdvancedButton => 'Unlock Advanced Pin Statistics';

  @override
  String get premiumFeatureAiFeatures => 'AI Features (Coming Soon)';

  @override
  String get premiumFeatureCloudBackup => 'Automatic Cloud Backup';

  @override
  String get premiumFeatureCloudBackupDesc =>
      'Protect your data with automatic cloud backups.';

  @override
  String get premiumFeatureDetailedStats => 'Detailed Statistics';

  @override
  String get premiumFeatureDetailedStatsDesc =>
      'Understand the impact of your ratings.';

  @override
  String get premiumFeatureExportPdf => 'Export Reviews';

  @override
  String get premiumFeatureExportPdfDesc =>
      'Keep and share your reviews in PDF format.';

  @override
  String get premiumFeatureFlightTracking =>
      'Flight Tracking & Itineraries (Coming Soon)';

  @override
  String get premiumFeatureNoAds => 'No Ads';

  @override
  String get premiumFeatureSmartItineraries =>
      'Smart Itineraries (Coming Soon)';

  @override
  String get premiumFeatureSuperCreatorBadge => 'Super Creator Badge';

  @override
  String get premiumFeatureUnlimitedPins => 'Unlimited Reviews';

  @override
  String get premiumFeatureUnlimitedPinsDesc =>
      'Add as many reviews as you want, without limits.';

  @override
  String get premiumInfoDiscoverButton => 'Discover Premium';

  @override
  String get premiumInfoFeaturePriorityAccess =>
      'Priority access to new features';

  @override
  String get premiumInfoFeatureUnlimitedSlots => 'Unlimited reviews';

  @override
  String get premiumInfoDialogTitle => '✨ What JetPin Premium Includes';

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
  String get premiumPurchaseNotAvailable =>
      'In-app purchases are not available on this device.';

  @override
  String get premiumTabDiscoverButton => 'Discover Premium';

  @override
  String get premiumTabTitle => 'JetPin Premium';

  @override
  String priceInfo(Object billingPeriod, Object price) {
    return '$price$billingPeriod';
  }

  @override
  String get priceValue => '\$4.99';

  @override
  String get privacyPolicyLinkText => 'Privacy Policy';

  @override
  String get profileAdvancedStatsButton => 'Advanced Statistics';

  @override
  String get profileAppBarTitle => 'Profile';

  @override
  String get profileBackupCloudButton => 'Cloud Backup';

  @override
  String get profileBackupComplete => 'Backup completed';

  @override
  String profileBadgeInfluencer(Object count) {
    return '🚀 JetPin Influencer ($count+ friends)';
  }

  @override
  String profileBadgeLegend(Object count) {
    return '👑 JetPin Legend ($count+ friends)';
  }

  @override
  String profileBadgePromoter(Object count) {
    return '🎉 Super Promoter ($count+ friends)';
  }

  @override
  String get profileBadgeUsedReferral =>
      '🏡 You received a bonus from an invitation!';

  @override
  String get profileErrorLoadingPremium => 'Error loading Premium status.';

  @override
  String profileExtraSlots(Object count) {
    return 'You\'ve received $count total bonus slots!';
  }

  @override
  String get profileInviteMoreForBadges =>
      '🎯 Invite more friends to unlock new badges!';

  @override
  String profileLastBackupDate(Object dateTime) {
    return '☁️ Last backup: $dateTime';
  }

  @override
  String get profileLogoutDialogContent =>
      'You will lose access to features available only to logged-in users.';

  @override
  String get profileLogoutDialogTitle => 'Do you really want to log out?';

  @override
  String get profileLogoutSuccess => 'Logout successful.';

  @override
  String get profileNotLoggedIn =>
      'You are not logged in. Please log in to see your profile.';

  @override
  String profilePremiumTrialDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days remaining',
      one: '1 day remaining',
    );
    return '🏡 Free trial: $_temp0';
  }

  @override
  String profilePremiumTrialExpiresSoon(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return '⏳ Your free trial expires in $_temp0!';
  }

  @override
  String profileReferralCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count friends',
      one: '1 friend',
    );
    return 'You\'ve invited $_temp0!';
  }

  @override
  String get profileShareInviteButton => 'Invite a Friend';

  @override
  String profileShareInviteMessage(Object inviteLink, Object referralCode) {
    return 'Join JetPin! Enter this invitation code ($referralCode) to receive special bonuses!\nDownload the app here: $inviteLink';
  }

  @override
  String get profileTabLabel => 'Profile';

  @override
  String get profileTabPremiumLabel => 'Premium Only';

  @override
  String get profileUnlockedRewardsTitle => 'Unlocked Rewards:';

  @override
  String get profileUserIsPremium => 'Premium User';

  @override
  String get profileWelcomeMessage =>
      'Welcome to JetPin!\n\nUser info and recent activity will be shown here.';

  @override
  String get profileWhatIsPremiumButton => 'What is JetPin Premium?';

  @override
  String purchaseError(Object errorMessage) {
    return 'Error during purchase: $errorMessage';
  }

  @override
  String get purchaseFlowStartError => 'Could not start the purchase process.';

  @override
  String get reauthenticateButton => 'Sign In Again';

  @override
  String get reauthenticationFailedMessage =>
      'Re-authentication failed. Please try again.';

  @override
  String get reauthenticationRequiredMessage =>
      'For your security, you need to sign in again before your account can be deleted. Do you want to proceed with signing in?';

  @override
  String get reauthenticationRequiredTitle => 'Authentication Required';

  @override
  String get referralDialogConfirmButton => 'Confirm';

  @override
  String get referralDialogHint => 'Invitation code (UID)';

  @override
  String get referralDialogSkipButton => 'Skip';

  @override
  String get referralDialogTitle => 'Do you have an invitation code?';

  @override
  String get referralInvalidCode => 'Invalid or self-referred invitation code.';

  @override
  String get referralInviterNotFound => 'Invitation code not found.';

  @override
  String referralShareDefaultMessage(Object inviteLink, Object referralCode) {
    return 'Hey! Try JetPin to review your flights and travels. Use my invitation code: $referralCode to get special bonuses!\nDownload the app here: $inviteLink';
  }

  @override
  String get referralShareWidgetDescription =>
      'Share your personal invitation code. When a friend uses it to sign up for JetPin, you both get fantastic benefits and rewards!';

  @override
  String get referralShareWidgetShareButton => 'Share Your Invitation';

  @override
  String get referralShareWidgetTitle => '🎁 Invite a Friend!';

  @override
  String get referralShareWidgetYourCodeLabel => 'Your invitation code:';

  @override
  String get referralSuccess =>
      '🎉 Bonus received thanks to the invitation code!';

  @override
  String get repliesSectionTitle => 'Replies';

  @override
  String get replyButtonLabel => 'Reply';

  @override
  String get replySentSuccessMessage => 'Reply sent successfully!';

  @override
  String get rewardVideoLoadError => '⚠️ Error loading video';

  @override
  String get rewardVideoShowError => '⚠️ Error showing video';

  @override
  String rewardedAdAdsDisabled(Object minutes) {
    return '🎉 Ads disabled for $minutes minutes!';
  }

  @override
  String reviewCardEditedOn(String date) {
    return 'Edited on $date';
  }

  @override
  String get reviewDeletedSuccessMessage => 'Review deleted successfully.';

  @override
  String get reviewEditedSuccessMessage => 'Review edited successfully!';

  @override
  String get reviewFilter4PlusStars => '4 stars and up';

  @override
  String get reviewFilter5Stars => '5 stars only';

  @override
  String get reviewFilterAll => 'All reviews';

  @override
  String get reviewFilterNegative =>
      'Negative reviews only (less than 3 stars)';

  @override
  String get reviewFiltersDialogTitle => 'Advanced Review Filters';

  @override
  String get reviewLimitReachedBody =>
      'You\'ve used all your free reviews. Upgrade to Premium or watch a video to keep writing!';

  @override
  String get reviewLimitReachedTitle => '🚫 Review Limit Reached';

  @override
  String reviewLimitWarningBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
    );
    return 'You\'ve almost reached your free limit. You only have $_temp0 left. Upgrade to Premium or watch a video for more slots!';
  }

  @override
  String get reviewLimitWarningTitle => '📢 Review Limit Warning!';

  @override
  String get reviewListPlaceholder => 'Reviews will be displayed here...';

  @override
  String get reviewStatsAverageRatingLabel => 'Average rating:';

  @override
  String reviewStatsAverageRatingLabelFull(Object averageRating) {
    return '⭐ Average rating: $averageRating';
  }

  @override
  String get reviewStatsByAirlineLabel => '✈️ Reviews by airline';

  @override
  String get reviewStatsByMonthLabel => '📊 Reviews by month';

  @override
  String get reviewStatsDialogTitle => 'Personal Statistics';

  @override
  String get reviewStatsLongestReviewExample =>
      'Flight on time and very kind cabin crew.';

  @override
  String get reviewStatsLongestReviewLabel => 'Most frequent review (example):';

  @override
  String get reviewStatsNoAirlineData => 'No data available for airlines.';

  @override
  String get reviewStatsNoLongestReview => 'No reviews available.';

  @override
  String get reviewStatsNoMonthlyData =>
      'No data available for monthly reviews.';

  @override
  String get reviewStatsNoReviewsYet =>
      'You haven\'t written any reviews yet to display statistics.';

  @override
  String get reviewStatsPageAppBarTitle => 'Review Statistics';

  @override
  String get reviewStatsReviewPlural => 'reviews';

  @override
  String get reviewStatsReviewSingular => 'review';

  @override
  String get reviewStatsTotalReviewsLabel => 'Total reviews:';

  @override
  String get searchReviewsHint => 'Search reviews...';

  @override
  String get sendReplyButtonLabel => 'Send';

  @override
  String get supportContactText => 'Support: jetpin@salvo00786.it';

  @override
  String get supportEmailSubject => 'JetPin App Support';

  @override
  String get termsOfServiceLinkText => 'Terms of Service';

  @override
  String get themeSelectionClassicTheme => 'Classic Theme';

  @override
  String get themeSelectionPremiumTheme => 'Exclusive Premium Theme';

  @override
  String get unlockOptionsDialogContent =>
      'To add more reviews, please choose one of the following options:';

  @override
  String get unlockOptionsDialogTitle => 'Free Review Limit Reached';

  @override
  String get unlockOptionsErrorGeneratingInviteLink =>
      'Sorry, there was an error generating the invitation link. Please try again later.';

  @override
  String get unlockOptionsGoPremium => 'Upgrade to Premium';

  @override
  String get unlockOptionsInviteFriendButton => 'Invite a Friend (Bonus)';

  @override
  String get unlockOptionsLoginRequired =>
      '⚠️ Please log in to use this feature.';

  @override
  String get unlockOptionsShareDialogTitle => 'Share JetPin & Get Bonuses!';

  @override
  String get unlockOptionsWatchVideoButton => 'Watch a Video (Extra Slots)';

  @override
  String get upgradeFeatureBackupCloud =>
      'Securely back up your data to the cloud with JetPin Premium.';

  @override
  String get upgradeFeatureDefault =>
      'This feature is only available with JetPin Premium. Upgrade to unlock it!';

  @override
  String get upgradeFeatureMapFilter =>
      'Unlock advanced map filters with JetPin Premium!';

  @override
  String get upgradeFeaturePinAdd =>
      'You\'ve reached the free Pin limit. Upgrade to Premium to add more!';

  @override
  String get upgradeFeaturePinExport =>
      'Export your Pin data and back it up to the cloud with Premium.';

  @override
  String get upgradeFeaturePinStats =>
      'Access advanced statistics for your Pins only with Premium.';

  @override
  String get upgradeFeatureReviewFilters =>
      'Filter reviews by airline, rating, and date: only for Premium users!';

  @override
  String get upgradeFeatureReviewLimit =>
      'You\'ve reached the free review limit. Upgrade to JetPin Premium to keep writing!';

  @override
  String get upgradeFeatureReviewStats =>
      'Discover detailed statistics of your reviews with JetPin Premium!';

  @override
  String get upgradeFeatureReviewStatsHint =>
      'You\'ve already reviewed many flights! With JetPin Premium you can see your detailed impact on airlines.';

  @override
  String get upgradeFeatureThemes =>
      'Customize the app with exclusive themes available only for Premium users!';

  @override
  String get upgradePremiumActivateButton => 'Activate Premium Now';

  @override
  String get upgradePremiumActivateTrialButton =>
      'Activate Free Trial (7 days)';

  @override
  String get upgradePremiumAlreadyPremium =>
      '✅ You are already a Premium user!';

  @override
  String get upgradePremiumAppBarTitle => 'Upgrade to Premium';

  @override
  String get upgradePremiumBenefitPrompt =>
      'Upgrade to JetPin Premium to unlock all features!';

  @override
  String get upgradePremiumFeaturesTitle => '💎 What you get with Premium';

  @override
  String get upgradePremiumLimitReachedTitle =>
      '🚫 You\'ve reached the limits of your free account.';

  @override
  String get upgradePremiumLoginToActivateTrial =>
      'Please log in to activate the free trial.';

  @override
  String get upgradePremiumModalTitle => 'Upgrade to JetPin Premium';

  @override
  String upgradePremiumPriceInfoFull(
      Object cancellationPolicy, Object formattedPriceInfo) {
    return '$formattedPriceInfo — $cancellationPolicy';
  }

  @override
  String get upgradePremiumTrialActivatedSuccess =>
      '🎉 Free trial activated! Enjoy JetPin Premium.';

  @override
  String upgradePremiumTrialActiveDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days remaining',
      one: '1 day remaining',
    );
    return '📆 Free trial active: you have $_temp0.';
  }

  @override
  String get upgradePremiumTrialAlreadyUsedError =>
      'Error: Free trial has already been used or could not be activated.';

  @override
  String get upgradePremiumTrialAvailable =>
      'You are eligible for a 7-day free trial!';

  @override
  String get upgradePremiumTrialNoCharge =>
      '🔒 No charge before the trial ends.';

  @override
  String get upgradePremiumTrialUsed =>
      'You have already used your free trial.';

  @override
  String get viewRepliesButtonLabel_one => 'View 1 reply';

  @override
  String viewRepliesButtonLabel_other(int count) {
    return 'View $count replies';
  }

  @override
  String get viewRepliesButtonLabel_zero => 'No replies';

  @override
  String get watchAdToDisableAdsButton => 'Watch a video to remove ads';

  @override
  String get workInProgressContent =>
      'Actual purchasing will be available in the final version of the app.';

  @override
  String get workInProgressTitle => 'Work in Progress';

  @override
  String get writeReplyHintText => 'Write a reply...';

  @override
  String get yesButton => 'Yes';

  @override
  String get deleteAccountOptionsDialogTitle => 'Account Deletion Options';

  @override
  String get deleteAccountOptionDialogMessage =>
      'Choose how to proceed with deleting your account:';

  @override
  String get deleteAccountOptionDeleteAllLabel =>
      'Delete account and all reviews';

  @override
  String get deleteAccountOptionDeleteAllDescription =>
      'This action is irreversible. All your data and reviews will be permanently removed.';

  @override
  String get deleteAccountOptionAnonymizeLabel =>
      'Delete account and anonymize reviews';

  @override
  String get deleteAccountOptionAnonymizeDescription =>
      'Your account will be deleted, but your reviews will remain visible anonymously.';

  @override
  String get deleteAccountConfirmButton => 'Confirm Deletion';

  @override
  String get markAsHelpfulButtonTooltip => 'Mark as helpful';

  @override
  String helpfulVotesLabel(Object count) {
    return '$count helpful';
  }

  @override
  String reviewSearchNoResults(String searchTerm) {
    return 'No reviews found for \'$searchTerm\'.';
  }

  @override
  String get reviewSearchOverallNoReviews =>
      'There are no reviews on JetPin yet. Be the first!';

  @override
  String get searchFlightStatusButtonLabel => 'Flight Status';

  @override
  String get searchFlightStatusTooltip =>
      'Search current flight status online (Premium)';

  @override
  String cannotLaunchUrlError(String url) {
    return 'Could not launch URL: $url';
  }

  @override
  String get editReplyButtonTooltip => 'Edit reply';

  @override
  String get deleteReplyButtonTooltip => 'Delete reply';

  @override
  String get editReplyDialogTitle => 'Edit your reply';

  @override
  String get updateReplyButtonLabel => 'Update';

  @override
  String get deleteReplyConfirmTitle => 'Confirm Reply Deletion';

  @override
  String get deleteReplyConfirmMessage =>
      'Are you sure you want to delete this reply? This action cannot be undone.';

  @override
  String get replyUpdatedSuccessMessage => 'Reply updated successfully!';

  @override
  String get replyDeletedSuccessMessage => 'Reply deleted successfully!';

  @override
  String get errorUpdatingReply => 'Error updating reply.';

  @override
  String get errorDeletingReply => 'Error deleting reply.';

  @override
  String replyCardEditedOn(Object date) {
    return 'Edited on $date';
  }

  @override
  String get comingSoonDialogTitle => 'Feature Coming Soon';

  @override
  String get comingSoonDialogMessage =>
      'This feature is under development and will be available in a future update. Thanks for your patience!';

  @override
  String get congratsVerifiedReviewer =>
      '🎉 Congratulations! You are now a Verified Reviewer!';

  @override
  String get profileBadgeVerifiedReviewer => '🏅 Verified Reviewer';

  @override
  String get referralApplyGeneralError =>
      'A general error occurred while applying the referral code.';

  @override
  String get accountDeletionProcessingReviewsMessage =>
      'Processing reviews for account deletion in progress...';

  @override
  String get accountDeletingMessage => 'Deleting account in progress...';

  @override
  String get noRepliesYet => 'No replies yet.';
}
