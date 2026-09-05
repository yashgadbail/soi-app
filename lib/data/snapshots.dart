import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soi/data/models.dart';

part 'snapshots.g.dart';

/// Small on-device cache so cold starts paint instantly and the router can
/// decide while offline. Holds only lean lists the user already saw; never
/// anything another user's privacy depends on, and cleared on sign-out.
class Snapshots {
  Snapshots(this._prefs);
  final SharedPreferencesWithCache _prefs;

  static const _welcome = 'welcome_seen';
  static String _intent(String uid) => 'intent_seen:$uid';
  static String _profile(String uid) => 'profile:$uid';
  static String _memberships(String uid) => 'memberships:$uid';
  static String _passport(String uid) => 'passport:$uid';
  static const _discover = 'discover_first_page';

  bool get welcomeSeen => _prefs.getBool(_welcome) ?? false;
  Future<void> setWelcomeSeen() => _prefs.setBool(_welcome, true);

  bool intentSeen(String uid) => _prefs.getBool(_intent(uid)) ?? false;
  Future<void> setIntentSeen(String uid) => _prefs.setBool(_intent(uid), true);

  Profile? profile(String uid) => _readObj(_profile(uid), Profile.fromJson);
  Future<void> saveProfile(String uid, Profile p) => _prefs.setString(_profile(uid), jsonEncode(p.toJson()));

  List<Membership> memberships(String uid) => _readList(_memberships(uid), Membership.fromJson);
  Future<void> saveMemberships(String uid, List<Membership> m) =>
      _prefs.setString(_memberships(uid), jsonEncode(m.map((e) => e.toJson()).toList()));

  Passport? passport(String uid) => _readObj(_passport(uid), Passport.fromJson);
  Future<void> savePassport(String uid, Passport p) => _prefs.setString(_passport(uid), jsonEncode(p.toJson()));

  List<DriveSummary> discoverFirstPage() => _readList(_discover, DriveSummary.fromJson);
  Future<void> saveDiscoverFirstPage(List<DriveSummary> rows) =>
      _prefs.setString(_discover, jsonEncode(rows.map((e) => e.toJson()).toList()));

  Future<void> clearUserData() async {
    for (final k in _prefs.keys) {
      if (k.startsWith('profile:') ||
          k.startsWith('memberships:') ||
          k.startsWith('passport:') ||
          k == _discover) {
        await _prefs.remove(k);
      }
    }
  }

  T? _readObj<T>(String key, T Function(Map<String, dynamic>) from) {
    try {
      final s = _prefs.getString(key);
      if (s == null) return null;
      return from(jsonDecode(s) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  List<T> _readList<T>(String key, T Function(Map<String, dynamic>) from) {
    try {
      final s = _prefs.getString(key);
      if (s == null) return const [];
      return (jsonDecode(s) as List<dynamic>).cast<Map<String, dynamic>>().map(from).toList();
    } catch (_) {
      return const [];
    }
  }
}

/// Overridden in main() with the real instance.
@Riverpod(keepAlive: true)
Snapshots snapshots(Ref ref) => throw UnimplementedError('snapshotsProvider must be overridden');
