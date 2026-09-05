import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/l10n/generated/app_localizations.dart';

/// Turns a stable error key into a sentence for the user.
///
/// Every key raised by a server function must appear here; a test parses
/// the migrations and fails when one is missing. Unknown keys fall back to
/// a generic message: the raw server text is never shown.
String errorMessage(AppLocalizations l, String key) {
  switch (key) {
    case 'REQUIRED':
      return l.errRequired;
    case 'BAD_CODE':
      return l.errBadCode;
    case 'OFFLINE':
      return l.errOffline;
    case 'SERVER_ERROR':
      return l.errServer;
    case 'NOT_SIGNED_IN':
      return l.errNotSignedIn;
    case 'NOT_AUTHORISED':
      return l.errNotAuthorised;
    case 'AUTH_FAILED':
      return l.errAuthFailed;
    case 'BAD_CREDENTIALS':
      return l.errBadCredentials;
    case 'TOO_MANY_ATTEMPTS':
      return l.errTooManyAttempts;
    case 'NAME_TOO_SHORT':
      return l.errNameTooShort;
    case 'NAME_TOO_LONG':
      return l.errNameTooLong;
    case 'NAME_LOOKS_LIKE_EMAIL':
      return l.errNameLooksLikeEmail;
    case 'ABOUT_TOO_LONG':
      return l.errAboutTooLong;
    case 'CITY_TOO_LONG':
      return l.errCityTooLong;
    case 'BAD_TYPE':
      return l.errBadType;
    case 'BAD_ROLE':
      return l.errBadRole;
    case 'BAD_EMAIL':
      return l.errBadEmail;
    case 'ORG_NOT_FOUND':
      return l.errOrgNotFound;
    case 'MEMBER_NOT_FOUND':
      return l.errMemberNotFound;
    case 'CANNOT_REMOVE_OWNER':
      return l.errCannotRemoveOwner;
    case 'SOLE_OWNER':
      return l.errSoleOwner;
    case 'INVITE_NOT_FOUND':
      return l.errInviteNotFound;
    case 'TITLE_TOO_SHORT':
      return l.errTitleTooShort;
    case 'TITLE_TOO_LONG':
      return l.errTitleTooLong;
    case 'DESCRIPTION_TOO_LONG':
      return l.errDescriptionTooLong;
    case 'CAUSE_TOO_LONG':
      return l.errCauseTooLong;
    case 'VENUE_TOO_LONG':
      return l.errVenueTooLong;
    case 'END_BEFORE_START':
      return l.errEndBeforeStart;
    case 'STARTS_IN_PAST':
      return l.errStartsInPast;
    case 'BAD_CAPACITY':
      return l.errBadCapacity;
    case 'BAD_HOURS':
      return l.errBadHours;
    case 'DRIVE_NOT_FOUND':
      return l.errDriveNotFound;
    case 'DRIVE_NOT_OPEN':
      return l.errDriveNotOpen;
    case 'DRIVE_ENDED':
      return l.errDriveEnded;
    case 'DRIVE_FULL':
      return l.errDriveFull;
    case 'NOT_REGISTERED':
      return l.errNotRegistered;
    case 'BAD_KIND':
      return l.errBadKind;
    case 'CLASS_TOO_LONG':
      return l.errClassTooLong;
    case 'BAD_ROLL':
      return l.errBadRoll;
    case 'BAD_PHONE':
      return l.errBadPhone;
    case 'DUPLICATE_EMAIL':
      return l.errDuplicateEmail;
    case 'DUPLICATE_ROLL':
      return l.errDuplicateRoll;
    case 'STUDENT_NOT_FOUND':
      return l.errStudentNotFound;
    case 'STUDENT_HAS_RECORDS':
      return l.errStudentHasRecords;
    case 'STUDENT_CLAIMED':
      return l.errStudentClaimed;
    case 'INVALID_CODE':
      return l.errInvalidCode;
    case 'NO_STUDENTS':
      return l.errNoStudents;
    case 'NOTHING_TO_CERTIFY':
      return l.errNothingToCertify;
    case 'CERTIFICATE_NOT_FOUND':
      return l.errCertificateNotFound;
    case 'BAD_REASON':
      return l.errBadReason;
    case 'INVALID_CLAIM_CODE':
      return l.errInvalidClaimCode;
    case 'ALREADY_CLAIMED':
      return l.errAlreadyClaimed;
    case 'BODY_TOO_SHORT':
      return l.errBodyTooShort;
    case 'BODY_TOO_LONG':
      return l.errBodyTooLong;
    case 'CAMPAIGN_TOO_LONG':
      return l.errCampaignTooLong;
    case 'PLEDGE_NOT_FOUND':
      return l.errPledgeNotFound;
    case 'PLEDGE_CLOSED':
      return l.errPledgeClosed;
    case 'PLEDGE_ALREADY_SIGNED':
      return l.errPledgeAlreadySigned;
    case 'PLEDGE_HAS_SIGNATURES':
      return l.errPledgeHasSignatures;
    case 'BAD_STATUS':
      return l.errBadStatus;
    case 'BAD_TARGET':
      return l.errBadTarget;
    case 'TOO_MANY_REPORTS':
      return l.errTooManyReports;
    default:
      return l.errUnknown;
  }
}

extension SoiErrorMessageX on SoiError {
  String message(AppLocalizations l) => errorMessage(l, key);
}
