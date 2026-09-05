import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/snapshots.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session.g.dart';

/// Who is signed in, what we know about them, and what they may do.
///
/// The router's redirect reads this synchronously, so it must never be in a
/// "loading" shape after bootstrap: [SessionController.bootstrap] is awaited
/// in main() before the first frame, with a timeout that falls back to the
/// last persisted snapshot.
@immutable
class SessionState {
  const SessionState({
    this.session,
    this.profile,
    this.memberships = const [],
    this.intentSeen = false,
    this.welcomeSeen = false,
  });

  final Session? session;
  final Profile? profile;
  final List<Membership> memberships;

  /// Whether this user has been through the first-run intent step.
  final bool intentSeen;

  /// Whether the public welcome screen has been shown on this device.
  final bool welcomeSeen;

  bool get isSignedIn => session != null;
  String? get userId => session?.user.id;
  String? get email => session?.user.email;
  bool get needsName => isSignedIn && (profile == null || profile!.needsName);
  bool get needsIntent => isSignedIn && !needsName && !intentSeen;
  bool get isCoordinator => memberships.any((m) => m.isCoordinator);
  List<Membership> get coordinated => memberships.where((m) => m.isCoordinator).toList();
  List<Membership> get administered => memberships.where((m) => m.isAdmin).toList();
  String get displayName => profile?.fullName?.trim().isNotEmpty == true ? profile!.fullName! : (email ?? '');

  SessionState copyWith({
    Session? session,
    bool clearSession = false,
    Profile? profile,
    bool clearProfile = false,
    List<Membership>? memberships,
    bool? intentSeen,
    bool? welcomeSeen,
  }) {
    return SessionState(
      session: clearSession ? null : (session ?? this.session),
      profile: clearProfile ? null : (profile ?? this.profile),
      memberships: memberships ?? this.memberships,
      intentSeen: intentSeen ?? this.intentSeen,
      welcomeSeen: welcomeSeen ?? this.welcomeSeen,
    );
  }
}

@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  StreamSubscription<AuthState>? _sub;

  @override
  SessionState build() {
    final auth = ref.watch(authRepoProvider);
    _sub?.cancel();
    _sub = auth.changes.listen(_onAuthChange);
    ref.onDispose(() => _sub?.cancel());
    final snaps = ref.watch(snapshotsProvider);
    return SessionState(
      session: auth.session,
      welcomeSeen: snaps.welcomeSeen,
      intentSeen: auth.user != null && snaps.intentSeen(auth.user!.id),
    );
  }

  /// Loads profile + memberships for the current session. Called once at
  /// startup (with a timeout) and after sign-in.
  Future<void> bootstrap({Duration timeout = const Duration(seconds: 3)}) async {
    final auth = ref.read(authRepoProvider);
    if (auth.session == null) return;
    try {
      await refresh().timeout(timeout);
    } catch (_) {
      // Offline or slow: fall back to the last snapshot so the router can
      // still decide. Screens re-fetch on their own.
      final snaps = ref.read(snapshotsProvider);
      final uid = auth.user!.id;
      state = state.copyWith(
        profile: snaps.profile(uid),
        memberships: snaps.memberships(uid),
      );
    }
  }

  Future<void> refresh() async {
    final auth = ref.read(authRepoProvider);
    if (auth.session == null) {
      state = const SessionState().copyWith(welcomeSeen: state.welcomeSeen);
      return;
    }
    final account = ref.read(accountRepoProvider);
    final results = await Future.wait([account.myProfile(), account.myMemberships()]);
    final profile = results[0] as Profile;
    final memberships = results[1] as List<Membership>;
    final uid = auth.user!.id;
    final snaps = ref.read(snapshotsProvider);
    await snaps.saveProfile(uid, profile);
    await snaps.saveMemberships(uid, memberships);
    state = state.copyWith(
      session: auth.session,
      profile: profile,
      memberships: memberships,
      intentSeen: snaps.intentSeen(uid),
    );
  }

  Future<void> refreshMemberships() async {
    final auth = ref.read(authRepoProvider);
    if (auth.session == null) return;
    final memberships = await ref.read(accountRepoProvider).myMemberships();
    await ref.read(snapshotsProvider).saveMemberships(auth.user!.id, memberships);
    state = state.copyWith(memberships: memberships);
  }

  Future<void> markIntentSeen() async {
    final uid = state.userId;
    if (uid == null) return;
    await ref.read(snapshotsProvider).setIntentSeen(uid);
    state = state.copyWith(intentSeen: true);
  }

  Future<void> markWelcomeSeen() async {
    await ref.read(snapshotsProvider).setWelcomeSeen();
    state = state.copyWith(welcomeSeen: true);
  }

  void setProfileName(String name) {
    final p = state.profile;
    state = state.copyWith(
      profile: (p ?? Profile(id: state.userId ?? '')).copyWith(fullName: name, needsName: false),
    );
  }

  Future<void> _onAuthChange(AuthState change) async {
    switch (change.event) {
      case AuthChangeEvent.signedIn:
      case AuthChangeEvent.initialSession:
      case AuthChangeEvent.userUpdated:
        if (change.session != null) {
          state = state.copyWith(session: change.session);
          try {
            await refresh();
          } catch (_) {
            // Screens surface their own errors; the session itself is valid.
          }
        }
      case AuthChangeEvent.signedOut:
        final snaps = ref.read(snapshotsProvider);
        await snaps.clearUserData();
        state = SessionState(welcomeSeen: state.welcomeSeen);
      case AuthChangeEvent.tokenRefreshed:
        if (change.session != null) state = state.copyWith(session: change.session);
      case AuthChangeEvent.passwordRecovery:
      case AuthChangeEvent.mfaChallengeVerified:
      // The SDK still emits this event for older servers; handled as a no-op.
      // ignore: deprecated_member_use
      case AuthChangeEvent.userDeleted:
        break;
    }
  }
}
