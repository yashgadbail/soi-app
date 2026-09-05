import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';

part 'manage_providers.g.dart';

/// Which organisation the Manage tab is acting for. Defaults to the first
/// organisation the user coordinates; persists across screens.
@Riverpod(keepAlive: true)
class SelectedOrg extends _$SelectedOrg {
  @override
  String? build() => null;

  // ignore: use_setters_to_change_properties -- Riverpod notifiers expose methods, not setters.
  void choose(String orgId) => state = orgId;
}

/// The effective organisation for coordinator screens (selected or first).
@riverpod
Membership? currentOrg(Ref ref) {
  final coordinated = ref.watch<List<Membership>>(sessionControllerProvider.select((s) => s.coordinated));
  if (coordinated.isEmpty) return null;
  final selected = ref.watch(selectedOrgProvider);
  return coordinated.firstWhere((m) => m.orgId == selected, orElse: () => coordinated.first);
}

@riverpod
Future<List<OrgDrive>> orgDrives(Ref ref, String orgId) => ref.watch(drivesRepoProvider).orgDrives(orgId);

@riverpod
Future<List<Student>> orgRoster(Ref ref, String orgId) => ref.watch(orgsRepoProvider).roster(orgId);

@riverpod
Future<List<OrgPledge>> orgPledges(Ref ref, String orgId) => ref.watch(pledgesRepoProvider).orgPledges(orgId);

@riverpod
Future<List<OrgMember>> orgMembers(Ref ref, String orgId) => ref.watch(orgsRepoProvider).members(orgId);

@riverpod
Future<List<OrgInvite>> orgInvites(Ref ref, String orgId) => ref.watch(orgsRepoProvider).invites(orgId);

/// The causes offered as chips when publishing. Free text is also allowed.
const kCauses = ['Environment', 'Education', 'Health', 'Community', 'Animal welfare', 'Disaster relief'];
