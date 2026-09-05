// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SWAG of India';

  @override
  String get brandShort => 'SOI';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDone => 'Done';

  @override
  String get commonClose => 'Close';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonBack => 'Back';

  @override
  String get commonShare => 'Share';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonCopied => 'Copied';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonOpen => 'Open';

  @override
  String get commonSignIn => 'Sign in';

  @override
  String get commonSignOut => 'Sign out';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonOptional => 'optional';

  @override
  String get commonSeeAll => 'See all';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get commonYes => 'Yes';

  @override
  String commonHours(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String commonHoursShort(String count) {
    return '${count}h';
  }

  @override
  String get stateOfflineTitle => 'You\'re offline';

  @override
  String get stateOfflineBody =>
      'Check your connection and try again. Nothing you did has been lost.';

  @override
  String get stateErrorTitle => 'Something went wrong';

  @override
  String get stateErrorBody =>
      'We couldn\'t load this right now. Please try again in a moment.';

  @override
  String get stateNotFoundTitle => 'Not found';

  @override
  String get stateNotFoundBody =>
      'This link may be old or the item may have been removed.';

  @override
  String get stateSignedOutTitle => 'Sign in to continue';

  @override
  String get stateSignedOutBody =>
      'Free. Just an email. No documents, no fees.';

  @override
  String get vocabDrive => 'Drive';

  @override
  String get vocabDrives => 'Drives';

  @override
  String get vocabPledge => 'Pledge';

  @override
  String get vocabOrganisation => 'Organisation';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navCheckIn => 'Check in';

  @override
  String get navPassport => 'Passport';

  @override
  String get navProfile => 'Profile';

  @override
  String get navManage => 'Manage';

  @override
  String get welcomeTagline =>
      'Volunteering only counts when someone can vouch for it.';

  @override
  String get welcomeLead =>
      'Find drives run by NGOs, schools and companies. Turn up, scan the coordinator\'s QR, and your hours are signed off by the organisation itself.';

  @override
  String get welcomeStatOrganisations => 'Organisations';

  @override
  String get welcomeStatDrives => 'Drives';

  @override
  String get welcomeStatHours => 'Certified hours';

  @override
  String get welcomeStatVolunteers => 'Volunteers';

  @override
  String get welcomeCtaBrowse => 'Browse drives';

  @override
  String get welcomeCtaSignIn => 'Sign in or create an account';

  @override
  String get welcomeFree => 'Free. Just an email — no documents, no fees.';

  @override
  String get welcomeStep1Title => 'Turn up';

  @override
  String get welcomeStep1Body =>
      'Register for a drive near you and show up on the day.';

  @override
  String get welcomeStep2Title => 'Scan';

  @override
  String get welcomeStep2Body =>
      'Scan the coordinator\'s QR code at the venue. Your hours are recorded as pending.';

  @override
  String get welcomeStep3Title => 'Get certified';

  @override
  String get welcomeStep3Body =>
      'The organisation confirms you were there. Your certificate can be verified by anyone.';

  @override
  String get welcomeHappeningSoon => 'Happening soon';

  @override
  String get welcomeHavePledgeCode => 'Have a pledge code?';

  @override
  String get welcomePledgeCodeHint => '6-character code';

  @override
  String get welcomeOpenPledge => 'Open pledge';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInLead => 'Enter your email and we\'ll send a one-time code.';

  @override
  String get signInEmailLabel => 'Email';

  @override
  String get signInSendCode => 'Send code';

  @override
  String get signInCodeTitle => 'Check your inbox';

  @override
  String signInCodeLead(String email) {
    return 'We sent a code to $email. It expires in a few minutes.';
  }

  @override
  String get signInCodeLabel => 'One-time code';

  @override
  String get signInVerify => 'Verify';

  @override
  String get signInResend => 'Resend code';

  @override
  String signInResendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get signInSpamHint => 'Not there? Check your spam folder.';

  @override
  String get signInDifferentEmail => 'Use a different email';

  @override
  String get signInUsePassword => 'Sign in with a password instead';

  @override
  String get signInUseCode => 'Sign in with a code instead';

  @override
  String get signInPasswordLabel => 'Password';

  @override
  String get signInPasswordLead => 'For accounts set up with a password.';

  @override
  String get signInLegal => 'By continuing you agree to our privacy policy.';

  @override
  String get onboardNameTitle => 'What\'s your name?';

  @override
  String get onboardNameLead =>
      'This is the name printed on your certificates. Use your real name as a college or employer would expect to see it.';

  @override
  String get onboardNameLabel => 'Full name';

  @override
  String get onboardIntentTitle => 'How will you use SOI?';

  @override
  String get onboardIntentLead =>
      'You can always do both. This just sets up your first screen.';

  @override
  String get onboardIntentVolunteerTitle => 'I volunteer';

  @override
  String get onboardIntentVolunteerBody =>
      'Find drives, check in, collect certified hours.';

  @override
  String get onboardIntentOrgTitle => 'I run an organisation';

  @override
  String get onboardIntentOrgBody =>
      'Register an NGO, school or company to publish drives and certify hours.';

  @override
  String get onboardIntentInviteHint =>
      'Already part of an organisation? Ask its admin to invite you by email and it will appear here automatically.';

  @override
  String get discoverTitle => 'Find a drive';

  @override
  String get discoverLead =>
      'Turn up, scan the QR, and your hours get signed off by the organisation itself.';

  @override
  String get discoverSearchHint =>
      'Search drives, venues, cities, organisations';

  @override
  String get discoverFilterCause => 'Cause';

  @override
  String get discoverFilterCity => 'City';

  @override
  String get discoverFilterAll => 'All';

  @override
  String get discoverSortSoonest => 'Soonest';

  @override
  String get discoverSortHours => 'Most hours';

  @override
  String get discoverUpcoming => 'Upcoming';

  @override
  String discoverResults(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count drives',
      one: '1 drive',
      zero: 'No drives',
    );
    return '$_temp0';
  }

  @override
  String get discoverEmptyTitle => 'No drives just yet';

  @override
  String get discoverEmptyBody =>
      'When an organisation publishes a drive it shows up here. Pull down to refresh.';

  @override
  String get discoverNoMatchTitle => 'Nothing matches';

  @override
  String get discoverNoMatchBody =>
      'Try a different word or clear the filters.';

  @override
  String discoverSpotsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spots left',
      one: '1 spot left',
      zero: 'Full',
    );
    return '$_temp0';
  }

  @override
  String get discoverRegistered => 'Registered';

  @override
  String get discoverVerified => 'Verified';

  @override
  String get discoverLoadMore => 'Load more';

  @override
  String get discoverEndOfList => 'You\'re all caught up';

  @override
  String get driveTitle => 'Drive';

  @override
  String get driveAbout => 'About this drive';

  @override
  String get driveWhen => 'When';

  @override
  String get driveWhere => 'Where';

  @override
  String get driveHoursCredited => 'Hours credited, once certified';

  @override
  String get driveSpots => 'Spots';

  @override
  String get driveOrganiser => 'Organised by';

  @override
  String get driveRegister => 'Register';

  @override
  String get driveRegistered => 'You\'re registered';

  @override
  String get driveCancelRegistration => 'Cancel registration';

  @override
  String get driveCancelConfirmTitle => 'Cancel your registration?';

  @override
  String get driveCancelConfirmBody =>
      'Your spot goes back to the pool. You can register again if spots remain.';

  @override
  String get driveRegisteredSnack => 'Registered. See you there.';

  @override
  String get driveCancelledSnack => 'Registration cancelled.';

  @override
  String get driveDirections => 'Directions';

  @override
  String get driveShare => 'Share';

  @override
  String driveShareText(String title, String org, String when, String link) {
    return '$title — $org, $when. Join via SWAG of India: $link';
  }

  @override
  String get driveReport => 'Report this listing';

  @override
  String get driveReportTitle => 'Report this drive';

  @override
  String get driveReportReason1 => 'Misleading or fake';

  @override
  String get driveReportReason2 => 'Inappropriate content';

  @override
  String get driveReportReason3 => 'Unsafe activity';

  @override
  String get driveReportThanks =>
      'Thank you. We review reports within 48 hours.';

  @override
  String driveCheckedInPending(String org) {
    return 'You checked in. Awaiting sign-off by $org.';
  }

  @override
  String get driveCheckedInCertified => 'Your hours here are certified.';

  @override
  String get driveCancelledBanner => 'This drive was cancelled.';

  @override
  String get driveEndedBanner => 'This drive has ended.';

  @override
  String get driveFullBanner => 'This drive is full.';

  @override
  String get driveManage => 'Manage';

  @override
  String get driveCoordinatorMode => 'Coordinator Mode';

  @override
  String get driveNothingCertifiedAuto =>
      'Nothing is certified automatically. Hours only count once the organisation signs them off.';

  @override
  String get orgTitle => 'Organisation';

  @override
  String get orgVerifiedBadge => 'Verified organisation';

  @override
  String get orgUnverified => 'Not yet verified';

  @override
  String get orgDrivesRun => 'Drives run';

  @override
  String get orgHoursCertified => 'Hours certified';

  @override
  String get orgUpcoming => 'Upcoming drives';

  @override
  String get orgNoUpcoming => 'No upcoming drives.';

  @override
  String get orgTypeNgo => 'NGO';

  @override
  String get orgTypeSchool => 'School / College';

  @override
  String get orgTypeCorporate => 'Company';

  @override
  String get checkInTitle => 'Check in';

  @override
  String get checkInLead => 'Point at the coordinator\'s QR code';

  @override
  String get checkInPermissionTitle => 'Camera access needed';

  @override
  String get checkInPermissionBody =>
      'SOI uses the camera only to scan the coordinator\'s QR code so your volunteering hours can be recorded. Nothing is stored.';

  @override
  String get checkInAllowCamera => 'Allow camera';

  @override
  String get checkInOpenSettings => 'Open settings';

  @override
  String get checkInEnterCode => 'Enter code instead';

  @override
  String get checkInManualTitle => 'Enter the code';

  @override
  String get checkInManualLead =>
      'Ask the coordinator to read out the code under their QR, or paste a pledge code.';

  @override
  String get checkInManualHint => 'Paste the full code';

  @override
  String get checkInTorch => 'Torch';

  @override
  String get checkInSuccessTitle => 'Checked in';

  @override
  String checkInSuccessBody(String hours, String drive, String org) {
    return '$hours at $drive recorded. Awaiting sign-off by $org.';
  }

  @override
  String get checkInAlreadyTitle => 'Already checked in';

  @override
  String checkInAlreadyBody(String drive) {
    return 'You\'re on the roster for $drive.';
  }

  @override
  String get checkInViewPassport => 'View my Passport';

  @override
  String get checkInScanAnother => 'Scan another';

  @override
  String get checkInSignInFirst => 'Sign in to check in. It takes a minute.';

  @override
  String get checkInUnknownQr => 'That\'s not an SOI code.';

  @override
  String get passportTitle => 'Impact Passport';

  @override
  String get passportCertifiedHours => 'Certified hours';

  @override
  String get passportPending => 'Awaiting sign-off';

  @override
  String get passportDrives => 'Drives';

  @override
  String get passportPledges => 'Pledges';

  @override
  String get passportLead =>
      'Every certified hour was signed off by the organisation that ran the drive. That\'s what makes it worth putting on a form.';

  @override
  String get passportFilterAll => 'All';

  @override
  String get passportFilterCertified => 'Certified';

  @override
  String get passportFilterPending => 'Pending';

  @override
  String get passportFilterRejected => 'Not counted';

  @override
  String get passportFilterPledges => 'Pledges';

  @override
  String get passportEmptyTitle => 'No hours yet';

  @override
  String get passportEmptyBody =>
      'Find a drive, turn up, scan the QR. Your hours land here once the organisation confirms them.';

  @override
  String passportPendingRow(String org) {
    return 'Awaiting sign-off by $org';
  }

  @override
  String passportRejectedRow(String org) {
    return 'Not counted by $org';
  }

  @override
  String passportCertifiedRow(String org) {
    return 'Certified by $org';
  }

  @override
  String get passportViewCertificate => 'View certificate';

  @override
  String passportPledgeSigned(String when, int no) {
    return 'Signed $when · #$no';
  }

  @override
  String get passportPledgesNote =>
      'Pledges are commitments, not volunteering hours. They\'re listed separately on purpose.';

  @override
  String get passportUpcoming => 'Your upcoming drives';

  @override
  String get passportLinkSchool => 'Have a claim code from your school?';

  @override
  String get certificateTitle => 'Certificate';

  @override
  String get certificateKicker => 'Certificate of volunteering';

  @override
  String get certificateKickerPledge => 'Certificate of pledge';

  @override
  String get certificateCertify => 'This is to certify that';

  @override
  String get certificateCompleted => 'has completed and had certified';

  @override
  String get certificateHoursUnit => 'hours';

  @override
  String get certificateOfVolunteering => 'of volunteering at';

  @override
  String get certificateTakenPledge => 'has taken the pledge';

  @override
  String get certificateIssued => 'Issued';

  @override
  String get certificateNumber => 'Certificate no.';

  @override
  String get certificateScanToVerify => 'Scan to verify';

  @override
  String certificateWithdrawn(String reason) {
    return 'Withdrawn — $reason';
  }

  @override
  String get certificateAnyoneCanCheck => 'Anyone can check this is real';

  @override
  String certificateAnyoneCanCheckBody(String host) {
    return 'Open $host and enter the number, or scan the QR. No account needed. It shows who it was issued to, by whom, and for what — nothing else.';
  }

  @override
  String get certificateShareImage => 'Share as image';

  @override
  String get certificateShareLink => 'Share verification link';

  @override
  String get certificateCopyCode => 'Copy number';

  @override
  String get certificateNotFoundTitle => 'Certificate not found';

  @override
  String get certificateNotFoundBody =>
      'Check the number — it should look like SOI-AB12-CD34.';

  @override
  String certificateShareText(String name, String link) {
    return 'Verified volunteering certificate for $name: $link';
  }

  @override
  String get pledgeTitle => 'Pledge';

  @override
  String pledgeBy(String org) {
    return 'by $org';
  }

  @override
  String pledgeSignatures(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count signatures',
      one: '1 signature',
      zero: 'No signatures yet',
    );
    return '$_temp0';
  }

  @override
  String get pledgeSign => 'Take this pledge';

  @override
  String get pledgeSigned => 'You took this pledge';

  @override
  String pledgeSignedNo(int no, String when) {
    return 'Signature #$no · $when';
  }

  @override
  String get pledgeClosed => 'This pledge is closed to new signatures.';

  @override
  String get pledgeWhatThisIs => 'What this is — and isn\'t';

  @override
  String get pledgeWhatThisIsBody =>
      'A pledge is a public commitment. It takes a moment and it matters. It is not volunteering: hours only come from turning up to a drive and being signed off by the organisation that ran it.';

  @override
  String pledgeShareText(String title, String org, String link) {
    return 'I took the pledge \"$title\" with $org. Take it too: $link';
  }

  @override
  String get pledgeShowQr => 'Show QR';

  @override
  String get pledgeSignedSnack => 'Pledge taken. Your certificate is ready.';

  @override
  String get pledgeSignInToSign => 'Sign in to take this pledge.';

  @override
  String get manageTitle => 'Manage';

  @override
  String get manageLead => 'Publish drives, run check-in, certify hours.';

  @override
  String get manageToday => 'Today';

  @override
  String get manageUpcoming => 'Upcoming';

  @override
  String get managePast => 'Past drives';

  @override
  String get managePublish => 'Publish a drive';

  @override
  String get manageRoster => 'Roster';

  @override
  String get managePledges => 'Pledges';

  @override
  String get manageOrganisation => 'Organisation';

  @override
  String get manageNoDrives => 'No drives yet';

  @override
  String get manageNoDrivesBody =>
      'Publish your first drive. Volunteers see it the moment it\'s live.';

  @override
  String manageDriveStats(int registered, int checkedIn, int certified) {
    return '$registered registered · $checkedIn checked in · $certified certified';
  }

  @override
  String managePendingBadge(int count) {
    return '$count to certify';
  }

  @override
  String get manageSwitchOrg => 'Organisation';

  @override
  String get manageRegisterOrg => 'Register an organisation';

  @override
  String get manageRegisterOrgBody =>
      'NGOs, schools and companies publish drives and certify hours.';

  @override
  String get driveFormNewTitle => 'Publish a drive';

  @override
  String get driveFormEditTitle => 'Edit drive';

  @override
  String get driveFormOrg => 'Organisation';

  @override
  String get driveFormTitleLabel => 'Title';

  @override
  String get driveFormTitleHint => 'e.g. Godavari ghat clean-up';

  @override
  String get driveFormCause => 'Cause';

  @override
  String get driveFormDescription => 'What volunteers will do';

  @override
  String get driveFormDescriptionHint =>
      'What to bring, where to meet, who to ask for.';

  @override
  String get driveFormDate => 'Date';

  @override
  String get driveFormStart => 'Starts';

  @override
  String get driveFormEnd => 'Ends';

  @override
  String get driveFormVenue => 'Venue';

  @override
  String get driveFormCity => 'City';

  @override
  String get driveFormCapacity => 'Spots';

  @override
  String get driveFormHours => 'Hours credited';

  @override
  String get driveFormHoursHelp =>
      'Credited to each volunteer once you certify them. Nothing is certified automatically.';

  @override
  String get driveFormPublish => 'Publish';

  @override
  String get driveFormSave => 'Save changes';

  @override
  String get driveFormPublished => 'Drive published.';

  @override
  String get driveFormSaved => 'Drive updated.';

  @override
  String get driveFormCancelDrive => 'Cancel this drive';

  @override
  String get driveFormCancelConfirmTitle => 'Cancel this drive?';

  @override
  String get driveFormCancelConfirmBody =>
      'It disappears from Discover and no one can register or check in. Hours already certified are unaffected.';

  @override
  String get driveFormCancelled => 'Drive cancelled.';

  @override
  String get driveFormUnsavedTitle => 'Discard changes?';

  @override
  String get driveFormUnsavedBody => 'You have unsaved edits.';

  @override
  String get driveFormDiscard => 'Discard';

  @override
  String get causeEnvironment => 'Environment';

  @override
  String get causeEducation => 'Education';

  @override
  String get causeHealth => 'Health';

  @override
  String get causeCommunity => 'Community';

  @override
  String get causeAnimalWelfare => 'Animal welfare';

  @override
  String get causeDisasterRelief => 'Disaster relief';

  @override
  String get causeOther => 'Other';

  @override
  String get coordTitle => 'Coordinator Mode';

  @override
  String get coordShowThis => 'Show this to volunteers';

  @override
  String get coordRotate => 'Rotate code';

  @override
  String get coordRotateHint =>
      'Rotate if the QR was photographed. Old scans stop working instantly.';

  @override
  String get coordRotated => 'Code rotated.';

  @override
  String get coordCode => 'Code';

  @override
  String get coordRosterTitle => 'Roster';

  @override
  String get coordRosterSearch => 'Search names';

  @override
  String get coordRosterEmpty => 'No check-ins yet';

  @override
  String get coordRosterEmptyBody =>
      'As volunteers scan, they appear here live.';

  @override
  String get coordRosterError =>
      'Couldn\'t load the roster. Volunteers may still have checked in — do not tell anyone they were absent.';

  @override
  String coordCertifyAll(int count) {
    return 'Certify all pending ($count)';
  }

  @override
  String get coordCertify => 'Certify';

  @override
  String get coordReject => 'Don\'t count';

  @override
  String coordCertifyConfirmTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count volunteers',
      one: '1 volunteer',
    );
    return 'Certify $_temp0?';
  }

  @override
  String get coordCertifyConfirmBody =>
      'Each gets a certificate anyone can verify. This cannot be undone.';

  @override
  String coordCertified(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count certificates issued',
      one: '1 certificate issued',
    );
    return '$_temp0';
  }

  @override
  String get coordRejectConfirmTitle => 'Don\'t count this attendance?';

  @override
  String coordRejectConfirmBody(String name) {
    return '$name will see it as not counted. Use this for someone who scanned but did not stay.';
  }

  @override
  String get coordRejected => 'Marked as not counted.';

  @override
  String get coordMarkStudents => 'Mark students present';

  @override
  String get coordStatusPending => 'Pending';

  @override
  String get coordStatusCertified => 'Certified';

  @override
  String get coordStatusRejected => 'Not counted';

  @override
  String get coordMethodTeacher => 'Marked by teacher';

  @override
  String get coordStudentTag => 'School';

  @override
  String coordStats(int total, int pending, int certified) {
    return '$total checked in · $pending pending · $certified certified';
  }

  @override
  String get rosterTitle => 'Roster';

  @override
  String get rosterLead =>
      'They don\'t need an account, an email or a phone. You hold the record.';

  @override
  String get rosterSearch => 'Search names or roll numbers';

  @override
  String get rosterAdd => 'Add person';

  @override
  String get rosterBulk => 'Paste a list';

  @override
  String get rosterEmptyTitle => 'No one enrolled yet';

  @override
  String get rosterEmptyBody =>
      'Add students or volunteers. Each gets a claim code so their hours follow them if they ever make an account.';

  @override
  String get rosterKindStudent => 'Student';

  @override
  String get rosterKindVolunteer => 'Volunteer';

  @override
  String get rosterName => 'Full name';

  @override
  String get rosterClass => 'Class / section';

  @override
  String get rosterRoll => 'Roll no.';

  @override
  String get rosterEmail => 'Email';

  @override
  String get rosterPhone => 'Mobile';

  @override
  String get rosterPrivacyNote =>
      'For under-18s we deliberately ask only for name, class and roll number — no date of birth, photo or address.';

  @override
  String rosterEnrolled(String name, String code) {
    return '$name enrolled. Claim code $code.';
  }

  @override
  String get rosterClaimCode => 'Claim code';

  @override
  String get rosterClaimHint =>
      'Give this code to the person. When they create an account they enter it under Profile to attach their hours.';

  @override
  String get rosterClaimed => 'Linked to an account';

  @override
  String rosterHours(String certified, String pending) {
    return '$certified certified · $pending pending';
  }

  @override
  String rosterRemoveConfirmTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get rosterRemoveConfirmBody =>
      'Only possible while they have no attendance records.';

  @override
  String get rosterRemoved => 'Removed.';

  @override
  String get rosterBulkTitle => 'Paste a list';

  @override
  String get rosterBulkLead =>
      'One person per line: name, class, roll. Commas or tabs.';

  @override
  String rosterBulkPreview(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people',
      one: '1 person',
    );
    return '$_temp0 ready to enrol';
  }

  @override
  String get rosterBulkEnrol => 'Enrol all';

  @override
  String rosterBulkDone(int ok, int failed) {
    return '$ok enrolled, $failed skipped';
  }

  @override
  String get rosterGroupUngrouped => 'No class';

  @override
  String get markTitle => 'Mark attendance';

  @override
  String get markLead =>
      'Select who was at this drive. The organisation that ran it still certifies.';

  @override
  String get markSelectAll => 'Select all';

  @override
  String markSelected(int count) {
    return '$count selected';
  }

  @override
  String get markAlready => 'Already marked';

  @override
  String markConfirmTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people',
      one: '1 person',
    );
    return 'Mark $_temp0 present?';
  }

  @override
  String markConfirmBody(String drive) {
    return 'This records pending hours at $drive. It can\'t be undone from here.';
  }

  @override
  String markDone(int count) {
    return '$count marked present.';
  }

  @override
  String get markChooseDrive => 'Choose the drive';

  @override
  String get pledgesTitle => 'Pledges';

  @override
  String get pledgesNew => 'New pledge';

  @override
  String get pledgesEmptyTitle => 'No pledges yet';

  @override
  String get pledgesEmptyBody =>
      'Publish a pledge and share its code or QR. Signatures show up here.';

  @override
  String get pledgesFilterActive => 'Active';

  @override
  String get pledgesFilterClosed => 'Closed';

  @override
  String get pledgesClose => 'Close';

  @override
  String get pledgesReopen => 'Reopen';

  @override
  String get pledgesSigners => 'Signers';

  @override
  String get pledgesDeleteTitle => 'Delete this pledge?';

  @override
  String get pledgesDeleteBody =>
      'No one has signed it, so it can be removed completely.';

  @override
  String get pledgesDeleteBlockedTitle => 'This pledge has signatures';

  @override
  String get pledgesDeleteBlockedBody =>
      'Everyone who signed it agreed to these exact words and holds a certificate for it, so it can\'t be deleted. You can close it to stop new signatures.';

  @override
  String get pledgesDeleted => 'Pledge deleted.';

  @override
  String get pledgesClosed => 'Pledge closed.';

  @override
  String get pledgesReopened => 'Pledge reopened.';

  @override
  String get pledgeFormNewTitle => 'Create a pledge';

  @override
  String get pledgeFormEditTitle => 'Edit pledge';

  @override
  String get pledgeFormTitleLabel => 'Title';

  @override
  String get pledgeFormCampaign => 'Campaign';

  @override
  String get pledgeFormCampaignHint => 'e.g. Plastic-free 2026';

  @override
  String get pledgeFormBody => 'The pledge';

  @override
  String get pledgeFormBodyHint =>
      'Write it in the first person: \"I pledge to…\"';

  @override
  String get pledgeFormLocked =>
      'The wording is locked: everyone who signed it agreed to these exact words. The title can still change.';

  @override
  String get pledgeFormPublish => 'Publish pledge';

  @override
  String get pledgeFormPublished => 'Pledge published.';

  @override
  String get pledgeFormSaved => 'Pledge updated.';

  @override
  String get pledgeFormNotHours =>
      'A pledge is not volunteering hours. Signing takes seconds; certified hours mean someone turned up and you signed off.';

  @override
  String get orgFormNewTitle => 'Register an organisation';

  @override
  String get orgFormEditTitle => 'Edit organisation';

  @override
  String get orgFormType => 'Type';

  @override
  String get orgFormName => 'Name';

  @override
  String get orgFormCity => 'City';

  @override
  String get orgFormAbout => 'About';

  @override
  String get orgFormAboutHint => 'What you do, in a sentence or two.';

  @override
  String get orgFormRegister => 'Register';

  @override
  String get orgFormVerifyNote =>
      'Verification is granted by the SOI team after review. Unverified organisations can still publish drives; the badge tells volunteers you\'ve been checked.';

  @override
  String get orgFormRegistered => 'Organisation registered.';

  @override
  String get orgFormSaved => 'Organisation updated.';

  @override
  String get orgSettingsTitle => 'Organisation';

  @override
  String get orgSettingsMembers => 'Team';

  @override
  String get orgSettingsInvite => 'Invite by email';

  @override
  String get orgSettingsInviteLead =>
      'They get access the moment they sign in with this email.';

  @override
  String get orgSettingsInviteRole => 'Role';

  @override
  String get orgSettingsInvited => 'Invite sent.';

  @override
  String get orgSettingsPending => 'Pending invites';

  @override
  String get orgSettingsRoleOwner => 'Owner';

  @override
  String get orgSettingsRoleAdmin => 'Admin';

  @override
  String get orgSettingsRoleCoordinator => 'Coordinator';

  @override
  String get orgSettingsRoleMember => 'Member';

  @override
  String get orgSettingsRoleAdminHelp =>
      'Can manage the team and edit the organisation.';

  @override
  String get orgSettingsRoleCoordinatorHelp =>
      'Can publish drives, run check-in and certify.';

  @override
  String get orgSettingsRoleMemberHelp => 'Can see the organisation\'s drives.';

  @override
  String orgSettingsRemoveConfirmTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get orgSettingsRemoveConfirmBody =>
      'They lose access immediately. Hours they certified are unaffected.';

  @override
  String get orgSettingsRemoved => 'Removed.';

  @override
  String get orgSettingsLeave => 'Leave organisation';

  @override
  String orgSettingsLeaveConfirmTitle(String org) {
    return 'Leave $org?';
  }

  @override
  String get orgSettingsLeaveConfirmBody =>
      'You\'ll lose coordinator access. An admin can invite you back.';

  @override
  String orgSettingsLeft(String org) {
    return 'You left $org.';
  }

  @override
  String get orgSettingsCancelInvite => 'Cancel invite';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileNameOnCertificates => 'Name on certificates';

  @override
  String get profileEditName => 'Edit name';

  @override
  String get profileNameSaved => 'Name saved.';

  @override
  String profileNameUpdatedCerts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count certificates updated.',
      one: '1 certificate updated.',
      zero: '',
    );
    return 'Name saved. $_temp0';
  }

  @override
  String get profileOrganisations => 'Organisations';

  @override
  String get profileNoOrganisations => 'You\'re not part of an organisation.';

  @override
  String get profileRegisterOrg => 'Register an organisation';

  @override
  String get profileLinkSchool => 'Link records from my school';

  @override
  String get profileAppearance => 'Appearance';

  @override
  String get profileAppearanceSystem => 'Follows your phone\'s theme.';

  @override
  String get profileLegal => 'About';

  @override
  String get profilePrivacy => 'Privacy policy';

  @override
  String get profileChildSafety => 'Child safety standards';

  @override
  String get profileSupport => 'Contact support';

  @override
  String profileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get profileSignOutConfirmTitle => 'Sign out?';

  @override
  String get profileSignOutConfirmBody =>
      'You\'ll need your email code to sign back in.';

  @override
  String get profileDeleteAccount => 'Delete my account';

  @override
  String get profileDeleteConfirmTitle => 'Delete your account?';

  @override
  String get profileDeleteConfirmBody =>
      'Your account and personal data are deleted straight away. Certificates already issued stay verifiable, without your account attached. This cannot be undone.';

  @override
  String get profileDeleteConfirmAction => 'Delete permanently';

  @override
  String get profileDeleted => 'Your account has been deleted.';

  @override
  String get profileSignedOut => 'Signed out.';

  @override
  String get claimTitle => 'Link your school records';

  @override
  String get claimLead =>
      'Your teacher gave you an 8-character claim code. Enter it once and the hours they recorded for you appear in your Passport.';

  @override
  String get claimLabel => 'Claim code';

  @override
  String get claimSubmit => 'Link my records';

  @override
  String claimSuccess(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Linked $count records for $name.',
      one: 'Linked 1 record for $name.',
      zero: 'Linked $name\'s record.',
    );
    return '$_temp0';
  }

  @override
  String get errRequired => 'Required';

  @override
  String get errBadCode => 'That code doesn\'t look right.';

  @override
  String get errOffline =>
      'You\'re offline. Check your connection and try again.';

  @override
  String get errUnknown => 'Something went wrong. Please try again.';

  @override
  String get errServer =>
      'The server had a problem. Please try again in a moment.';

  @override
  String get errNotSignedIn => 'Please sign in to do that.';

  @override
  String get errNotAuthorised =>
      'You don\'t have permission to do that in this organisation.';

  @override
  String get errAuthFailed => 'Sign-in failed. Please try again.';

  @override
  String get errBadCredentials => 'That code or password isn\'t right.';

  @override
  String get errTooManyAttempts =>
      'Too many attempts. Wait a few minutes and try again.';

  @override
  String get errNameTooShort => 'Enter the full name.';

  @override
  String get errNameTooLong => 'That name is too long (max 80).';

  @override
  String get errNameLooksLikeEmail => 'Enter a name, not an email address.';

  @override
  String get errAboutTooLong => 'That\'s too long (max 1000).';

  @override
  String get errCityTooLong => 'That city name is too long.';

  @override
  String get errBadType => 'Pick NGO, school or company.';

  @override
  String get errBadRole => 'Pick a role.';

  @override
  String get errBadEmail => 'That email address isn\'t valid.';

  @override
  String get errOrgNotFound => 'That organisation no longer exists.';

  @override
  String get errMemberNotFound => 'That person isn\'t in this organisation.';

  @override
  String get errCannotRemoveOwner => 'Owners can\'t be removed.';

  @override
  String get errSoleOwner =>
      'You\'re the only owner. Make someone else an admin first.';

  @override
  String get errInviteNotFound => 'That invite is no longer pending.';

  @override
  String get errTitleTooShort =>
      'Give it a longer title (at least 5 characters).';

  @override
  String get errTitleTooLong => 'That title is too long (max 120).';

  @override
  String get errDescriptionTooLong => 'The description is too long (max 4000).';

  @override
  String get errCauseTooLong => 'That cause is too long.';

  @override
  String get errVenueTooLong => 'That venue is too long.';

  @override
  String get errEndBeforeStart => 'The drive has to end after it starts.';

  @override
  String get errStartsInPast => 'The start time is in the past.';

  @override
  String get errBadCapacity => 'Spots must be between 1 and 5000.';

  @override
  String get errBadHours => 'Hours must be between 0.5 and 12.';

  @override
  String get errDriveNotFound => 'That drive isn\'t available.';

  @override
  String get errDriveNotOpen => 'This drive isn\'t open.';

  @override
  String get errDriveEnded => 'This drive has already ended.';

  @override
  String get errDriveFull => 'This drive is full.';

  @override
  String get errNotRegistered => 'You aren\'t registered for this drive.';

  @override
  String get errBadKind => 'Pick student or volunteer.';

  @override
  String get errClassTooLong => 'Class is too long (max 20).';

  @override
  String get errBadRoll =>
      'Roll numbers can only contain letters, numbers, - and /.';

  @override
  String get errBadPhone => 'Enter a 10-digit Indian mobile number.';

  @override
  String get errDuplicateEmail =>
      'Someone with that email is already on this roster.';

  @override
  String get errDuplicateRoll =>
      'That roll number already exists in this class.';

  @override
  String get errStudentNotFound => 'That person is no longer on the roster.';

  @override
  String get errStudentHasRecords =>
      'This person has attendance records, so they can\'t be removed.';

  @override
  String get errStudentClaimed =>
      'This person has linked an account, so they can\'t be removed.';

  @override
  String get errInvalidCode =>
      'That QR code isn\'t valid. Ask the coordinator to show the current one.';

  @override
  String get errNoStudents => 'Select at least one person.';

  @override
  String get errNothingToCertify => 'Nothing to certify.';

  @override
  String get errCertificateNotFound => 'Certificate not found.';

  @override
  String get errBadReason => 'Give a short reason (3–200 characters).';

  @override
  String get errInvalidClaimCode =>
      'That claim code isn\'t valid. Check it with your teacher.';

  @override
  String get errAlreadyClaimed =>
      'That record is already linked to another account.';

  @override
  String get errBodyTooShort => 'Write a bit more (at least 20 characters).';

  @override
  String get errBodyTooLong => 'That\'s too long (max 2000).';

  @override
  String get errCampaignTooLong => 'The campaign name is too long (max 60).';

  @override
  String get errPledgeNotFound =>
      'That pledge doesn\'t exist. Check the code with whoever shared it.';

  @override
  String get errPledgeClosed => 'This pledge is closed to new signatures.';

  @override
  String get errPledgeAlreadySigned =>
      'People have signed this pledge, so its wording can\'t change.';

  @override
  String get errPledgeHasSignatures =>
      'This pledge has signatures and can\'t be deleted. Close it instead.';

  @override
  String get errBadStatus => 'Not a valid status.';

  @override
  String get errBadTarget => 'Nothing to report.';

  @override
  String get errTooManyReports =>
      'You\'ve sent a lot of reports today. Try again tomorrow.';
}
