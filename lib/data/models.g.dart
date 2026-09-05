// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  email: json['email'] as String?,
  fullName: json['full_name'] as String?,
  city: json['city'] as String?,
  needsName: json['needs_name'] as bool? ?? true,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'full_name': instance.fullName,
  'city': instance.city,
  'needs_name': instance.needsName,
};

_Membership _$MembershipFromJson(Map<String, dynamic> json) => _Membership(
  orgId: json['org_id'] as String,
  orgName: json['org_name'] as String,
  orgType: json['org_type'] as String,
  verificationTier: (json['verification_tier'] as num?)?.toInt() ?? 0,
  role: json['role'] as String,
  city: json['city'] as String?,
);

Map<String, dynamic> _$MembershipToJson(_Membership instance) =>
    <String, dynamic>{
      'org_id': instance.orgId,
      'org_name': instance.orgName,
      'org_type': instance.orgType,
      'verification_tier': instance.verificationTier,
      'role': instance.role,
      'city': instance.city,
    };

_DriveSummary _$DriveSummaryFromJson(Map<String, dynamic> json) =>
    _DriveSummary(
      id: json['id'] as String,
      title: json['title'] as String,
      cause: json['cause'] as String?,
      venue: json['venue'] as String?,
      city: json['city'] as String?,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
      defaultHours: json['default_hours'] as num,
      capacity: (json['capacity'] as num).toInt(),
      spotsLeft: (json['spots_left'] as num?)?.toInt() ?? 0,
      orgId: json['org_id'] as String,
      orgName: json['org_name'] as String,
      orgVerified: json['org_verified'] as bool? ?? false,
      registered: json['registered'] as bool? ?? false,
    );

Map<String, dynamic> _$DriveSummaryToJson(_DriveSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cause': instance.cause,
      'venue': instance.venue,
      'city': instance.city,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
      'default_hours': instance.defaultHours,
      'capacity': instance.capacity,
      'spots_left': instance.spotsLeft,
      'org_id': instance.orgId,
      'org_name': instance.orgName,
      'org_verified': instance.orgVerified,
      'registered': instance.registered,
    };

_OrgRef _$OrgRefFromJson(Map<String, dynamic> json) => _OrgRef(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  city: json['city'] as String?,
  verificationTier: (json['verification_tier'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$OrgRefToJson(_OrgRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
  'city': instance.city,
  'verification_tier': instance.verificationTier,
};

_MyAttendance _$MyAttendanceFromJson(Map<String, dynamic> json) =>
    _MyAttendance(
      status: json['status'] as String,
      hours: json['hours'] as num,
      checkInAt: DateTime.parse(json['check_in_at'] as String),
    );

Map<String, dynamic> _$MyAttendanceToJson(_MyAttendance instance) =>
    <String, dynamic>{
      'status': instance.status,
      'hours': instance.hours,
      'check_in_at': instance.checkInAt.toIso8601String(),
    };

_DriveDetail _$DriveDetailFromJson(Map<String, dynamic> json) => _DriveDetail(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  cause: json['cause'] as String?,
  venue: json['venue'] as String?,
  city: json['city'] as String?,
  startsAt: DateTime.parse(json['starts_at'] as String),
  endsAt: DateTime.parse(json['ends_at'] as String),
  capacity: (json['capacity'] as num).toInt(),
  defaultHours: json['default_hours'] as num,
  status: json['status'] as String,
  spotsLeft: (json['spots_left'] as num?)?.toInt() ?? 0,
  registrations: (json['registrations'] as num?)?.toInt(),
  registered: json['registered'] as bool? ?? false,
  canManage: json['can_manage'] as bool? ?? false,
  myAttendance: json['my_attendance'] == null
      ? null
      : MyAttendance.fromJson(json['my_attendance'] as Map<String, dynamic>),
  org: OrgRef.fromJson(json['org'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DriveDetailToJson(_DriveDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cause': instance.cause,
      'venue': instance.venue,
      'city': instance.city,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
      'capacity': instance.capacity,
      'default_hours': instance.defaultHours,
      'status': instance.status,
      'spots_left': instance.spotsLeft,
      'registrations': instance.registrations,
      'registered': instance.registered,
      'can_manage': instance.canManage,
      'my_attendance': instance.myAttendance,
      'org': instance.org,
    };

_Facets _$FacetsFromJson(Map<String, dynamic> json) => _Facets(
  causes:
      (json['causes'] as List<dynamic>?)
          ?.map((e) => Facet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  cities:
      (json['cities'] as List<dynamic>?)
          ?.map((e) => Facet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$FacetsToJson(_Facets instance) => <String, dynamic>{
  'causes': instance.causes,
  'cities': instance.cities,
};

_Facet _$FacetFromJson(Map<String, dynamic> json) => _Facet(
  value: json['value'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$FacetToJson(_Facet instance) => <String, dynamic>{
  'value': instance.value,
  'count': instance.count,
};

_Stats _$StatsFromJson(Map<String, dynamic> json) => _Stats(
  organisations: (json['organisations'] as num?)?.toInt() ?? 0,
  drives: (json['drives'] as num?)?.toInt() ?? 0,
  certifiedHours: json['certified_hours'] as num? ?? 0,
  volunteers: (json['volunteers'] as num?)?.toInt() ?? 0,
  pledges: (json['pledges'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$StatsToJson(_Stats instance) => <String, dynamic>{
  'organisations': instance.organisations,
  'drives': instance.drives,
  'certified_hours': instance.certifiedHours,
  'volunteers': instance.volunteers,
  'pledges': instance.pledges,
};

_CheckInResult _$CheckInResultFromJson(Map<String, dynamic> json) =>
    _CheckInResult(
      attendanceId: json['attendance_id'] as String,
      driveTitle: json['drive_title'] as String,
      orgName: json['org_name'] as String,
      hours: json['hours'] as num,
      status: json['status'] as String,
      already: json['already'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckInResultToJson(_CheckInResult instance) =>
    <String, dynamic>{
      'attendance_id': instance.attendanceId,
      'drive_title': instance.driveTitle,
      'org_name': instance.orgName,
      'hours': instance.hours,
      'status': instance.status,
      'already': instance.already,
    };

_PassportRow _$PassportRowFromJson(Map<String, dynamic> json) => _PassportRow(
  attendanceId: json['attendance_id'] as String,
  driveId: json['drive_id'] as String,
  driveTitle: json['drive_title'] as String,
  startsAt: DateTime.parse(json['starts_at'] as String),
  driveStatus: json['drive_status'] as String,
  orgId: json['org_id'] as String,
  orgName: json['org_name'] as String,
  hours: json['hours'] as num,
  status: json['status'] as String,
  method: json['method'] as String,
  checkInAt: DateTime.parse(json['check_in_at'] as String),
  certifiedAt: json['certified_at'] == null
      ? null
      : DateTime.parse(json['certified_at'] as String),
  certificateCode: json['certificate_code'] as String?,
);

Map<String, dynamic> _$PassportRowToJson(_PassportRow instance) =>
    <String, dynamic>{
      'attendance_id': instance.attendanceId,
      'drive_id': instance.driveId,
      'drive_title': instance.driveTitle,
      'starts_at': instance.startsAt.toIso8601String(),
      'drive_status': instance.driveStatus,
      'org_id': instance.orgId,
      'org_name': instance.orgName,
      'hours': instance.hours,
      'status': instance.status,
      'method': instance.method,
      'check_in_at': instance.checkInAt.toIso8601String(),
      'certified_at': instance.certifiedAt?.toIso8601String(),
      'certificate_code': instance.certificateCode,
    };

_PassportPledge _$PassportPledgeFromJson(Map<String, dynamic> json) =>
    _PassportPledge(
      pledgeId: json['pledge_id'] as String,
      title: json['title'] as String,
      campaign: json['campaign'] as String?,
      shareCode: json['share_code'] as String,
      orgName: json['org_name'] as String,
      signatureNo: (json['signature_no'] as num).toInt(),
      signedAt: DateTime.parse(json['signed_at'] as String),
      certificateCode: json['certificate_code'] as String?,
    );

Map<String, dynamic> _$PassportPledgeToJson(_PassportPledge instance) =>
    <String, dynamic>{
      'pledge_id': instance.pledgeId,
      'title': instance.title,
      'campaign': instance.campaign,
      'share_code': instance.shareCode,
      'org_name': instance.orgName,
      'signature_no': instance.signatureNo,
      'signed_at': instance.signedAt.toIso8601String(),
      'certificate_code': instance.certificateCode,
    };

_Passport _$PassportFromJson(Map<String, dynamic> json) => _Passport(
  certifiedHours: json['certified_hours'] as num? ?? 0,
  pendingHours: json['pending_hours'] as num? ?? 0,
  certifiedDrives: (json['certified_drives'] as num?)?.toInt() ?? 0,
  attendance:
      (json['attendance'] as List<dynamic>?)
          ?.map((e) => PassportRow.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pledges:
      (json['pledges'] as List<dynamic>?)
          ?.map((e) => PassportPledge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PassportToJson(_Passport instance) => <String, dynamic>{
  'certified_hours': instance.certifiedHours,
  'pending_hours': instance.pendingHours,
  'certified_drives': instance.certifiedDrives,
  'attendance': instance.attendance,
  'pledges': instance.pledges,
};

_UpcomingDrive _$UpcomingDriveFromJson(Map<String, dynamic> json) =>
    _UpcomingDrive(
      id: json['id'] as String,
      title: json['title'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
      venue: json['venue'] as String?,
      city: json['city'] as String?,
      orgName: json['org_name'] as String,
      defaultHours: json['default_hours'] as num,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpcomingDriveToJson(_UpcomingDrive instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
      'venue': instance.venue,
      'city': instance.city,
      'org_name': instance.orgName,
      'default_hours': instance.defaultHours,
      'status': instance.status,
    };

_Certificate _$CertificateFromJson(Map<String, dynamic> json) => _Certificate(
  found: json['found'] as bool? ?? false,
  valid: json['valid'] as bool? ?? false,
  code: json['code'] as String?,
  kind: json['kind'] as String?,
  subjectName: json['subject_name'] as String?,
  orgName: json['org_name'] as String?,
  title: json['title'] as String?,
  hours: json['hours'] as num?,
  issuedAt: json['issued_at'] == null
      ? null
      : DateTime.parse(json['issued_at'] as String),
  revokedReason: json['revoked_reason'] as String?,
);

Map<String, dynamic> _$CertificateToJson(_Certificate instance) =>
    <String, dynamic>{
      'found': instance.found,
      'valid': instance.valid,
      'code': instance.code,
      'kind': instance.kind,
      'subject_name': instance.subjectName,
      'org_name': instance.orgName,
      'title': instance.title,
      'hours': instance.hours,
      'issued_at': instance.issuedAt?.toIso8601String(),
      'revoked_reason': instance.revokedReason,
    };

_RosterRow _$RosterRowFromJson(Map<String, dynamic> json) => _RosterRow(
  attendanceId: json['attendance_id'] as String,
  subjectKind: json['subject_kind'] as String,
  displayName: json['display_name'] as String,
  classSection: json['class_section'] as String?,
  rollNo: json['roll_no'] as String?,
  schoolName: json['school_name'] as String?,
  method: json['method'] as String,
  status: json['status'] as String,
  checkInAt: DateTime.parse(json['check_in_at'] as String),
  hours: json['hours'] as num,
  certifiedAt: json['certified_at'] == null
      ? null
      : DateTime.parse(json['certified_at'] as String),
);

Map<String, dynamic> _$RosterRowToJson(_RosterRow instance) =>
    <String, dynamic>{
      'attendance_id': instance.attendanceId,
      'subject_kind': instance.subjectKind,
      'display_name': instance.displayName,
      'class_section': instance.classSection,
      'roll_no': instance.rollNo,
      'school_name': instance.schoolName,
      'method': instance.method,
      'status': instance.status,
      'check_in_at': instance.checkInAt.toIso8601String(),
      'hours': instance.hours,
      'certified_at': instance.certifiedAt?.toIso8601String(),
    };

_OrgDrive _$OrgDriveFromJson(Map<String, dynamic> json) => _OrgDrive(
  id: json['id'] as String,
  title: json['title'] as String,
  startsAt: DateTime.parse(json['starts_at'] as String),
  endsAt: DateTime.parse(json['ends_at'] as String),
  status: json['status'] as String,
  city: json['city'] as String?,
  venue: json['venue'] as String?,
  cause: json['cause'] as String?,
  defaultHours: json['default_hours'] as num,
  capacity: (json['capacity'] as num).toInt(),
  registrations: (json['registrations'] as num?)?.toInt() ?? 0,
  checkedIn: (json['checked_in'] as num?)?.toInt() ?? 0,
  pending: (json['pending'] as num?)?.toInt() ?? 0,
  certified: (json['certified'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$OrgDriveToJson(_OrgDrive instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'starts_at': instance.startsAt.toIso8601String(),
  'ends_at': instance.endsAt.toIso8601String(),
  'status': instance.status,
  'city': instance.city,
  'venue': instance.venue,
  'cause': instance.cause,
  'default_hours': instance.defaultHours,
  'capacity': instance.capacity,
  'registrations': instance.registrations,
  'checked_in': instance.checkedIn,
  'pending': instance.pending,
  'certified': instance.certified,
};

_Student _$StudentFromJson(Map<String, dynamic> json) => _Student(
  studentId: json['student_id'] as String,
  fullName: json['full_name'] as String,
  kind: json['kind'] as String,
  classSection: json['class_section'] as String?,
  rollNo: json['roll_no'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  claimCode: json['claim_code'] as String,
  claimed: json['claimed'] as bool? ?? false,
  certifiedHours: json['certified_hours'] as num? ?? 0,
  pendingHours: json['pending_hours'] as num? ?? 0,
);

Map<String, dynamic> _$StudentToJson(_Student instance) => <String, dynamic>{
  'student_id': instance.studentId,
  'full_name': instance.fullName,
  'kind': instance.kind,
  'class_section': instance.classSection,
  'roll_no': instance.rollNo,
  'email': instance.email,
  'phone': instance.phone,
  'claim_code': instance.claimCode,
  'claimed': instance.claimed,
  'certified_hours': instance.certifiedHours,
  'pending_hours': instance.pendingHours,
};

_EnrolResult _$EnrolResultFromJson(Map<String, dynamic> json) => _EnrolResult(
  studentId: json['student_id'] as String,
  claimCode: json['claim_code'] as String,
  kind: json['kind'] as String,
  linked: json['linked'] as bool? ?? false,
);

Map<String, dynamic> _$EnrolResultToJson(_EnrolResult instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'claim_code': instance.claimCode,
      'kind': instance.kind,
      'linked': instance.linked,
    };

_OrgPublic _$OrgPublicFromJson(Map<String, dynamic> json) => _OrgPublic(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  city: json['city'] as String?,
  about: json['about'] as String?,
  verificationTier: (json['verification_tier'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['created_at'] as String),
  drivesRun: (json['drives_run'] as num?)?.toInt() ?? 0,
  certifiedHours: json['certified_hours'] as num? ?? 0,
  upcoming:
      (json['upcoming'] as List<dynamic>?)
          ?.map((e) => UpcomingDrive.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OrgPublicToJson(_OrgPublic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'city': instance.city,
      'about': instance.about,
      'verification_tier': instance.verificationTier,
      'created_at': instance.createdAt.toIso8601String(),
      'drives_run': instance.drivesRun,
      'certified_hours': instance.certifiedHours,
      'upcoming': instance.upcoming,
    };

_OrgMember _$OrgMemberFromJson(Map<String, dynamic> json) => _OrgMember(
  userId: json['user_id'] as String,
  name: json['name'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String,
  joinedAt: DateTime.parse(json['joined_at'] as String),
);

Map<String, dynamic> _$OrgMemberToJson(_OrgMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'joined_at': instance.joinedAt.toIso8601String(),
    };

_OrgInvite _$OrgInviteFromJson(Map<String, dynamic> json) => _OrgInvite(
  email: json['email'] as String,
  role: json['role'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$OrgInviteToJson(_OrgInvite instance) =>
    <String, dynamic>{
      'email': instance.email,
      'role': instance.role,
      'created_at': instance.createdAt.toIso8601String(),
    };

_MySignature _$MySignatureFromJson(Map<String, dynamic> json) => _MySignature(
  signatureNo: (json['signature_no'] as num).toInt(),
  signedAt: DateTime.parse(json['signed_at'] as String),
  certificateCode: json['certificate_code'] as String?,
);

Map<String, dynamic> _$MySignatureToJson(_MySignature instance) =>
    <String, dynamic>{
      'signature_no': instance.signatureNo,
      'signed_at': instance.signedAt.toIso8601String(),
      'certificate_code': instance.certificateCode,
    };

_PledgeDetail _$PledgeDetailFromJson(Map<String, dynamic> json) =>
    _PledgeDetail(
      id: json['id'] as String,
      orgId: json['org_id'] as String,
      orgName: json['org_name'] as String,
      orgVerified: json['org_verified'] as bool? ?? false,
      title: json['title'] as String,
      campaign: json['campaign'] as String?,
      body: json['body'] as String,
      status: json['status'] as String,
      shareCode: json['share_code'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      signatures: (json['signatures'] as num?)?.toInt() ?? 0,
      canManage: json['can_manage'] as bool? ?? false,
      mySignature: json['my_signature'] == null
          ? null
          : MySignature.fromJson(json['my_signature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PledgeDetailToJson(_PledgeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'org_id': instance.orgId,
      'org_name': instance.orgName,
      'org_verified': instance.orgVerified,
      'title': instance.title,
      'campaign': instance.campaign,
      'body': instance.body,
      'status': instance.status,
      'share_code': instance.shareCode,
      'created_at': instance.createdAt.toIso8601String(),
      'signatures': instance.signatures,
      'can_manage': instance.canManage,
      'my_signature': instance.mySignature,
    };

_SignResult _$SignResultFromJson(Map<String, dynamic> json) => _SignResult(
  pledgeId: json['pledge_id'] as String,
  pledgeTitle: json['pledge_title'] as String,
  signatureNo: (json['signature_no'] as num).toInt(),
  signedAt: DateTime.parse(json['signed_at'] as String),
  certificateCode: json['certificate_code'] as String?,
  already: json['already'] as bool? ?? false,
);

Map<String, dynamic> _$SignResultToJson(_SignResult instance) =>
    <String, dynamic>{
      'pledge_id': instance.pledgeId,
      'pledge_title': instance.pledgeTitle,
      'signature_no': instance.signatureNo,
      'signed_at': instance.signedAt.toIso8601String(),
      'certificate_code': instance.certificateCode,
      'already': instance.already,
    };

_OrgPledge _$OrgPledgeFromJson(Map<String, dynamic> json) => _OrgPledge(
  id: json['id'] as String,
  title: json['title'] as String,
  campaign: json['campaign'] as String?,
  body: json['body'] as String,
  shareCode: json['share_code'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  signatures: (json['signatures'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$OrgPledgeToJson(_OrgPledge instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'campaign': instance.campaign,
      'body': instance.body,
      'share_code': instance.shareCode,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'signatures': instance.signatures,
    };

_Signer _$SignerFromJson(Map<String, dynamic> json) => _Signer(
  name: json['name'] as String,
  signatureNo: (json['signature_no'] as num).toInt(),
  signedAt: DateTime.parse(json['signed_at'] as String),
);

Map<String, dynamic> _$SignerToJson(_Signer instance) => <String, dynamic>{
  'name': instance.name,
  'signature_no': instance.signatureNo,
  'signed_at': instance.signedAt.toIso8601String(),
};

_ClaimResult _$ClaimResultFromJson(Map<String, dynamic> json) => _ClaimResult(
  studentName: json['student_name'] as String,
  recordsClaimed: (json['records_claimed'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ClaimResultToJson(_ClaimResult instance) =>
    <String, dynamic>{
      'student_name': instance.studentName,
      'records_claimed': instance.recordsClaimed,
    };
