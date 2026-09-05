import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// Models mirror the JSON shapes returned by the server functions in
/// db/migrations (see docs/CONTRACT.md). Numeric columns are `num`: Postgres
/// returns `4` or `4.5` and a `double` field would throw on the integer.

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    String? email,
    @JsonKey(name: 'full_name') String? fullName,
    String? city,
    @JsonKey(name: 'needs_name') @Default(true) bool needsName,
  }) = _Profile;
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

@freezed
abstract class Membership with _$Membership {
  const Membership._();
  const factory Membership({
    @JsonKey(name: 'org_id') required String orgId,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'org_type') required String orgType,
    @JsonKey(name: 'verification_tier') @Default(0) int verificationTier,
    required String role,
    String? city,
  }) = _Membership;
  factory Membership.fromJson(Map<String, dynamic> json) => _$MembershipFromJson(json);

  bool get isCoordinator => role == 'owner' || role == 'admin' || role == 'coordinator';
  bool get isAdmin => role == 'owner' || role == 'admin';
  bool get isVerified => verificationTier >= 2;
}

@freezed
abstract class DriveSummary with _$DriveSummary {
  const DriveSummary._();
  const factory DriveSummary({
    required String id,
    required String title,
    String? cause,
    String? venue,
    String? city,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    @JsonKey(name: 'default_hours') required num defaultHours,
    required int capacity,
    @JsonKey(name: 'spots_left') @Default(0) int spotsLeft,
    @JsonKey(name: 'org_id') required String orgId,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'org_verified') @Default(false) bool orgVerified,
    @Default(false) bool registered,
  }) = _DriveSummary;
  factory DriveSummary.fromJson(Map<String, dynamic> json) => _$DriveSummaryFromJson(json);

  bool get isFull => spotsLeft <= 0;
}

@freezed
abstract class OrgRef with _$OrgRef {
  const OrgRef._();
  const factory OrgRef({
    required String id,
    required String name,
    required String type,
    String? city,
    @JsonKey(name: 'verification_tier') @Default(0) int verificationTier,
  }) = _OrgRef;
  factory OrgRef.fromJson(Map<String, dynamic> json) => _$OrgRefFromJson(json);
  bool get isVerified => verificationTier >= 2;
}

@freezed
abstract class MyAttendance with _$MyAttendance {
  const factory MyAttendance({
    required String status,
    required num hours,
    @JsonKey(name: 'check_in_at') required DateTime checkInAt,
  }) = _MyAttendance;
  factory MyAttendance.fromJson(Map<String, dynamic> json) => _$MyAttendanceFromJson(json);
}

@freezed
abstract class DriveDetail with _$DriveDetail {
  const DriveDetail._();
  const factory DriveDetail({
    required String id,
    required String title,
    String? description,
    String? cause,
    String? venue,
    String? city,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    required int capacity,
    @JsonKey(name: 'default_hours') required num defaultHours,
    required String status,
    @JsonKey(name: 'spots_left') @Default(0) int spotsLeft,
    int? registrations,
    @Default(false) bool registered,
    @JsonKey(name: 'can_manage') @Default(false) bool canManage,
    @JsonKey(name: 'my_attendance') MyAttendance? myAttendance,
    required OrgRef org,
  }) = _DriveDetail;
  factory DriveDetail.fromJson(Map<String, dynamic> json) => _$DriveDetailFromJson(json);

  bool get isPublished => status == 'published';
  bool get isCancelled => status == 'cancelled';
  bool get hasEnded => endsAt.isBefore(DateTime.now());
  bool get isFull => spotsLeft <= 0;
  bool get canRegister => isPublished && !hasEnded;
}

@freezed
abstract class Facets with _$Facets {
  const factory Facets({
    @Default([]) List<Facet> causes,
    @Default([]) List<Facet> cities,
  }) = _Facets;
  factory Facets.fromJson(Map<String, dynamic> json) => _$FacetsFromJson(json);
}

@freezed
abstract class Facet with _$Facet {
  const factory Facet({required String value, required int count}) = _Facet;
  factory Facet.fromJson(Map<String, dynamic> json) => _$FacetFromJson(json);
}

@freezed
abstract class Stats with _$Stats {
  const factory Stats({
    @Default(0) int organisations,
    @Default(0) int drives,
    @JsonKey(name: 'certified_hours') @Default(0) num certifiedHours,
    @Default(0) int volunteers,
    @Default(0) int pledges,
  }) = _Stats;
  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}

@freezed
abstract class CheckInResult with _$CheckInResult {
  const factory CheckInResult({
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'drive_title') required String driveTitle,
    @JsonKey(name: 'org_name') required String orgName,
    required num hours,
    required String status,
    @Default(false) bool already,
  }) = _CheckInResult;
  factory CheckInResult.fromJson(Map<String, dynamic> json) => _$CheckInResultFromJson(json);
}

@freezed
abstract class PassportRow with _$PassportRow {
  const PassportRow._();
  const factory PassportRow({
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'drive_id') required String driveId,
    @JsonKey(name: 'drive_title') required String driveTitle,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'drive_status') required String driveStatus,
    @JsonKey(name: 'org_id') required String orgId,
    @JsonKey(name: 'org_name') required String orgName,
    required num hours,
    required String status,
    required String method,
    @JsonKey(name: 'check_in_at') required DateTime checkInAt,
    @JsonKey(name: 'certified_at') DateTime? certifiedAt,
    @JsonKey(name: 'certificate_code') String? certificateCode,
  }) = _PassportRow;
  factory PassportRow.fromJson(Map<String, dynamic> json) => _$PassportRowFromJson(json);

  bool get isCertified => status == 'certified';
  bool get isPending => status == 'pending';
  bool get isRejected => status == 'rejected';
}

@freezed
abstract class PassportPledge with _$PassportPledge {
  const factory PassportPledge({
    @JsonKey(name: 'pledge_id') required String pledgeId,
    required String title,
    String? campaign,
    @JsonKey(name: 'share_code') required String shareCode,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'signature_no') required int signatureNo,
    @JsonKey(name: 'signed_at') required DateTime signedAt,
    @JsonKey(name: 'certificate_code') String? certificateCode,
  }) = _PassportPledge;
  factory PassportPledge.fromJson(Map<String, dynamic> json) => _$PassportPledgeFromJson(json);
}

@freezed
abstract class Passport with _$Passport {
  const factory Passport({
    @JsonKey(name: 'certified_hours') @Default(0) num certifiedHours,
    @JsonKey(name: 'pending_hours') @Default(0) num pendingHours,
    @JsonKey(name: 'certified_drives') @Default(0) int certifiedDrives,
    @Default([]) List<PassportRow> attendance,
    @Default([]) List<PassportPledge> pledges,
  }) = _Passport;
  factory Passport.fromJson(Map<String, dynamic> json) => _$PassportFromJson(json);
}

@freezed
abstract class UpcomingDrive with _$UpcomingDrive {
  const factory UpcomingDrive({
    required String id,
    required String title,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    String? venue,
    String? city,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'default_hours') required num defaultHours,
    required String status,
  }) = _UpcomingDrive;
  factory UpcomingDrive.fromJson(Map<String, dynamic> json) => _$UpcomingDriveFromJson(json);
}

@freezed
abstract class Certificate with _$Certificate {
  const Certificate._();
  const factory Certificate({
    @Default(false) bool found,
    @Default(false) bool valid,
    String? code,
    String? kind,
    @JsonKey(name: 'subject_name') String? subjectName,
    @JsonKey(name: 'org_name') String? orgName,
    String? title,
    num? hours,
    @JsonKey(name: 'issued_at') DateTime? issuedAt,
    @JsonKey(name: 'revoked_reason') String? revokedReason,
  }) = _Certificate;
  factory Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);

  bool get isPledge => kind == 'pledge';
}

@freezed
abstract class RosterRow with _$RosterRow {
  const RosterRow._();
  const factory RosterRow({
    @JsonKey(name: 'attendance_id') required String attendanceId,
    @JsonKey(name: 'subject_kind') required String subjectKind,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'class_section') String? classSection,
    @JsonKey(name: 'roll_no') String? rollNo,
    @JsonKey(name: 'school_name') String? schoolName,
    required String method,
    required String status,
    @JsonKey(name: 'check_in_at') required DateTime checkInAt,
    required num hours,
    @JsonKey(name: 'certified_at') DateTime? certifiedAt,
  }) = _RosterRow;
  factory RosterRow.fromJson(Map<String, dynamic> json) => _$RosterRowFromJson(json);

  bool get isStudent => subjectKind == 'student';
  bool get isPending => status == 'pending';
  bool get isCertified => status == 'certified';
}

@freezed
abstract class OrgDrive with _$OrgDrive {
  const OrgDrive._();
  const factory OrgDrive({
    required String id,
    required String title,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    required String status,
    String? city,
    String? venue,
    String? cause,
    @JsonKey(name: 'default_hours') required num defaultHours,
    required int capacity,
    @Default(0) int registrations,
    @JsonKey(name: 'checked_in') @Default(0) int checkedIn,
    @Default(0) int pending,
    @Default(0) int certified,
  }) = _OrgDrive;
  factory OrgDrive.fromJson(Map<String, dynamic> json) => _$OrgDriveFromJson(json);

  bool get isCancelled => status == 'cancelled';
  bool get isToday {
    final n = DateTime.now();
    final s = startsAt.toLocal();
    return s.year == n.year && s.month == n.month && s.day == n.day;
  }

  bool get isPast => endsAt.isBefore(DateTime.now());
}

@freezed
abstract class Student with _$Student {
  const factory Student({
    @JsonKey(name: 'student_id') required String studentId,
    @JsonKey(name: 'full_name') required String fullName,
    required String kind,
    @JsonKey(name: 'class_section') String? classSection,
    @JsonKey(name: 'roll_no') String? rollNo,
    String? email,
    String? phone,
    @JsonKey(name: 'claim_code') required String claimCode,
    @Default(false) bool claimed,
    @JsonKey(name: 'certified_hours') @Default(0) num certifiedHours,
    @JsonKey(name: 'pending_hours') @Default(0) num pendingHours,
  }) = _Student;
  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
}

@freezed
abstract class EnrolResult with _$EnrolResult {
  const factory EnrolResult({
    @JsonKey(name: 'student_id') required String studentId,
    @JsonKey(name: 'claim_code') required String claimCode,
    required String kind,
    @Default(false) bool linked,
  }) = _EnrolResult;
  factory EnrolResult.fromJson(Map<String, dynamic> json) => _$EnrolResultFromJson(json);
}

@freezed
abstract class OrgPublic with _$OrgPublic {
  const OrgPublic._();
  const factory OrgPublic({
    required String id,
    required String name,
    required String type,
    String? city,
    String? about,
    @JsonKey(name: 'verification_tier') @Default(0) int verificationTier,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'drives_run') @Default(0) int drivesRun,
    @JsonKey(name: 'certified_hours') @Default(0) num certifiedHours,
    @Default([]) List<UpcomingDrive> upcoming,
  }) = _OrgPublic;
  factory OrgPublic.fromJson(Map<String, dynamic> json) => _$OrgPublicFromJson(json);
  bool get isVerified => verificationTier >= 2;
}

@freezed
abstract class OrgMember with _$OrgMember {
  const factory OrgMember({
    @JsonKey(name: 'user_id') required String userId,
    String? name,
    String? email,
    required String role,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
  }) = _OrgMember;
  factory OrgMember.fromJson(Map<String, dynamic> json) => _$OrgMemberFromJson(json);
}

@freezed
abstract class OrgInvite with _$OrgInvite {
  const factory OrgInvite({
    required String email,
    required String role,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _OrgInvite;
  factory OrgInvite.fromJson(Map<String, dynamic> json) => _$OrgInviteFromJson(json);
}

@freezed
abstract class MySignature with _$MySignature {
  const factory MySignature({
    @JsonKey(name: 'signature_no') required int signatureNo,
    @JsonKey(name: 'signed_at') required DateTime signedAt,
    @JsonKey(name: 'certificate_code') String? certificateCode,
  }) = _MySignature;
  factory MySignature.fromJson(Map<String, dynamic> json) => _$MySignatureFromJson(json);
}

@freezed
abstract class PledgeDetail with _$PledgeDetail {
  const PledgeDetail._();
  const factory PledgeDetail({
    required String id,
    @JsonKey(name: 'org_id') required String orgId,
    @JsonKey(name: 'org_name') required String orgName,
    @JsonKey(name: 'org_verified') @Default(false) bool orgVerified,
    required String title,
    String? campaign,
    required String body,
    required String status,
    @JsonKey(name: 'share_code') required String shareCode,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(0) int signatures,
    @JsonKey(name: 'can_manage') @Default(false) bool canManage,
    @JsonKey(name: 'my_signature') MySignature? mySignature,
  }) = _PledgeDetail;
  factory PledgeDetail.fromJson(Map<String, dynamic> json) => _$PledgeDetailFromJson(json);
  bool get isActive => status == 'active';
}

@freezed
abstract class SignResult with _$SignResult {
  const factory SignResult({
    @JsonKey(name: 'pledge_id') required String pledgeId,
    @JsonKey(name: 'pledge_title') required String pledgeTitle,
    @JsonKey(name: 'signature_no') required int signatureNo,
    @JsonKey(name: 'signed_at') required DateTime signedAt,
    @JsonKey(name: 'certificate_code') String? certificateCode,
    @Default(false) bool already,
  }) = _SignResult;
  factory SignResult.fromJson(Map<String, dynamic> json) => _$SignResultFromJson(json);
}

@freezed
abstract class OrgPledge with _$OrgPledge {
  const OrgPledge._();
  const factory OrgPledge({
    required String id,
    required String title,
    String? campaign,
    required String body,
    @JsonKey(name: 'share_code') required String shareCode,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(0) int signatures,
  }) = _OrgPledge;
  factory OrgPledge.fromJson(Map<String, dynamic> json) => _$OrgPledgeFromJson(json);
  bool get isActive => status == 'active';
}

@freezed
abstract class Signer with _$Signer {
  const factory Signer({
    required String name,
    @JsonKey(name: 'signature_no') required int signatureNo,
    @JsonKey(name: 'signed_at') required DateTime signedAt,
  }) = _Signer;
  factory Signer.fromJson(Map<String, dynamic> json) => _$SignerFromJson(json);
}

@freezed
abstract class ClaimResult with _$ClaimResult {
  const factory ClaimResult({
    @JsonKey(name: 'student_name') required String studentName,
    @JsonKey(name: 'records_claimed') @Default(0) int recordsClaimed,
  }) = _ClaimResult;
  factory ClaimResult.fromJson(Map<String, dynamic> json) => _$ClaimResultFromJson(json);
}
