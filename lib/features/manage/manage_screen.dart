import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Coordinator hub: today's drives first, then upcoming, past collapsed;
/// quick actions for publishing, roster, pledges and the organisation.
class ManageScreen extends ConsumerStatefulWidget {
  const ManageScreen({super.key});

  @override
  ConsumerState<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends ConsumerState<ManageScreen> {
  bool _showPast = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final session = ref.watch(sessionControllerProvider);
    final org = ref.watch(currentOrgProvider);

    if (!session.isSignedIn) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(l.manageTitle)),
        body: SignedOutView(onSignIn: () => const SignInRoute(from: '/manage').push<void>(context)),
      );
    }
    if (org == null) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(l.manageTitle)),
        body: EmptyView(
          icon: Icons.corporate_fare_outlined,
          title: l.manageRegisterOrg,
          body: '${l.manageRegisterOrgBody}\n\n${l.onboardIntentInviteHint}',
          action: FilledButton(onPressed: () => const OrgNewRoute().push<void>(context), child: Text(l.orgFormRegister)),
        ),
      );
    }

    final drives = ref.watch(orgDrivesProvider(org.orgId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(l.manageTitle),
        actions: [
          if (session.coordinated.length > 1)
            PopupMenuButton<String>(
              tooltip: l.manageSwitchOrg,
              icon: const Icon(Icons.swap_horiz),
              onSelected: ref.read(selectedOrgProvider.notifier).choose,
              itemBuilder: (_) => [
                for (final m in session.coordinated)
                  CheckedPopupMenuItem(value: m.orgId, checked: m.orgId == org.orgId, child: Text(m.orgName)),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => DriveNewRoute(org: org.orgId).push<void>(context),
        icon: const Icon(Icons.add),
        label: Text(l.managePublish),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(orgDrivesProvider(org.orgId));
          await ref.read(orgDrivesProvider(org.orgId).future);
        },
        child: PageListView(
          extraBottom: 72,
          children: [
            SoiCard(
              onTap: () => OrgSettingsRoute(id: org.orgId).push<void>(context),
              child: Row(
                children: [
                  InitialsAvatar(org.orgName, size: 44, tone: TagTone.saffron),
                  const SizedBox(width: Space.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(org.orgName, style: context.text.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(l.manageLead, style: context.text.bodySmall),
                      ],
                    ),
                  ),
                  if (org.isVerified) Icon(Icons.verified, color: c.greenMid, size: 18, semanticLabel: l.discoverVerified),
                  Icon(Icons.chevron_right_rounded, color: c.muted),
                ],
              ),
            ),
            const SizedBox(height: Space.md),
            Row(
              children: [
                Expanded(child: _Action(icon: Icons.groups_outlined, label: l.manageRoster, onTap: () => RosterRoute(id: org.orgId).push<void>(context))),
                const SizedBox(width: Space.sm),
                Expanded(child: _Action(icon: Icons.handshake_outlined, label: l.managePledges, onTap: () => OrgPledgesRoute(id: org.orgId).push<void>(context))),
                const SizedBox(width: Space.sm),
                Expanded(child: _Action(icon: Icons.settings_outlined, label: l.manageOrganisation, onTap: () => OrgSettingsRoute(id: org.orgId).push<void>(context))),
              ],
            ),
            const SizedBox(height: Space.xl),
            drives.when(
              loading: () => const Padding(padding: EdgeInsets.all(Space.xxl), child: LoadingView()),
              error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(orgDrivesProvider(org.orgId))),
              data: (rows) {
                if (rows.isEmpty) {
                  return EmptyView(icon: Icons.event_outlined, title: l.manageNoDrives, body: l.manageNoDrivesBody);
                }
                final today = rows.where((d) => d.isToday && !d.isCancelled).toList();
                final upcoming = rows.where((d) => !d.isToday && !d.isPast && !d.isCancelled).toList()
                  ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
                final past = rows.where((d) => (d.isPast && !d.isToday) || d.isCancelled).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (today.isNotEmpty) ...[
                      SectionLabel(l.manageToday),
                      for (final d in today) _DriveRow(d: d, highlight: true),
                      const SizedBox(height: Space.md),
                    ],
                    if (upcoming.isNotEmpty) ...[
                      SectionLabel(l.manageUpcoming),
                      for (final d in upcoming) _DriveRow(d: d),
                      const SizedBox(height: Space.md),
                    ],
                    if (past.isNotEmpty) ...[
                      SectionLabel(
                        '${l.managePast} (${past.length})',
                        trailing: TextButton(
                          onPressed: () => setState(() => _showPast = !_showPast),
                          child: Text(_showPast ? l.commonClose : l.commonSeeAll),
                        ),
                      ),
                      if (_showPast) for (final d in past) _DriveRow(d: d),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return SoiCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: Space.lg, horizontal: Space.sm),
      child: Column(
        children: [
          Icon(icon, color: c.greenDark),
          const SizedBox(height: 6),
          Text(label, style: context.text.labelMedium, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _DriveRow extends StatelessWidget {
  const _DriveRow({required this.d, this.highlight = false});
  final OrgDrive d;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.sm),
      child: SoiCard(
        onTap: () => DriveRoute(id: d.id).push<void>(context),
        borderColor: highlight ? c.greenTint : null,
        padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(d.isCancelled ? l.driveFormCancelled : Fmt.dayOrRelative(d.startsAt),
                          style: context.text.labelSmall!.copyWith(color: d.isCancelled ? c.danger : c.green)),
                      const SizedBox(width: Space.sm),
                      Text(Fmt.time(d.startsAt), style: context.text.labelSmall),
                      if (d.pending > 0) ...[
                        const SizedBox(width: Space.sm),
                        SoiTag(l.managePendingBadge(d.pending), tone: TagTone.saffron),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(d.title, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(l.manageDriveStats(d.registrations, d.checkedIn, d.certified), style: context.text.bodySmall),
                ],
              ),
            ),
            if (!d.isCancelled)
              IconButton(
                tooltip: l.driveCoordinatorMode,
                icon: const Icon(Icons.qr_code_2),
                onPressed: () => CoordinatorRoute(id: d.id).push<void>(context),
              ),
          ],
        ),
      ),
    );
  }
}
