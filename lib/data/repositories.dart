import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/data/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'repositories.g.dart';

/// Thin, typed wrappers over the server functions. One method per RPC; the
/// names match db/migrations so the contract is greppable. Every call is
/// wrapped in [guard] so callers only ever see [SoiError].
///
/// No repository writes to a table directly. That is a property of the
/// database (no client write policies), not just a convention here.

@Riverpod(keepAlive: true)
SupabaseClient supabase(Ref ref) => Supabase.instance.client;

List<Map<String, dynamic>> _rows(dynamic data) =>
    (data as List<dynamic>).cast<Map<String, dynamic>>();

Map<String, dynamic> _obj(dynamic data) => data as Map<String, dynamic>;

// ---------------------------------------------------------------- drives

class DrivesRepo {
  DrivesRepo(this._db);
  final SupabaseClient _db;

  static const pageSize = 20;

  Future<List<DriveSummary>> discover({
    String? query,
    String? cause,
    String? city,
    String sort = 'soonest',
    int offset = 0,
  }) =>
      guard(() async {
        final data = await _db.rpc<dynamic>('discover_drives', params: {
          'p_query': query,
          'p_cause': cause,
          'p_city': city,
          'p_sort': sort,
          'p_limit': pageSize,
          'p_offset': offset,
        });
        return _rows(data).map(DriveSummary.fromJson).toList();
      });

  Future<Facets> facets() => guard(() async =>
      Facets.fromJson(_obj(await _db.rpc<dynamic>('discover_facets'))));

  Future<DriveDetail> detail(String id) => guard(() async =>
      DriveDetail.fromJson(_obj(await _db.rpc<dynamic>('drive_detail', params: {'p_drive': id}))));

  Future<int> register(String id) => guard(() async =>
      _obj(await _db.rpc<dynamic>('register_for_drive', params: {'p_drive': id}))['spots_left'] as int);

  Future<int> cancelRegistration(String id) => guard(() async =>
      _obj(await _db.rpc<dynamic>('cancel_registration', params: {'p_drive': id}))['spots_left'] as int);

  Future<List<UpcomingDrive>> myUpcoming() => guard(() async =>
      _rows(await _db.rpc<dynamic>('my_upcoming_drives')).map(UpcomingDrive.fromJson).toList());

  Future<CheckInResult> checkIn(String driveId, String code) => guard(() async =>
      CheckInResult.fromJson(_obj(await _db.rpc<dynamic>('check_in', params: {'p_drive': driveId, 'p_code': code}))));

  Future<String> create({
    required String orgId,
    required String title,
    required DateTime starts,
    required DateTime ends,
    String? description,
    String? cause,
    String? venue,
    String? city,
    required int capacity,
    required num hours,
  }) =>
      guard(() async => _obj(await _db.rpc<dynamic>('create_drive', params: {
            'p_org': orgId,
            'p_title': title,
            'p_starts': starts.toUtc().toIso8601String(),
            'p_ends': ends.toUtc().toIso8601String(),
            'p_description': description,
            'p_cause': cause,
            'p_venue': venue,
            'p_city': city,
            'p_capacity': capacity,
            'p_hours': hours,
          }))['id'] as String);

  Future<void> update({
    required String id,
    required String title,
    required DateTime starts,
    required DateTime ends,
    String? description,
    String? cause,
    String? venue,
    String? city,
    required int capacity,
    required num hours,
  }) =>
      guard(() => _db.rpc<dynamic>('update_drive', params: {
            'p_drive': id,
            'p_title': title,
            'p_starts': starts.toUtc().toIso8601String(),
            'p_ends': ends.toUtc().toIso8601String(),
            'p_description': description,
            'p_cause': cause,
            'p_venue': venue,
            'p_city': city,
            'p_capacity': capacity,
            'p_hours': hours,
          }));

  Future<void> cancel(String id) => guard(() => _db.rpc<dynamic>('cancel_drive', params: {'p_drive': id}));

  Future<String> checkinCode(String id) =>
      guard(() async => await _db.rpc<dynamic>('get_checkin_code', params: {'p_drive': id}) as String);

  Future<String> rotateCode(String id) =>
      guard(() async => await _db.rpc<dynamic>('rotate_checkin_code', params: {'p_drive': id}) as String);

  Future<List<OrgDrive>> orgDrives(String orgId) => guard(() async =>
      _rows(await _db.rpc<dynamic>('org_drives', params: {'p_org': orgId})).map(OrgDrive.fromJson).toList());

  Future<List<RosterRow>> roster(String driveId) => guard(() async =>
      _rows(await _db.rpc<dynamic>('roster', params: {'p_drive': driveId})).map(RosterRow.fromJson).toList());

  Future<int> certify(List<String> ids) =>
      guard(() async => await _db.rpc<dynamic>('certify_attendance', params: {'p_ids': ids}) as int);

  Future<int> reject(List<String> ids) =>
      guard(() async => await _db.rpc<dynamic>('reject_attendance', params: {'p_ids': ids}) as int);

  Future<int> markStudents(String driveId, List<String> studentIds) => guard(() async =>
      await _db.rpc<dynamic>('mark_students_present', params: {'p_drive': driveId, 'p_students': studentIds}) as int);

  /// Ids of the caller's own students already marked at this drive.
  Future<Set<String>> markedStudents(String driveId) => guard(() async =>
      (await _db.rpc<dynamic>('drive_marked_students', params: {'p_drive': driveId}) as List<dynamic>).cast<String>().toSet());

  /// Live attendance changes for one drive. The payload carries attendance
  /// columns only (no names); callers re-fetch [roster] for inserts.
  RealtimeChannel subscribeAttendance(
    String driveId, {
    required void Function(PostgresChangePayload payload) onChange,
    required void Function(RealtimeSubscribeStatus status) onStatus,
  }) {
    return _db
        .channel('attendance:$driveId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'attendance',
          filter: PostgresChangeFilter(type: PostgresChangeFilterType.eq, column: 'drive_id', value: driveId),
          callback: onChange,
        )
        .subscribe((status, [_]) => onStatus(status));
  }

  Future<void> unsubscribe(RealtimeChannel channel) => _db.removeChannel(channel);
}

@Riverpod(keepAlive: true)
DrivesRepo drivesRepo(Ref ref) => DrivesRepo(ref.watch(supabaseProvider));

// ---------------------------------------------------------------- organisations

class OrgsRepo {
  OrgsRepo(this._db);
  final SupabaseClient _db;

  Future<String> create({required String name, required String type, String? about, String? city}) =>
      guard(() async => _obj(await _db.rpc<dynamic>('create_organisation', params: {
            'p_name': name, 'p_type': type, 'p_about': about, 'p_city': city,
          }))['id'] as String);

  Future<void> update({required String orgId, required String name, String? about, String? city}) =>
      guard(() => _db.rpc<dynamic>('update_organisation', params: {
            'p_org': orgId, 'p_name': name, 'p_about': about, 'p_city': city,
          }));

  Future<OrgPublic> publicProfile(String orgId) => guard(() async =>
      OrgPublic.fromJson(_obj(await _db.rpc<dynamic>('organisation_public', params: {'p_org': orgId}))));

  Future<void> invite({required String orgId, required String email, required String role}) =>
      guard(() => _db.rpc<dynamic>('invite_org_member', params: {'p_org': orgId, 'p_email': email, 'p_role': role}));

  Future<void> cancelInvite({required String orgId, required String email}) =>
      guard(() => _db.rpc<dynamic>('cancel_invite', params: {'p_org': orgId, 'p_email': email}));

  Future<void> removeMember({required String orgId, required String userId}) =>
      guard(() => _db.rpc<dynamic>('remove_org_member', params: {'p_org': orgId, 'p_user': userId}));

  Future<void> leave(String orgId) => guard(() => _db.rpc<dynamic>('leave_org', params: {'p_org': orgId}));

  Future<List<OrgMember>> members(String orgId) => guard(() async =>
      _rows(await _db.rpc<dynamic>('org_members_list', params: {'p_org': orgId})).map(OrgMember.fromJson).toList());

  Future<List<OrgInvite>> invites(String orgId) => guard(() async =>
      _rows(await _db.rpc<dynamic>('org_invites_list', params: {'p_org': orgId})).map(OrgInvite.fromJson).toList());

  Future<List<Student>> roster(String orgId) => guard(() async =>
      _rows(await _db.rpc<dynamic>('org_roster', params: {'p_org': orgId})).map(Student.fromJson).toList());

  Future<EnrolResult> enrol({
    required String orgId,
    required String name,
    required String kind,
    String? classSection,
    String? rollNo,
    String? email,
    String? phone,
  }) =>
      guard(() async => EnrolResult.fromJson(_obj(await _db.rpc<dynamic>('enrol_participant', params: {
            'p_org': orgId, 'p_name': name, 'p_kind': kind, 'p_class': classSection,
            'p_roll': rollNo, 'p_email': email, 'p_phone': phone,
          }))));

  Future<void> updateStudent({
    required String studentId,
    required String name,
    String? classSection,
    String? rollNo,
    String? email,
    String? phone,
  }) =>
      guard(() => _db.rpc<dynamic>('update_student', params: {
            'p_student': studentId, 'p_name': name, 'p_class': classSection,
            'p_roll': rollNo, 'p_email': email, 'p_phone': phone,
          }));

  Future<void> removeStudent(String studentId) =>
      guard(() => _db.rpc<dynamic>('remove_student', params: {'p_student': studentId}));
}

@Riverpod(keepAlive: true)
OrgsRepo orgsRepo(Ref ref) => OrgsRepo(ref.watch(supabaseProvider));

// ---------------------------------------------------------------- pledges

class PledgesRepo {
  PledgesRepo(this._db);
  final SupabaseClient _db;

  Future<PledgeDetail> detail(String shareCode) => guard(() async =>
      PledgeDetail.fromJson(_obj(await _db.rpc<dynamic>('pledge_detail', params: {'p_share_code': shareCode}))));

  Future<SignResult> sign(String shareCode) => guard(() async =>
      SignResult.fromJson(_obj(await _db.rpc<dynamic>('sign_pledge', params: {'p_share_code': shareCode}))));

  Future<({String id, String shareCode})> create({
    required String orgId,
    required String title,
    required String body,
    String? campaign,
  }) =>
      guard(() async {
        final r = _obj(await _db.rpc<dynamic>('create_pledge', params: {
          'p_org': orgId, 'p_title': title, 'p_body': body, 'p_campaign': campaign,
        }));
        return (id: r['id'] as String, shareCode: r['share_code'] as String);
      });

  Future<void> update({required String id, required String title, required String body, String? campaign}) =>
      guard(() => _db.rpc<dynamic>('update_pledge', params: {
            'p_id': id, 'p_title': title, 'p_body': body, 'p_campaign': campaign,
          }));

  Future<void> setStatus(String id, String status) =>
      guard(() => _db.rpc<dynamic>('set_pledge_status', params: {'p_id': id, 'p_status': status}));

  Future<void> delete(String id) => guard(() => _db.rpc<dynamic>('delete_pledge', params: {'p_id': id}));

  Future<List<Signer>> signers(String id) => guard(() async =>
      _rows(await _db.rpc<dynamic>('pledge_signers', params: {'p_id': id})).map(Signer.fromJson).toList());

  Future<List<OrgPledge>> orgPledges(String orgId) => guard(() async =>
      _rows(await _db.rpc<dynamic>('org_pledges', params: {'p_org': orgId})).map(OrgPledge.fromJson).toList());
}

@Riverpod(keepAlive: true)
PledgesRepo pledgesRepo(Ref ref) => PledgesRepo(ref.watch(supabaseProvider));

// ---------------------------------------------------------------- account

class AccountRepo {
  AccountRepo(this._db);
  final SupabaseClient _db;

  Future<Profile> myProfile() =>
      guard(() async => Profile.fromJson(_obj(await _db.rpc<dynamic>('my_profile'))));

  Future<List<Membership>> myMemberships() => guard(() async =>
      _rows(await _db.rpc<dynamic>('my_memberships')).map(Membership.fromJson).toList());

  Future<int> setMyName(String name) => guard(() async =>
      _obj(await _db.rpc<dynamic>('set_my_name', params: {'p_name': name}))['certificates_updated'] as int);

  Future<void> deleteMyAccount() => guard(() => _db.rpc<dynamic>('delete_my_account'));

  Future<ClaimResult> claim(String code) => guard(() async =>
      ClaimResult.fromJson(_obj(await _db.rpc<dynamic>('claim_student_record', params: {'p_claim_code': code}))));

  Future<Passport> passport() =>
      guard(() async => Passport.fromJson(_obj(await _db.rpc<dynamic>('my_passport'))));

  Future<Certificate> verifyCertificate(String code) => guard(() async =>
      Certificate.fromJson(_obj(await _db.rpc<dynamic>('verify_certificate', params: {'p_code': code}))));

  Future<void> revokeCertificate(String code, String reason) =>
      guard(() => _db.rpc<dynamic>('revoke_certificate', params: {'p_code': code, 'p_reason': reason}));

  Future<Stats> stats() => guard(() async => Stats.fromJson(_obj(await _db.rpc<dynamic>('soi_stats'))));

  Future<void> report({required String targetType, required String targetId, required String reason}) =>
      guard(() => _db.rpc<dynamic>('report_content', params: {
            'p_target_type': targetType, 'p_target_id': targetId, 'p_reason': reason,
          }));
}

@Riverpod(keepAlive: true)
AccountRepo accountRepo(Ref ref) => AccountRepo(ref.watch(supabaseProvider));

// ---------------------------------------------------------------- auth

class AuthRepo {
  AuthRepo(this._db);
  final SupabaseClient _db;

  Session? get session => _db.auth.currentSession;
  User? get user => _db.auth.currentUser;
  Stream<AuthState> get changes => _db.auth.onAuthStateChange;

  /// Sends a numeric one-time code by email. Creates the account on first use.
  Future<void> sendCode(String email) =>
      guard(() => _db.auth.signInWithOtp(email: email, shouldCreateUser: true));

  Future<void> verifyCode(String email, String token) =>
      guard(() => _db.auth.verifyOTP(email: email, token: token, type: OtpType.email));

  /// Password path: exists for the store-review account, which cannot
  /// receive email.
  Future<void> signInWithPassword(String email, String password) =>
      guard(() => _db.auth.signInWithPassword(email: email, password: password));

  Future<void> signOut() => guard(() => _db.auth.signOut());
}

@Riverpod(keepAlive: true)
AuthRepo authRepo(Ref ref) => AuthRepo(ref.watch(supabaseProvider));
