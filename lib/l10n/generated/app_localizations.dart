import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SWAG of India'**
  String get appName;

  /// No description provided for @brandShort.
  ///
  /// In en, this message translates to:
  /// **'SOI'**
  String get brandShort;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get commonCopied;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get commonOpen;

  /// No description provided for @commonSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get commonSignIn;

  /// No description provided for @commonSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get commonSignOut;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @commonOptional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get commonOptional;

  /// No description provided for @commonSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get commonSeeAll;

  /// No description provided for @commonNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get commonNotNow;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour} other{{count} hours}}'**
  String commonHours(num count);

  /// No description provided for @commonHoursShort.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String commonHoursShort(String count);

  /// No description provided for @stateOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get stateOfflineTitle;

  /// No description provided for @stateOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again. Nothing you did has been lost.'**
  String get stateOfflineBody;

  /// No description provided for @stateErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get stateErrorTitle;

  /// No description provided for @stateErrorBody.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this right now. Please try again in a moment.'**
  String get stateErrorBody;

  /// No description provided for @stateNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get stateNotFoundTitle;

  /// No description provided for @stateNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'This link may be old or the item may have been removed.'**
  String get stateNotFoundBody;

  /// No description provided for @stateSignedOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get stateSignedOutTitle;

  /// No description provided for @stateSignedOutBody.
  ///
  /// In en, this message translates to:
  /// **'Free. Just an email. No documents, no fees.'**
  String get stateSignedOutBody;

  /// No description provided for @vocabDrive.
  ///
  /// In en, this message translates to:
  /// **'Drive'**
  String get vocabDrive;

  /// No description provided for @vocabDrives.
  ///
  /// In en, this message translates to:
  /// **'Drives'**
  String get vocabDrives;

  /// No description provided for @vocabPledge.
  ///
  /// In en, this message translates to:
  /// **'Pledge'**
  String get vocabPledge;

  /// No description provided for @vocabOrganisation.
  ///
  /// In en, this message translates to:
  /// **'Organisation'**
  String get vocabOrganisation;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get navCheckIn;

  /// No description provided for @navPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get navPassport;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get navManage;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Volunteering only counts when someone can vouch for it.'**
  String get welcomeTagline;

  /// No description provided for @welcomeLead.
  ///
  /// In en, this message translates to:
  /// **'Find drives run by NGOs, schools and companies. Turn up, scan the coordinator\'s QR, and your hours are signed off by the organisation itself.'**
  String get welcomeLead;

  /// No description provided for @welcomeStatOrganisations.
  ///
  /// In en, this message translates to:
  /// **'Organisations'**
  String get welcomeStatOrganisations;

  /// No description provided for @welcomeStatDrives.
  ///
  /// In en, this message translates to:
  /// **'Drives'**
  String get welcomeStatDrives;

  /// No description provided for @welcomeStatHours.
  ///
  /// In en, this message translates to:
  /// **'Certified hours'**
  String get welcomeStatHours;

  /// No description provided for @welcomeStatVolunteers.
  ///
  /// In en, this message translates to:
  /// **'Volunteers'**
  String get welcomeStatVolunteers;

  /// No description provided for @welcomeCtaBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse drives'**
  String get welcomeCtaBrowse;

  /// No description provided for @welcomeCtaSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in or create an account'**
  String get welcomeCtaSignIn;

  /// No description provided for @welcomeFree.
  ///
  /// In en, this message translates to:
  /// **'Free. Just an email — no documents, no fees.'**
  String get welcomeFree;

  /// No description provided for @welcomeStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Turn up'**
  String get welcomeStep1Title;

  /// No description provided for @welcomeStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Register for a drive near you and show up on the day.'**
  String get welcomeStep1Body;

  /// No description provided for @welcomeStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get welcomeStep2Title;

  /// No description provided for @welcomeStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Scan the coordinator\'s QR code at the venue. Your hours are recorded as pending.'**
  String get welcomeStep2Body;

  /// No description provided for @welcomeStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Get certified'**
  String get welcomeStep3Title;

  /// No description provided for @welcomeStep3Body.
  ///
  /// In en, this message translates to:
  /// **'The organisation confirms you were there. Your certificate can be verified by anyone.'**
  String get welcomeStep3Body;

  /// No description provided for @welcomeHappeningSoon.
  ///
  /// In en, this message translates to:
  /// **'Happening soon'**
  String get welcomeHappeningSoon;

  /// No description provided for @welcomeHavePledgeCode.
  ///
  /// In en, this message translates to:
  /// **'Have a pledge code?'**
  String get welcomeHavePledgeCode;

  /// No description provided for @welcomePledgeCodeHint.
  ///
  /// In en, this message translates to:
  /// **'6-character code'**
  String get welcomePledgeCodeHint;

  /// No description provided for @welcomeOpenPledge.
  ///
  /// In en, this message translates to:
  /// **'Open pledge'**
  String get welcomeOpenPledge;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @signInLead.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send a one-time code.'**
  String get signInLead;

  /// No description provided for @signInEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmailLabel;

  /// No description provided for @signInSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get signInSendCode;

  /// No description provided for @signInCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get signInCodeTitle;

  /// No description provided for @signInCodeLead.
  ///
  /// In en, this message translates to:
  /// **'We sent a code to {email}. It expires in a few minutes.'**
  String signInCodeLead(String email);

  /// No description provided for @signInCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'One-time code'**
  String get signInCodeLabel;

  /// No description provided for @signInVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get signInVerify;

  /// No description provided for @signInResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get signInResend;

  /// No description provided for @signInResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String signInResendIn(int seconds);

  /// No description provided for @signInSpamHint.
  ///
  /// In en, this message translates to:
  /// **'Not there? Check your spam folder.'**
  String get signInSpamHint;

  /// No description provided for @signInDifferentEmail.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get signInDifferentEmail;

  /// No description provided for @signInUsePassword.
  ///
  /// In en, this message translates to:
  /// **'Sign in with a password instead'**
  String get signInUsePassword;

  /// No description provided for @signInUseCode.
  ///
  /// In en, this message translates to:
  /// **'Sign in with a code instead'**
  String get signInUseCode;

  /// No description provided for @signInPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPasswordLabel;

  /// No description provided for @signInPasswordLead.
  ///
  /// In en, this message translates to:
  /// **'For accounts set up with a password.'**
  String get signInPasswordLead;

  /// No description provided for @signInLegal.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to our privacy policy.'**
  String get signInLegal;

  /// No description provided for @onboardNameTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get onboardNameTitle;

  /// No description provided for @onboardNameLead.
  ///
  /// In en, this message translates to:
  /// **'This is the name printed on your certificates. Use your real name as a college or employer would expect to see it.'**
  String get onboardNameLead;

  /// No description provided for @onboardNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get onboardNameLabel;

  /// No description provided for @onboardIntentTitle.
  ///
  /// In en, this message translates to:
  /// **'How will you use SOI?'**
  String get onboardIntentTitle;

  /// No description provided for @onboardIntentLead.
  ///
  /// In en, this message translates to:
  /// **'You can always do both. This just sets up your first screen.'**
  String get onboardIntentLead;

  /// No description provided for @onboardIntentVolunteerTitle.
  ///
  /// In en, this message translates to:
  /// **'I volunteer'**
  String get onboardIntentVolunteerTitle;

  /// No description provided for @onboardIntentVolunteerBody.
  ///
  /// In en, this message translates to:
  /// **'Find drives, check in, collect certified hours.'**
  String get onboardIntentVolunteerBody;

  /// No description provided for @onboardIntentOrgTitle.
  ///
  /// In en, this message translates to:
  /// **'I run an organisation'**
  String get onboardIntentOrgTitle;

  /// No description provided for @onboardIntentOrgBody.
  ///
  /// In en, this message translates to:
  /// **'Register an NGO, school or company to publish drives and certify hours.'**
  String get onboardIntentOrgBody;

  /// No description provided for @onboardIntentInviteHint.
  ///
  /// In en, this message translates to:
  /// **'Already part of an organisation? Ask its admin to invite you by email and it will appear here automatically.'**
  String get onboardIntentInviteHint;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Find a drive'**
  String get discoverTitle;

  /// No description provided for @discoverLead.
  ///
  /// In en, this message translates to:
  /// **'Turn up, scan the QR, and your hours get signed off by the organisation itself.'**
  String get discoverLead;

  /// No description provided for @discoverSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search drives, venues, cities, organisations'**
  String get discoverSearchHint;

  /// No description provided for @discoverFilterCause.
  ///
  /// In en, this message translates to:
  /// **'Cause'**
  String get discoverFilterCause;

  /// No description provided for @discoverFilterCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get discoverFilterCity;

  /// No description provided for @discoverFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get discoverFilterAll;

  /// No description provided for @discoverSortSoonest.
  ///
  /// In en, this message translates to:
  /// **'Soonest'**
  String get discoverSortSoonest;

  /// No description provided for @discoverSortHours.
  ///
  /// In en, this message translates to:
  /// **'Most hours'**
  String get discoverSortHours;

  /// No description provided for @discoverUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get discoverUpcoming;

  /// No description provided for @discoverResults.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No drives} =1{1 drive} other{{count} drives}}'**
  String discoverResults(int count);

  /// No description provided for @discoverEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No drives just yet'**
  String get discoverEmptyTitle;

  /// No description provided for @discoverEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'When an organisation publishes a drive it shows up here. Pull down to refresh.'**
  String get discoverEmptyBody;

  /// No description provided for @discoverNoMatchTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches'**
  String get discoverNoMatchTitle;

  /// No description provided for @discoverNoMatchBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different word or clear the filters.'**
  String get discoverNoMatchBody;

  /// No description provided for @discoverSpotsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Full} =1{1 spot left} other{{count} spots left}}'**
  String discoverSpotsLeft(int count);

  /// No description provided for @discoverRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get discoverRegistered;

  /// No description provided for @discoverVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get discoverVerified;

  /// No description provided for @discoverLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get discoverLoadMore;

  /// No description provided for @discoverEndOfList.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get discoverEndOfList;

  /// No description provided for @driveTitle.
  ///
  /// In en, this message translates to:
  /// **'Drive'**
  String get driveTitle;

  /// No description provided for @driveAbout.
  ///
  /// In en, this message translates to:
  /// **'About this drive'**
  String get driveAbout;

  /// No description provided for @driveWhen.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get driveWhen;

  /// No description provided for @driveWhere.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get driveWhere;

  /// No description provided for @driveHoursCredited.
  ///
  /// In en, this message translates to:
  /// **'Hours credited, once certified'**
  String get driveHoursCredited;

  /// No description provided for @driveSpots.
  ///
  /// In en, this message translates to:
  /// **'Spots'**
  String get driveSpots;

  /// No description provided for @driveOrganiser.
  ///
  /// In en, this message translates to:
  /// **'Organised by'**
  String get driveOrganiser;

  /// No description provided for @driveRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get driveRegister;

  /// No description provided for @driveRegistered.
  ///
  /// In en, this message translates to:
  /// **'You\'re registered'**
  String get driveRegistered;

  /// No description provided for @driveCancelRegistration.
  ///
  /// In en, this message translates to:
  /// **'Cancel registration'**
  String get driveCancelRegistration;

  /// No description provided for @driveCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel your registration?'**
  String get driveCancelConfirmTitle;

  /// No description provided for @driveCancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your spot goes back to the pool. You can register again if spots remain.'**
  String get driveCancelConfirmBody;

  /// No description provided for @driveRegisteredSnack.
  ///
  /// In en, this message translates to:
  /// **'Registered. See you there.'**
  String get driveRegisteredSnack;

  /// No description provided for @driveCancelledSnack.
  ///
  /// In en, this message translates to:
  /// **'Registration cancelled.'**
  String get driveCancelledSnack;

  /// No description provided for @driveDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get driveDirections;

  /// No description provided for @driveShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get driveShare;

  /// No description provided for @driveShareText.
  ///
  /// In en, this message translates to:
  /// **'{title} — {org}, {when}. Join via SWAG of India: {link}'**
  String driveShareText(String title, String org, String when, String link);

  /// No description provided for @driveReport.
  ///
  /// In en, this message translates to:
  /// **'Report this listing'**
  String get driveReport;

  /// No description provided for @driveReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report this drive'**
  String get driveReportTitle;

  /// No description provided for @driveReportReason1.
  ///
  /// In en, this message translates to:
  /// **'Misleading or fake'**
  String get driveReportReason1;

  /// No description provided for @driveReportReason2.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate content'**
  String get driveReportReason2;

  /// No description provided for @driveReportReason3.
  ///
  /// In en, this message translates to:
  /// **'Unsafe activity'**
  String get driveReportReason3;

  /// No description provided for @driveReportThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you. We review reports within 48 hours.'**
  String get driveReportThanks;

  /// No description provided for @driveCheckedInPending.
  ///
  /// In en, this message translates to:
  /// **'You checked in. Awaiting sign-off by {org}.'**
  String driveCheckedInPending(String org);

  /// No description provided for @driveCheckedInCertified.
  ///
  /// In en, this message translates to:
  /// **'Your hours here are certified.'**
  String get driveCheckedInCertified;

  /// No description provided for @driveCancelledBanner.
  ///
  /// In en, this message translates to:
  /// **'This drive was cancelled.'**
  String get driveCancelledBanner;

  /// No description provided for @driveEndedBanner.
  ///
  /// In en, this message translates to:
  /// **'This drive has ended.'**
  String get driveEndedBanner;

  /// No description provided for @driveFullBanner.
  ///
  /// In en, this message translates to:
  /// **'This drive is full.'**
  String get driveFullBanner;

  /// No description provided for @driveManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get driveManage;

  /// No description provided for @driveCoordinatorMode.
  ///
  /// In en, this message translates to:
  /// **'Coordinator Mode'**
  String get driveCoordinatorMode;

  /// No description provided for @driveNothingCertifiedAuto.
  ///
  /// In en, this message translates to:
  /// **'Nothing is certified automatically. Hours only count once the organisation signs them off.'**
  String get driveNothingCertifiedAuto;

  /// No description provided for @orgTitle.
  ///
  /// In en, this message translates to:
  /// **'Organisation'**
  String get orgTitle;

  /// No description provided for @orgVerifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Verified organisation'**
  String get orgVerifiedBadge;

  /// No description provided for @orgUnverified.
  ///
  /// In en, this message translates to:
  /// **'Not yet verified'**
  String get orgUnverified;

  /// No description provided for @orgDrivesRun.
  ///
  /// In en, this message translates to:
  /// **'Drives run'**
  String get orgDrivesRun;

  /// No description provided for @orgHoursCertified.
  ///
  /// In en, this message translates to:
  /// **'Hours certified'**
  String get orgHoursCertified;

  /// No description provided for @orgUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming drives'**
  String get orgUpcoming;

  /// No description provided for @orgNoUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming drives.'**
  String get orgNoUpcoming;

  /// No description provided for @orgTypeNgo.
  ///
  /// In en, this message translates to:
  /// **'NGO'**
  String get orgTypeNgo;

  /// No description provided for @orgTypeSchool.
  ///
  /// In en, this message translates to:
  /// **'School / College'**
  String get orgTypeSchool;

  /// No description provided for @orgTypeCorporate.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get orgTypeCorporate;

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get checkInTitle;

  /// No description provided for @checkInLead.
  ///
  /// In en, this message translates to:
  /// **'Point at the coordinator\'s QR code'**
  String get checkInLead;

  /// No description provided for @checkInPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera access needed'**
  String get checkInPermissionTitle;

  /// No description provided for @checkInPermissionBody.
  ///
  /// In en, this message translates to:
  /// **'SOI uses the camera only to scan the coordinator\'s QR code so your volunteering hours can be recorded. Nothing is stored.'**
  String get checkInPermissionBody;

  /// No description provided for @checkInAllowCamera.
  ///
  /// In en, this message translates to:
  /// **'Allow camera'**
  String get checkInAllowCamera;

  /// No description provided for @checkInOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get checkInOpenSettings;

  /// No description provided for @checkInEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter code instead'**
  String get checkInEnterCode;

  /// No description provided for @checkInManualTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get checkInManualTitle;

  /// No description provided for @checkInManualLead.
  ///
  /// In en, this message translates to:
  /// **'Ask the coordinator to read out the code under their QR, or paste a pledge code.'**
  String get checkInManualLead;

  /// No description provided for @checkInManualHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the full code'**
  String get checkInManualHint;

  /// No description provided for @checkInTorch.
  ///
  /// In en, this message translates to:
  /// **'Torch'**
  String get checkInTorch;

  /// No description provided for @checkInSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get checkInSuccessTitle;

  /// No description provided for @checkInSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'{hours} at {drive} recorded. Awaiting sign-off by {org}.'**
  String checkInSuccessBody(String hours, String drive, String org);

  /// No description provided for @checkInAlreadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Already checked in'**
  String get checkInAlreadyTitle;

  /// No description provided for @checkInAlreadyBody.
  ///
  /// In en, this message translates to:
  /// **'You\'re on the roster for {drive}.'**
  String checkInAlreadyBody(String drive);

  /// No description provided for @checkInViewPassport.
  ///
  /// In en, this message translates to:
  /// **'View my Passport'**
  String get checkInViewPassport;

  /// No description provided for @checkInScanAnother.
  ///
  /// In en, this message translates to:
  /// **'Scan another'**
  String get checkInScanAnother;

  /// No description provided for @checkInSignInFirst.
  ///
  /// In en, this message translates to:
  /// **'Sign in to check in. It takes a minute.'**
  String get checkInSignInFirst;

  /// No description provided for @checkInUnknownQr.
  ///
  /// In en, this message translates to:
  /// **'That\'s not an SOI code.'**
  String get checkInUnknownQr;

  /// No description provided for @passportTitle.
  ///
  /// In en, this message translates to:
  /// **'Impact Passport'**
  String get passportTitle;

  /// No description provided for @passportCertifiedHours.
  ///
  /// In en, this message translates to:
  /// **'Certified hours'**
  String get passportCertifiedHours;

  /// No description provided for @passportPending.
  ///
  /// In en, this message translates to:
  /// **'Awaiting sign-off'**
  String get passportPending;

  /// No description provided for @passportDrives.
  ///
  /// In en, this message translates to:
  /// **'Drives'**
  String get passportDrives;

  /// No description provided for @passportPledges.
  ///
  /// In en, this message translates to:
  /// **'Pledges'**
  String get passportPledges;

  /// No description provided for @passportLead.
  ///
  /// In en, this message translates to:
  /// **'Every certified hour was signed off by the organisation that ran the drive. That\'s what makes it worth putting on a form.'**
  String get passportLead;

  /// No description provided for @passportFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get passportFilterAll;

  /// No description provided for @passportFilterCertified.
  ///
  /// In en, this message translates to:
  /// **'Certified'**
  String get passportFilterCertified;

  /// No description provided for @passportFilterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get passportFilterPending;

  /// No description provided for @passportFilterRejected.
  ///
  /// In en, this message translates to:
  /// **'Not counted'**
  String get passportFilterRejected;

  /// No description provided for @passportFilterPledges.
  ///
  /// In en, this message translates to:
  /// **'Pledges'**
  String get passportFilterPledges;

  /// No description provided for @passportEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No hours yet'**
  String get passportEmptyTitle;

  /// No description provided for @passportEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Find a drive, turn up, scan the QR. Your hours land here once the organisation confirms them.'**
  String get passportEmptyBody;

  /// No description provided for @passportPendingRow.
  ///
  /// In en, this message translates to:
  /// **'Awaiting sign-off by {org}'**
  String passportPendingRow(String org);

  /// No description provided for @passportRejectedRow.
  ///
  /// In en, this message translates to:
  /// **'Not counted by {org}'**
  String passportRejectedRow(String org);

  /// No description provided for @passportCertifiedRow.
  ///
  /// In en, this message translates to:
  /// **'Certified by {org}'**
  String passportCertifiedRow(String org);

  /// No description provided for @passportViewCertificate.
  ///
  /// In en, this message translates to:
  /// **'View certificate'**
  String get passportViewCertificate;

  /// No description provided for @passportPledgeSigned.
  ///
  /// In en, this message translates to:
  /// **'Signed {when} · #{no}'**
  String passportPledgeSigned(String when, int no);

  /// No description provided for @passportPledgesNote.
  ///
  /// In en, this message translates to:
  /// **'Pledges are commitments, not volunteering hours. They\'re listed separately on purpose.'**
  String get passportPledgesNote;

  /// No description provided for @passportUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Your upcoming drives'**
  String get passportUpcoming;

  /// No description provided for @passportLinkSchool.
  ///
  /// In en, this message translates to:
  /// **'Have a claim code from your school?'**
  String get passportLinkSchool;

  /// No description provided for @certificateTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificateTitle;

  /// No description provided for @certificateKicker.
  ///
  /// In en, this message translates to:
  /// **'Certificate of volunteering'**
  String get certificateKicker;

  /// No description provided for @certificateKickerPledge.
  ///
  /// In en, this message translates to:
  /// **'Certificate of pledge'**
  String get certificateKickerPledge;

  /// No description provided for @certificateCertify.
  ///
  /// In en, this message translates to:
  /// **'This is to certify that'**
  String get certificateCertify;

  /// No description provided for @certificateCompleted.
  ///
  /// In en, this message translates to:
  /// **'has completed and had certified'**
  String get certificateCompleted;

  /// No description provided for @certificateHoursUnit.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get certificateHoursUnit;

  /// No description provided for @certificateOfVolunteering.
  ///
  /// In en, this message translates to:
  /// **'of volunteering at'**
  String get certificateOfVolunteering;

  /// No description provided for @certificateTakenPledge.
  ///
  /// In en, this message translates to:
  /// **'has taken the pledge'**
  String get certificateTakenPledge;

  /// No description provided for @certificateIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get certificateIssued;

  /// No description provided for @certificateNumber.
  ///
  /// In en, this message translates to:
  /// **'Certificate no.'**
  String get certificateNumber;

  /// No description provided for @certificateScanToVerify.
  ///
  /// In en, this message translates to:
  /// **'Scan to verify'**
  String get certificateScanToVerify;

  /// No description provided for @certificateWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn — {reason}'**
  String certificateWithdrawn(String reason);

  /// No description provided for @certificateAnyoneCanCheck.
  ///
  /// In en, this message translates to:
  /// **'Anyone can check this is real'**
  String get certificateAnyoneCanCheck;

  /// No description provided for @certificateAnyoneCanCheckBody.
  ///
  /// In en, this message translates to:
  /// **'Open {host} and enter the number, or scan the QR. No account needed. It shows who it was issued to, by whom, and for what — nothing else.'**
  String certificateAnyoneCanCheckBody(String host);

  /// No description provided for @certificateShareImage.
  ///
  /// In en, this message translates to:
  /// **'Share as image'**
  String get certificateShareImage;

  /// No description provided for @certificateShareLink.
  ///
  /// In en, this message translates to:
  /// **'Share verification link'**
  String get certificateShareLink;

  /// No description provided for @certificateCopyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy number'**
  String get certificateCopyCode;

  /// No description provided for @certificateNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate not found'**
  String get certificateNotFoundTitle;

  /// No description provided for @certificateNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'Check the number — it should look like SOI-AB12-CD34.'**
  String get certificateNotFoundBody;

  /// No description provided for @certificateShareText.
  ///
  /// In en, this message translates to:
  /// **'Verified volunteering certificate for {name}: {link}'**
  String certificateShareText(String name, String link);

  /// No description provided for @pledgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pledge'**
  String get pledgeTitle;

  /// No description provided for @pledgeBy.
  ///
  /// In en, this message translates to:
  /// **'by {org}'**
  String pledgeBy(String org);

  /// No description provided for @pledgeSignatures.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No signatures yet} =1{1 signature} other{{count} signatures}}'**
  String pledgeSignatures(int count);

  /// No description provided for @pledgeSign.
  ///
  /// In en, this message translates to:
  /// **'Take this pledge'**
  String get pledgeSign;

  /// No description provided for @pledgeSigned.
  ///
  /// In en, this message translates to:
  /// **'You took this pledge'**
  String get pledgeSigned;

  /// No description provided for @pledgeSignedNo.
  ///
  /// In en, this message translates to:
  /// **'Signature #{no} · {when}'**
  String pledgeSignedNo(int no, String when);

  /// No description provided for @pledgeClosed.
  ///
  /// In en, this message translates to:
  /// **'This pledge is closed to new signatures.'**
  String get pledgeClosed;

  /// No description provided for @pledgeWhatThisIs.
  ///
  /// In en, this message translates to:
  /// **'What this is — and isn\'t'**
  String get pledgeWhatThisIs;

  /// No description provided for @pledgeWhatThisIsBody.
  ///
  /// In en, this message translates to:
  /// **'A pledge is a public commitment. It takes a moment and it matters. It is not volunteering: hours only come from turning up to a drive and being signed off by the organisation that ran it.'**
  String get pledgeWhatThisIsBody;

  /// No description provided for @pledgeShareText.
  ///
  /// In en, this message translates to:
  /// **'I took the pledge \"{title}\" with {org}. Take it too: {link}'**
  String pledgeShareText(String title, String org, String link);

  /// No description provided for @pledgeShowQr.
  ///
  /// In en, this message translates to:
  /// **'Show QR'**
  String get pledgeShowQr;

  /// No description provided for @pledgeSignedSnack.
  ///
  /// In en, this message translates to:
  /// **'Pledge taken. Your certificate is ready.'**
  String get pledgeSignedSnack;

  /// No description provided for @pledgeSignInToSign.
  ///
  /// In en, this message translates to:
  /// **'Sign in to take this pledge.'**
  String get pledgeSignInToSign;

  /// No description provided for @manageTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manageTitle;

  /// No description provided for @manageLead.
  ///
  /// In en, this message translates to:
  /// **'Publish drives, run check-in, certify hours.'**
  String get manageLead;

  /// No description provided for @manageToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get manageToday;

  /// No description provided for @manageUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get manageUpcoming;

  /// No description provided for @managePast.
  ///
  /// In en, this message translates to:
  /// **'Past drives'**
  String get managePast;

  /// No description provided for @managePublish.
  ///
  /// In en, this message translates to:
  /// **'Publish a drive'**
  String get managePublish;

  /// No description provided for @manageRoster.
  ///
  /// In en, this message translates to:
  /// **'Roster'**
  String get manageRoster;

  /// No description provided for @managePledges.
  ///
  /// In en, this message translates to:
  /// **'Pledges'**
  String get managePledges;

  /// No description provided for @manageOrganisation.
  ///
  /// In en, this message translates to:
  /// **'Organisation'**
  String get manageOrganisation;

  /// No description provided for @manageNoDrives.
  ///
  /// In en, this message translates to:
  /// **'No drives yet'**
  String get manageNoDrives;

  /// No description provided for @manageNoDrivesBody.
  ///
  /// In en, this message translates to:
  /// **'Publish your first drive. Volunteers see it the moment it\'s live.'**
  String get manageNoDrivesBody;

  /// No description provided for @manageDriveStats.
  ///
  /// In en, this message translates to:
  /// **'{registered} registered · {checkedIn} checked in · {certified} certified'**
  String manageDriveStats(int registered, int checkedIn, int certified);

  /// No description provided for @managePendingBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} to certify'**
  String managePendingBadge(int count);

  /// No description provided for @manageSwitchOrg.
  ///
  /// In en, this message translates to:
  /// **'Organisation'**
  String get manageSwitchOrg;

  /// No description provided for @manageRegisterOrg.
  ///
  /// In en, this message translates to:
  /// **'Register an organisation'**
  String get manageRegisterOrg;

  /// No description provided for @manageRegisterOrgBody.
  ///
  /// In en, this message translates to:
  /// **'NGOs, schools and companies publish drives and certify hours.'**
  String get manageRegisterOrgBody;

  /// No description provided for @driveFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Publish a drive'**
  String get driveFormNewTitle;

  /// No description provided for @driveFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit drive'**
  String get driveFormEditTitle;

  /// No description provided for @driveFormOrg.
  ///
  /// In en, this message translates to:
  /// **'Organisation'**
  String get driveFormOrg;

  /// No description provided for @driveFormTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get driveFormTitleLabel;

  /// No description provided for @driveFormTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Godavari ghat clean-up'**
  String get driveFormTitleHint;

  /// No description provided for @driveFormCause.
  ///
  /// In en, this message translates to:
  /// **'Cause'**
  String get driveFormCause;

  /// No description provided for @driveFormDescription.
  ///
  /// In en, this message translates to:
  /// **'What volunteers will do'**
  String get driveFormDescription;

  /// No description provided for @driveFormDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'What to bring, where to meet, who to ask for.'**
  String get driveFormDescriptionHint;

  /// No description provided for @driveFormDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get driveFormDate;

  /// No description provided for @driveFormStart.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get driveFormStart;

  /// No description provided for @driveFormEnd.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get driveFormEnd;

  /// No description provided for @driveFormVenue.
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get driveFormVenue;

  /// No description provided for @driveFormCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get driveFormCity;

  /// No description provided for @driveFormCapacity.
  ///
  /// In en, this message translates to:
  /// **'Spots'**
  String get driveFormCapacity;

  /// No description provided for @driveFormHours.
  ///
  /// In en, this message translates to:
  /// **'Hours credited'**
  String get driveFormHours;

  /// No description provided for @driveFormHoursHelp.
  ///
  /// In en, this message translates to:
  /// **'Credited to each volunteer once you certify them. Nothing is certified automatically.'**
  String get driveFormHoursHelp;

  /// No description provided for @driveFormPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get driveFormPublish;

  /// No description provided for @driveFormSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get driveFormSave;

  /// No description provided for @driveFormPublished.
  ///
  /// In en, this message translates to:
  /// **'Drive published.'**
  String get driveFormPublished;

  /// No description provided for @driveFormSaved.
  ///
  /// In en, this message translates to:
  /// **'Drive updated.'**
  String get driveFormSaved;

  /// No description provided for @driveFormCancelDrive.
  ///
  /// In en, this message translates to:
  /// **'Cancel this drive'**
  String get driveFormCancelDrive;

  /// No description provided for @driveFormCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this drive?'**
  String get driveFormCancelConfirmTitle;

  /// No description provided for @driveFormCancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'It disappears from Discover and no one can register or check in. Hours already certified are unaffected.'**
  String get driveFormCancelConfirmBody;

  /// No description provided for @driveFormCancelled.
  ///
  /// In en, this message translates to:
  /// **'Drive cancelled.'**
  String get driveFormCancelled;

  /// No description provided for @driveFormUnsavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get driveFormUnsavedTitle;

  /// No description provided for @driveFormUnsavedBody.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved edits.'**
  String get driveFormUnsavedBody;

  /// No description provided for @driveFormDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get driveFormDiscard;

  /// No description provided for @causeEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get causeEnvironment;

  /// No description provided for @causeEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get causeEducation;

  /// No description provided for @causeHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get causeHealth;

  /// No description provided for @causeCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get causeCommunity;

  /// No description provided for @causeAnimalWelfare.
  ///
  /// In en, this message translates to:
  /// **'Animal welfare'**
  String get causeAnimalWelfare;

  /// No description provided for @causeDisasterRelief.
  ///
  /// In en, this message translates to:
  /// **'Disaster relief'**
  String get causeDisasterRelief;

  /// No description provided for @causeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get causeOther;

  /// No description provided for @coordTitle.
  ///
  /// In en, this message translates to:
  /// **'Coordinator Mode'**
  String get coordTitle;

  /// No description provided for @coordShowThis.
  ///
  /// In en, this message translates to:
  /// **'Show this to volunteers'**
  String get coordShowThis;

  /// No description provided for @coordRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate code'**
  String get coordRotate;

  /// No description provided for @coordRotateHint.
  ///
  /// In en, this message translates to:
  /// **'Rotate if the QR was photographed. Old scans stop working instantly.'**
  String get coordRotateHint;

  /// No description provided for @coordRotated.
  ///
  /// In en, this message translates to:
  /// **'Code rotated.'**
  String get coordRotated;

  /// No description provided for @coordCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get coordCode;

  /// No description provided for @coordRosterTitle.
  ///
  /// In en, this message translates to:
  /// **'Roster'**
  String get coordRosterTitle;

  /// No description provided for @coordRosterSearch.
  ///
  /// In en, this message translates to:
  /// **'Search names'**
  String get coordRosterSearch;

  /// No description provided for @coordRosterEmpty.
  ///
  /// In en, this message translates to:
  /// **'No check-ins yet'**
  String get coordRosterEmpty;

  /// No description provided for @coordRosterEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'As volunteers scan, they appear here live.'**
  String get coordRosterEmptyBody;

  /// No description provided for @coordRosterError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the roster. Volunteers may still have checked in — do not tell anyone they were absent.'**
  String get coordRosterError;

  /// No description provided for @coordCertifyAll.
  ///
  /// In en, this message translates to:
  /// **'Certify all pending ({count})'**
  String coordCertifyAll(int count);

  /// No description provided for @coordCertify.
  ///
  /// In en, this message translates to:
  /// **'Certify'**
  String get coordCertify;

  /// No description provided for @coordReject.
  ///
  /// In en, this message translates to:
  /// **'Don\'t count'**
  String get coordReject;

  /// No description provided for @coordCertifyConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Certify {count, plural, =1{1 volunteer} other{{count} volunteers}}?'**
  String coordCertifyConfirmTitle(int count);

  /// No description provided for @coordCertifyConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Each gets a certificate anyone can verify. This cannot be undone.'**
  String get coordCertifyConfirmBody;

  /// No description provided for @coordCertified.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 certificate issued} other{{count} certificates issued}}'**
  String coordCertified(int count);

  /// No description provided for @coordRejectConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t count this attendance?'**
  String get coordRejectConfirmTitle;

  /// No description provided for @coordRejectConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'{name} will see it as not counted. Use this for someone who scanned but did not stay.'**
  String coordRejectConfirmBody(String name);

  /// No description provided for @coordRejected.
  ///
  /// In en, this message translates to:
  /// **'Marked as not counted.'**
  String get coordRejected;

  /// No description provided for @coordMarkStudents.
  ///
  /// In en, this message translates to:
  /// **'Mark students present'**
  String get coordMarkStudents;

  /// No description provided for @coordStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get coordStatusPending;

  /// No description provided for @coordStatusCertified.
  ///
  /// In en, this message translates to:
  /// **'Certified'**
  String get coordStatusCertified;

  /// No description provided for @coordStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Not counted'**
  String get coordStatusRejected;

  /// No description provided for @coordMethodTeacher.
  ///
  /// In en, this message translates to:
  /// **'Marked by teacher'**
  String get coordMethodTeacher;

  /// No description provided for @coordStudentTag.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get coordStudentTag;

  /// No description provided for @coordStats.
  ///
  /// In en, this message translates to:
  /// **'{total} checked in · {pending} pending · {certified} certified'**
  String coordStats(int total, int pending, int certified);

  /// No description provided for @rosterTitle.
  ///
  /// In en, this message translates to:
  /// **'Roster'**
  String get rosterTitle;

  /// No description provided for @rosterLead.
  ///
  /// In en, this message translates to:
  /// **'They don\'t need an account, an email or a phone. You hold the record.'**
  String get rosterLead;

  /// No description provided for @rosterSearch.
  ///
  /// In en, this message translates to:
  /// **'Search names or roll numbers'**
  String get rosterSearch;

  /// No description provided for @rosterAdd.
  ///
  /// In en, this message translates to:
  /// **'Add person'**
  String get rosterAdd;

  /// No description provided for @rosterBulk.
  ///
  /// In en, this message translates to:
  /// **'Paste a list'**
  String get rosterBulk;

  /// No description provided for @rosterEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No one enrolled yet'**
  String get rosterEmptyTitle;

  /// No description provided for @rosterEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add students or volunteers. Each gets a claim code so their hours follow them if they ever make an account.'**
  String get rosterEmptyBody;

  /// No description provided for @rosterKindStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get rosterKindStudent;

  /// No description provided for @rosterKindVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get rosterKindVolunteer;

  /// No description provided for @rosterName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get rosterName;

  /// No description provided for @rosterClass.
  ///
  /// In en, this message translates to:
  /// **'Class / section'**
  String get rosterClass;

  /// No description provided for @rosterRoll.
  ///
  /// In en, this message translates to:
  /// **'Roll no.'**
  String get rosterRoll;

  /// No description provided for @rosterEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get rosterEmail;

  /// No description provided for @rosterPhone.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get rosterPhone;

  /// No description provided for @rosterPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'For under-18s we deliberately ask only for name, class and roll number — no date of birth, photo or address.'**
  String get rosterPrivacyNote;

  /// No description provided for @rosterEnrolled.
  ///
  /// In en, this message translates to:
  /// **'{name} enrolled. Claim code {code}.'**
  String rosterEnrolled(String name, String code);

  /// No description provided for @rosterClaimCode.
  ///
  /// In en, this message translates to:
  /// **'Claim code'**
  String get rosterClaimCode;

  /// No description provided for @rosterClaimHint.
  ///
  /// In en, this message translates to:
  /// **'Give this code to the person. When they create an account they enter it under Profile to attach their hours.'**
  String get rosterClaimHint;

  /// No description provided for @rosterClaimed.
  ///
  /// In en, this message translates to:
  /// **'Linked to an account'**
  String get rosterClaimed;

  /// No description provided for @rosterHours.
  ///
  /// In en, this message translates to:
  /// **'{certified} certified · {pending} pending'**
  String rosterHours(String certified, String pending);

  /// No description provided for @rosterRemoveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String rosterRemoveConfirmTitle(String name);

  /// No description provided for @rosterRemoveConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Only possible while they have no attendance records.'**
  String get rosterRemoveConfirmBody;

  /// No description provided for @rosterRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed.'**
  String get rosterRemoved;

  /// No description provided for @rosterBulkTitle.
  ///
  /// In en, this message translates to:
  /// **'Paste a list'**
  String get rosterBulkTitle;

  /// No description provided for @rosterBulkLead.
  ///
  /// In en, this message translates to:
  /// **'One person per line: name, class, roll. Commas or tabs.'**
  String get rosterBulkLead;

  /// No description provided for @rosterBulkPreview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person} other{{count} people}} ready to enrol'**
  String rosterBulkPreview(int count);

  /// No description provided for @rosterBulkEnrol.
  ///
  /// In en, this message translates to:
  /// **'Enrol all'**
  String get rosterBulkEnrol;

  /// No description provided for @rosterBulkDone.
  ///
  /// In en, this message translates to:
  /// **'{ok} enrolled, {failed} skipped'**
  String rosterBulkDone(int ok, int failed);

  /// No description provided for @rosterGroupUngrouped.
  ///
  /// In en, this message translates to:
  /// **'No class'**
  String get rosterGroupUngrouped;

  /// No description provided for @markTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark attendance'**
  String get markTitle;

  /// No description provided for @markLead.
  ///
  /// In en, this message translates to:
  /// **'Select who was at this drive. The organisation that ran it still certifies.'**
  String get markLead;

  /// No description provided for @markSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get markSelectAll;

  /// No description provided for @markSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String markSelected(int count);

  /// No description provided for @markAlready.
  ///
  /// In en, this message translates to:
  /// **'Already marked'**
  String get markAlready;

  /// No description provided for @markConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark {count, plural, =1{1 person} other{{count} people}} present?'**
  String markConfirmTitle(int count);

  /// No description provided for @markConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This records pending hours at {drive}. It can\'t be undone from here.'**
  String markConfirmBody(String drive);

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'{count} marked present.'**
  String markDone(int count);

  /// No description provided for @markChooseDrive.
  ///
  /// In en, this message translates to:
  /// **'Choose the drive'**
  String get markChooseDrive;

  /// No description provided for @pledgesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pledges'**
  String get pledgesTitle;

  /// No description provided for @pledgesNew.
  ///
  /// In en, this message translates to:
  /// **'New pledge'**
  String get pledgesNew;

  /// No description provided for @pledgesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No pledges yet'**
  String get pledgesEmptyTitle;

  /// No description provided for @pledgesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Publish a pledge and share its code or QR. Signatures show up here.'**
  String get pledgesEmptyBody;

  /// No description provided for @pledgesFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get pledgesFilterActive;

  /// No description provided for @pledgesFilterClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get pledgesFilterClosed;

  /// No description provided for @pledgesClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get pledgesClose;

  /// No description provided for @pledgesReopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get pledgesReopen;

  /// No description provided for @pledgesSigners.
  ///
  /// In en, this message translates to:
  /// **'Signers'**
  String get pledgesSigners;

  /// No description provided for @pledgesDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this pledge?'**
  String get pledgesDeleteTitle;

  /// No description provided for @pledgesDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'No one has signed it, so it can be removed completely.'**
  String get pledgesDeleteBody;

  /// No description provided for @pledgesDeleteBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'This pledge has signatures'**
  String get pledgesDeleteBlockedTitle;

  /// No description provided for @pledgesDeleteBlockedBody.
  ///
  /// In en, this message translates to:
  /// **'Everyone who signed it agreed to these exact words and holds a certificate for it, so it can\'t be deleted. You can close it to stop new signatures.'**
  String get pledgesDeleteBlockedBody;

  /// No description provided for @pledgesDeleted.
  ///
  /// In en, this message translates to:
  /// **'Pledge deleted.'**
  String get pledgesDeleted;

  /// No description provided for @pledgesClosed.
  ///
  /// In en, this message translates to:
  /// **'Pledge closed.'**
  String get pledgesClosed;

  /// No description provided for @pledgesReopened.
  ///
  /// In en, this message translates to:
  /// **'Pledge reopened.'**
  String get pledgesReopened;

  /// No description provided for @pledgeFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a pledge'**
  String get pledgeFormNewTitle;

  /// No description provided for @pledgeFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit pledge'**
  String get pledgeFormEditTitle;

  /// No description provided for @pledgeFormTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get pledgeFormTitleLabel;

  /// No description provided for @pledgeFormCampaign.
  ///
  /// In en, this message translates to:
  /// **'Campaign'**
  String get pledgeFormCampaign;

  /// No description provided for @pledgeFormCampaignHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Plastic-free 2026'**
  String get pledgeFormCampaignHint;

  /// No description provided for @pledgeFormBody.
  ///
  /// In en, this message translates to:
  /// **'The pledge'**
  String get pledgeFormBody;

  /// No description provided for @pledgeFormBodyHint.
  ///
  /// In en, this message translates to:
  /// **'Write it in the first person: \"I pledge to…\"'**
  String get pledgeFormBodyHint;

  /// No description provided for @pledgeFormLocked.
  ///
  /// In en, this message translates to:
  /// **'The wording is locked: everyone who signed it agreed to these exact words. The title can still change.'**
  String get pledgeFormLocked;

  /// No description provided for @pledgeFormPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish pledge'**
  String get pledgeFormPublish;

  /// No description provided for @pledgeFormPublished.
  ///
  /// In en, this message translates to:
  /// **'Pledge published.'**
  String get pledgeFormPublished;

  /// No description provided for @pledgeFormSaved.
  ///
  /// In en, this message translates to:
  /// **'Pledge updated.'**
  String get pledgeFormSaved;

  /// No description provided for @pledgeFormNotHours.
  ///
  /// In en, this message translates to:
  /// **'A pledge is not volunteering hours. Signing takes seconds; certified hours mean someone turned up and you signed off.'**
  String get pledgeFormNotHours;

  /// No description provided for @orgFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Register an organisation'**
  String get orgFormNewTitle;

  /// No description provided for @orgFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit organisation'**
  String get orgFormEditTitle;

  /// No description provided for @orgFormType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get orgFormType;

  /// No description provided for @orgFormName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get orgFormName;

  /// No description provided for @orgFormCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get orgFormCity;

  /// No description provided for @orgFormAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get orgFormAbout;

  /// No description provided for @orgFormAboutHint.
  ///
  /// In en, this message translates to:
  /// **'What you do, in a sentence or two.'**
  String get orgFormAboutHint;

  /// No description provided for @orgFormRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get orgFormRegister;

  /// No description provided for @orgFormVerifyNote.
  ///
  /// In en, this message translates to:
  /// **'Verification is granted by the SOI team after review. Unverified organisations can still publish drives; the badge tells volunteers you\'ve been checked.'**
  String get orgFormVerifyNote;

  /// No description provided for @orgFormRegistered.
  ///
  /// In en, this message translates to:
  /// **'Organisation registered.'**
  String get orgFormRegistered;

  /// No description provided for @orgFormSaved.
  ///
  /// In en, this message translates to:
  /// **'Organisation updated.'**
  String get orgFormSaved;

  /// No description provided for @orgSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Organisation'**
  String get orgSettingsTitle;

  /// No description provided for @orgSettingsMembers.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get orgSettingsMembers;

  /// No description provided for @orgSettingsInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite by email'**
  String get orgSettingsInvite;

  /// No description provided for @orgSettingsInviteLead.
  ///
  /// In en, this message translates to:
  /// **'They get access the moment they sign in with this email.'**
  String get orgSettingsInviteLead;

  /// No description provided for @orgSettingsInviteRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get orgSettingsInviteRole;

  /// No description provided for @orgSettingsInvited.
  ///
  /// In en, this message translates to:
  /// **'Invite sent.'**
  String get orgSettingsInvited;

  /// No description provided for @orgSettingsPending.
  ///
  /// In en, this message translates to:
  /// **'Pending invites'**
  String get orgSettingsPending;

  /// No description provided for @orgSettingsRoleOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get orgSettingsRoleOwner;

  /// No description provided for @orgSettingsRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get orgSettingsRoleAdmin;

  /// No description provided for @orgSettingsRoleCoordinator.
  ///
  /// In en, this message translates to:
  /// **'Coordinator'**
  String get orgSettingsRoleCoordinator;

  /// No description provided for @orgSettingsRoleMember.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get orgSettingsRoleMember;

  /// No description provided for @orgSettingsRoleAdminHelp.
  ///
  /// In en, this message translates to:
  /// **'Can manage the team and edit the organisation.'**
  String get orgSettingsRoleAdminHelp;

  /// No description provided for @orgSettingsRoleCoordinatorHelp.
  ///
  /// In en, this message translates to:
  /// **'Can publish drives, run check-in and certify.'**
  String get orgSettingsRoleCoordinatorHelp;

  /// No description provided for @orgSettingsRoleMemberHelp.
  ///
  /// In en, this message translates to:
  /// **'Can see the organisation\'s drives.'**
  String get orgSettingsRoleMemberHelp;

  /// No description provided for @orgSettingsRemoveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String orgSettingsRemoveConfirmTitle(String name);

  /// No description provided for @orgSettingsRemoveConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'They lose access immediately. Hours they certified are unaffected.'**
  String get orgSettingsRemoveConfirmBody;

  /// No description provided for @orgSettingsRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed.'**
  String get orgSettingsRemoved;

  /// No description provided for @orgSettingsLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave organisation'**
  String get orgSettingsLeave;

  /// No description provided for @orgSettingsLeaveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave {org}?'**
  String orgSettingsLeaveConfirmTitle(String org);

  /// No description provided for @orgSettingsLeaveConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll lose coordinator access. An admin can invite you back.'**
  String get orgSettingsLeaveConfirmBody;

  /// No description provided for @orgSettingsLeft.
  ///
  /// In en, this message translates to:
  /// **'You left {org}.'**
  String orgSettingsLeft(String org);

  /// No description provided for @orgSettingsCancelInvite.
  ///
  /// In en, this message translates to:
  /// **'Cancel invite'**
  String get orgSettingsCancelInvite;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileNameOnCertificates.
  ///
  /// In en, this message translates to:
  /// **'Name on certificates'**
  String get profileNameOnCertificates;

  /// No description provided for @profileEditName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get profileEditName;

  /// No description provided for @profileNameSaved.
  ///
  /// In en, this message translates to:
  /// **'Name saved.'**
  String get profileNameSaved;

  /// No description provided for @profileNameUpdatedCerts.
  ///
  /// In en, this message translates to:
  /// **'Name saved. {count, plural, =0{} =1{1 certificate updated.} other{{count} certificates updated.}}'**
  String profileNameUpdatedCerts(int count);

  /// No description provided for @profileOrganisations.
  ///
  /// In en, this message translates to:
  /// **'Organisations'**
  String get profileOrganisations;

  /// No description provided for @profileNoOrganisations.
  ///
  /// In en, this message translates to:
  /// **'You\'re not part of an organisation.'**
  String get profileNoOrganisations;

  /// No description provided for @profileRegisterOrg.
  ///
  /// In en, this message translates to:
  /// **'Register an organisation'**
  String get profileRegisterOrg;

  /// No description provided for @profileLinkSchool.
  ///
  /// In en, this message translates to:
  /// **'Link records from my school'**
  String get profileLinkSchool;

  /// No description provided for @profileAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileAppearance;

  /// No description provided for @profileAppearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'Follows your phone\'s theme.'**
  String get profileAppearanceSystem;

  /// No description provided for @profileLegal.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileLegal;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get profilePrivacy;

  /// No description provided for @profileChildSafety.
  ///
  /// In en, this message translates to:
  /// **'Child safety standards'**
  String get profileChildSafety;

  /// No description provided for @profileSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get profileSupport;

  /// No description provided for @profileVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String profileVersion(String version);

  /// No description provided for @profileSignOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get profileSignOutConfirmTitle;

  /// No description provided for @profileSignOutConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need your email code to sign back in.'**
  String get profileSignOutConfirmBody;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get profileDeleteConfirmTitle;

  /// No description provided for @profileDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your account and personal data are deleted straight away. Certificates already issued stay verifiable, without your account attached. This cannot be undone.'**
  String get profileDeleteConfirmBody;

  /// No description provided for @profileDeleteConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get profileDeleteConfirmAction;

  /// No description provided for @profileDeleted.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted.'**
  String get profileDeleted;

  /// No description provided for @profileSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed out.'**
  String get profileSignedOut;

  /// No description provided for @claimTitle.
  ///
  /// In en, this message translates to:
  /// **'Link your school records'**
  String get claimTitle;

  /// No description provided for @claimLead.
  ///
  /// In en, this message translates to:
  /// **'Your teacher gave you an 8-character claim code. Enter it once and the hours they recorded for you appear in your Passport.'**
  String get claimLead;

  /// No description provided for @claimLabel.
  ///
  /// In en, this message translates to:
  /// **'Claim code'**
  String get claimLabel;

  /// No description provided for @claimSubmit.
  ///
  /// In en, this message translates to:
  /// **'Link my records'**
  String get claimSubmit;

  /// No description provided for @claimSuccess.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Linked {name}\'s record.} =1{Linked 1 record for {name}.} other{Linked {count} records for {name}.}}'**
  String claimSuccess(int count, String name);

  /// No description provided for @errRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get errRequired;

  /// No description provided for @errBadCode.
  ///
  /// In en, this message translates to:
  /// **'That code doesn\'t look right.'**
  String get errBadCode;

  /// No description provided for @errOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Check your connection and try again.'**
  String get errOffline;

  /// No description provided for @errUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errUnknown;

  /// No description provided for @errServer.
  ///
  /// In en, this message translates to:
  /// **'The server had a problem. Please try again in a moment.'**
  String get errServer;

  /// No description provided for @errNotSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to do that.'**
  String get errNotSignedIn;

  /// No description provided for @errNotAuthorised.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to do that in this organisation.'**
  String get errNotAuthorised;

  /// No description provided for @errAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Please try again.'**
  String get errAuthFailed;

  /// No description provided for @errBadCredentials.
  ///
  /// In en, this message translates to:
  /// **'That code or password isn\'t right.'**
  String get errBadCredentials;

  /// No description provided for @errTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a few minutes and try again.'**
  String get errTooManyAttempts;

  /// No description provided for @errNameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Enter the full name.'**
  String get errNameTooShort;

  /// No description provided for @errNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'That name is too long (max 80).'**
  String get errNameTooLong;

  /// No description provided for @errNameLooksLikeEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a name, not an email address.'**
  String get errNameLooksLikeEmail;

  /// No description provided for @errAboutTooLong.
  ///
  /// In en, this message translates to:
  /// **'That\'s too long (max 1000).'**
  String get errAboutTooLong;

  /// No description provided for @errCityTooLong.
  ///
  /// In en, this message translates to:
  /// **'That city name is too long.'**
  String get errCityTooLong;

  /// No description provided for @errBadType.
  ///
  /// In en, this message translates to:
  /// **'Pick NGO, school or company.'**
  String get errBadType;

  /// No description provided for @errBadRole.
  ///
  /// In en, this message translates to:
  /// **'Pick a role.'**
  String get errBadRole;

  /// No description provided for @errBadEmail.
  ///
  /// In en, this message translates to:
  /// **'That email address isn\'t valid.'**
  String get errBadEmail;

  /// No description provided for @errOrgNotFound.
  ///
  /// In en, this message translates to:
  /// **'That organisation no longer exists.'**
  String get errOrgNotFound;

  /// No description provided for @errMemberNotFound.
  ///
  /// In en, this message translates to:
  /// **'That person isn\'t in this organisation.'**
  String get errMemberNotFound;

  /// No description provided for @errCannotRemoveOwner.
  ///
  /// In en, this message translates to:
  /// **'Owners can\'t be removed.'**
  String get errCannotRemoveOwner;

  /// No description provided for @errSoleOwner.
  ///
  /// In en, this message translates to:
  /// **'You\'re the only owner. Make someone else an admin first.'**
  String get errSoleOwner;

  /// No description provided for @errInviteNotFound.
  ///
  /// In en, this message translates to:
  /// **'That invite is no longer pending.'**
  String get errInviteNotFound;

  /// No description provided for @errTitleTooShort.
  ///
  /// In en, this message translates to:
  /// **'Give it a longer title (at least 5 characters).'**
  String get errTitleTooShort;

  /// No description provided for @errTitleTooLong.
  ///
  /// In en, this message translates to:
  /// **'That title is too long (max 120).'**
  String get errTitleTooLong;

  /// No description provided for @errDescriptionTooLong.
  ///
  /// In en, this message translates to:
  /// **'The description is too long (max 4000).'**
  String get errDescriptionTooLong;

  /// No description provided for @errCauseTooLong.
  ///
  /// In en, this message translates to:
  /// **'That cause is too long.'**
  String get errCauseTooLong;

  /// No description provided for @errVenueTooLong.
  ///
  /// In en, this message translates to:
  /// **'That venue is too long.'**
  String get errVenueTooLong;

  /// No description provided for @errEndBeforeStart.
  ///
  /// In en, this message translates to:
  /// **'The drive has to end after it starts.'**
  String get errEndBeforeStart;

  /// No description provided for @errStartsInPast.
  ///
  /// In en, this message translates to:
  /// **'The start time is in the past.'**
  String get errStartsInPast;

  /// No description provided for @errBadCapacity.
  ///
  /// In en, this message translates to:
  /// **'Spots must be between 1 and 5000.'**
  String get errBadCapacity;

  /// No description provided for @errBadHours.
  ///
  /// In en, this message translates to:
  /// **'Hours must be between 0.5 and 12.'**
  String get errBadHours;

  /// No description provided for @errDriveNotFound.
  ///
  /// In en, this message translates to:
  /// **'That drive isn\'t available.'**
  String get errDriveNotFound;

  /// No description provided for @errDriveNotOpen.
  ///
  /// In en, this message translates to:
  /// **'This drive isn\'t open.'**
  String get errDriveNotOpen;

  /// No description provided for @errDriveEnded.
  ///
  /// In en, this message translates to:
  /// **'This drive has already ended.'**
  String get errDriveEnded;

  /// No description provided for @errDriveFull.
  ///
  /// In en, this message translates to:
  /// **'This drive is full.'**
  String get errDriveFull;

  /// No description provided for @errNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'You aren\'t registered for this drive.'**
  String get errNotRegistered;

  /// No description provided for @errBadKind.
  ///
  /// In en, this message translates to:
  /// **'Pick student or volunteer.'**
  String get errBadKind;

  /// No description provided for @errClassTooLong.
  ///
  /// In en, this message translates to:
  /// **'Class is too long (max 20).'**
  String get errClassTooLong;

  /// No description provided for @errBadRoll.
  ///
  /// In en, this message translates to:
  /// **'Roll numbers can only contain letters, numbers, - and /.'**
  String get errBadRoll;

  /// No description provided for @errBadPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a 10-digit Indian mobile number.'**
  String get errBadPhone;

  /// No description provided for @errDuplicateEmail.
  ///
  /// In en, this message translates to:
  /// **'Someone with that email is already on this roster.'**
  String get errDuplicateEmail;

  /// No description provided for @errDuplicateRoll.
  ///
  /// In en, this message translates to:
  /// **'That roll number already exists in this class.'**
  String get errDuplicateRoll;

  /// No description provided for @errStudentNotFound.
  ///
  /// In en, this message translates to:
  /// **'That person is no longer on the roster.'**
  String get errStudentNotFound;

  /// No description provided for @errStudentHasRecords.
  ///
  /// In en, this message translates to:
  /// **'This person has attendance records, so they can\'t be removed.'**
  String get errStudentHasRecords;

  /// No description provided for @errStudentClaimed.
  ///
  /// In en, this message translates to:
  /// **'This person has linked an account, so they can\'t be removed.'**
  String get errStudentClaimed;

  /// No description provided for @errInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'That QR code isn\'t valid. Ask the coordinator to show the current one.'**
  String get errInvalidCode;

  /// No description provided for @errNoStudents.
  ///
  /// In en, this message translates to:
  /// **'Select at least one person.'**
  String get errNoStudents;

  /// No description provided for @errNothingToCertify.
  ///
  /// In en, this message translates to:
  /// **'Nothing to certify.'**
  String get errNothingToCertify;

  /// No description provided for @errCertificateNotFound.
  ///
  /// In en, this message translates to:
  /// **'Certificate not found.'**
  String get errCertificateNotFound;

  /// No description provided for @errBadReason.
  ///
  /// In en, this message translates to:
  /// **'Give a short reason (3–200 characters).'**
  String get errBadReason;

  /// No description provided for @errInvalidClaimCode.
  ///
  /// In en, this message translates to:
  /// **'That claim code isn\'t valid. Check it with your teacher.'**
  String get errInvalidClaimCode;

  /// No description provided for @errAlreadyClaimed.
  ///
  /// In en, this message translates to:
  /// **'That record is already linked to another account.'**
  String get errAlreadyClaimed;

  /// No description provided for @errBodyTooShort.
  ///
  /// In en, this message translates to:
  /// **'Write a bit more (at least 20 characters).'**
  String get errBodyTooShort;

  /// No description provided for @errBodyTooLong.
  ///
  /// In en, this message translates to:
  /// **'That\'s too long (max 2000).'**
  String get errBodyTooLong;

  /// No description provided for @errCampaignTooLong.
  ///
  /// In en, this message translates to:
  /// **'The campaign name is too long (max 60).'**
  String get errCampaignTooLong;

  /// No description provided for @errPledgeNotFound.
  ///
  /// In en, this message translates to:
  /// **'That pledge doesn\'t exist. Check the code with whoever shared it.'**
  String get errPledgeNotFound;

  /// No description provided for @errPledgeClosed.
  ///
  /// In en, this message translates to:
  /// **'This pledge is closed to new signatures.'**
  String get errPledgeClosed;

  /// No description provided for @errPledgeAlreadySigned.
  ///
  /// In en, this message translates to:
  /// **'People have signed this pledge, so its wording can\'t change.'**
  String get errPledgeAlreadySigned;

  /// No description provided for @errPledgeHasSignatures.
  ///
  /// In en, this message translates to:
  /// **'This pledge has signatures and can\'t be deleted. Close it instead.'**
  String get errPledgeHasSignatures;

  /// No description provided for @errBadStatus.
  ///
  /// In en, this message translates to:
  /// **'Not a valid status.'**
  String get errBadStatus;

  /// No description provided for @errBadTarget.
  ///
  /// In en, this message translates to:
  /// **'Nothing to report.'**
  String get errBadTarget;

  /// No description provided for @errTooManyReports.
  ///
  /// In en, this message translates to:
  /// **'You\'ve sent a lot of reports today. Try again tomorrow.'**
  String get errTooManyReports;
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
