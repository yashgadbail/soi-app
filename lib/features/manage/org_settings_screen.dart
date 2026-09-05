import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Organisation settings: details, team (admins), invites, leave.
class OrgSettingsScreen extends ConsumerWidget {
  const OrgSettingsScreen({required this.orgId, super.key});
  final String orgId;

  Future<void> _invite(BuildContext context, WidgetRef ref) async {
    final ok = await showSoiSheet<bool>(context, scrollable: true, builder: (ctx) => _InviteSheet(orgId: orgId));
    if (ok == true) {
      ref.invalidate(orgMembersProvider(orgId));
      ref.invalidate(orgInvitesProvider(orgId));
    }
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, OrgMember m) async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context, title: l.orgSettingsRemoveConfirmTitle(m.name ?? m.email ?? ''), body: l.orgSettingsRemoveConfirmBody, confirmLabel: l.commonRemove, cancelLabel: l.dialogKeepMember, destructive: true);
    if (!ok) return;
    try {
      await ref.read(orgsRepoProvider).removeMember(orgId: orgId, userId: m.userId);
      ref.invalidate(orgMembersProvider(orgId));
      if (context.mounted) showSnack(context, l.orgSettingsRemoved);
    } catch (e) {
      if (context.mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _cancelInvite(BuildContext context, WidgetRef ref, OrgInvite i) async {
    try {
      await ref.read(orgsRepoProvider).cancelInvite(orgId: orgId, email: i.email);
      ref.invalidate(orgInvitesProvider(orgId));
    } catch (e) {
      if (context.mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _leave(BuildContext context, WidgetRef ref, Membership m) async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context, title: l.orgSettingsLeaveConfirmTitle(m.orgName), body: l.orgSettingsLeaveConfirmBody, confirmLabel: l.orgSettingsLeave, cancelLabel: l.dialogStay, destructive: true);
    if (!ok) return;
    try {
      await ref.read(orgsRepoProvider).leave(orgId);
      await ref.read(sessionControllerProvider.notifier).refreshMemberships();
      if (context.mounted) {
        showSnack(context, l.orgSettingsLeft(m.orgName));
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) showErrorSnack(context, e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final session = ref.watch(sessionControllerProvider);
    final m = session.memberships.where((x) => x.orgId == orgId).firstOrNull;
    if (m == null) {
      return Scaffold(appBar: AppBar(title: Text(l.orgSettingsTitle)), body: const ErrorView(error: SoiError('ORG_NOT_FOUND', SoiErrorKind.notFound)));
    }
    final members = m.isAdmin ? ref.watch(orgMembersProvider(orgId)) : null;
    final invites = m.isAdmin ? ref.watch(orgInvitesProvider(orgId)) : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(l.orgSettingsTitle),
        actions: [
          if (m.isAdmin) IconButton(tooltip: l.commonEdit, icon: const Icon(Icons.edit_outlined), onPressed: () => OrgEditRoute(id: orgId).push<void>(context)),
        ],
      ),
      body: ListView(
        padding: pageInsets(context),
        children: [
          Row(
            children: [
              InitialsAvatar(m.orgName, size: 56, tone: TagTone.saffron),
              const SizedBox(width: Space.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.orgName, style: context.text.headlineSmall),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: Space.sm,
                      children: [
                        SoiTag(switch (m.orgType) { 'school' => l.orgTypeSchool, 'corporate' => l.orgTypeCorporate, _ => l.orgTypeNgo }),
                        if (m.city != null) SoiTag(m.city!, icon: Icons.place_outlined),
                        if (m.isVerified) SoiTag(l.orgVerifiedBadge, tone: TagTone.green, icon: Icons.verified) else SoiTag(l.orgUnverified),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          OutlinedButton.icon(
            onPressed: () => OrgRoute(id: orgId).push<void>(context),
            icon: const Icon(Icons.public),
            label: Text(l.orgTitle),
          ),
          if (m.isAdmin) ...[
            const SizedBox(height: Space.xl),
            SectionLabel(
              l.orgSettingsMembers,
              trailing: TextButton.icon(onPressed: () => _invite(context, ref), icon: const Icon(Icons.person_add_alt_1, size: 18), label: Text(l.orgSettingsInvite)),
            ),
            members!.when(
              loading: () => const Padding(padding: EdgeInsets.all(Space.xl), child: LoadingView()),
              error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(orgMembersProvider(orgId)), compact: true),
              data: (rows) => SoiCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (final (i, member) in rows.indexed) ...[
                      if (i > 0) const Divider(),
                      ListTile(
                        leading: InitialsAvatar(member.name ?? member.email ?? '?'),
                        title: Text(member.name ?? member.email ?? ''),
                        subtitle: Text([member.email, Fmt.dayYear(member.joinedAt)].whereType<String>().join(' · '), maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SoiTag(_role(l, member.role), tone: member.role == 'owner' ? TagTone.saffron : TagTone.neutral),
                            if (member.role != 'owner' && member.userId != session.userId)
                              IconButton(tooltip: l.commonRemove, icon: Icon(Icons.person_remove_outlined, color: c.muted), onPressed: () => _remove(context, ref, member)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            invites!.maybeWhen(
              data: (rows) => rows.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: Space.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SectionLabel(l.orgSettingsPending),
                          SoiCard(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                for (final (i, inv) in rows.indexed) ...[
                                  if (i > 0) const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.mail_outline),
                                    title: Text(inv.email),
                                    subtitle: Text('${_role(l, inv.role)} · ${Fmt.ago(inv.createdAt)}'),
                                    trailing: IconButton(tooltip: l.orgSettingsCancelInvite, icon: const Icon(Icons.close), onPressed: () => _cancelInvite(context, ref, inv)),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
          const SizedBox(height: Space.xxl),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: c.danger),
            onPressed: () => _leave(context, ref, m),
            icon: const Icon(Icons.logout),
            label: Text(l.orgSettingsLeave),
          ),
        ],
      ),
    );
  }

  static String _role(AppLocalizations l, String role) => switch (role) {
        'owner' => l.orgSettingsRoleOwner,
        'admin' => l.orgSettingsRoleAdmin,
        'coordinator' => l.orgSettingsRoleCoordinator,
        _ => l.orgSettingsRoleMember,
      };
}

class _InviteSheet extends ConsumerStatefulWidget {
  const _InviteSheet({required this.orgId});
  final String orgId;

  @override
  ConsumerState<_InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends ConsumerState<_InviteSheet> {
  final _email = TextEditingController();
  String _role = 'coordinator';
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l = AppLocalizations.of(context);
    final err = Validators.email(_email.text);
    setState(() => _error = err == null ? null : errorMessage(l, err));
    if (err != null) return;
    setState(() => _busy = true);
    try {
      await ref.read(orgsRepoProvider).invite(orgId: widget.orgId, email: _email.text.trim(), role: _role);
      if (!mounted) return;
      showSnack(context, l.orgSettingsInvited);
      Navigator.of(context).pop(true);
    } on SoiError catch (e) {
      if (mounted) setState(() => _error = e.message(l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final roles = [
      ('admin', l.orgSettingsRoleAdmin, l.orgSettingsRoleAdminHelp),
      ('coordinator', l.orgSettingsRoleCoordinator, l.orgSettingsRoleCoordinatorHelp),
      ('member', l.orgSettingsRoleMember, l.orgSettingsRoleMemberHelp),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.orgSettingsInvite, style: context.text.titleLarge),
        const SizedBox(height: Space.xs),
        Text(l.orgSettingsInviteLead, style: context.text.bodyMedium),
        const SizedBox(height: Space.lg),
        TextField(
          controller: _email,
          autofocus: true,
          enabled: !_busy,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _send(),
          decoration: InputDecoration(labelText: l.signInEmailLabel, errorText: _error),
        ),
        const SizedBox(height: Space.md),
        SectionLabel(l.orgSettingsInviteRole),
        RadioGroup<String>(
          groupValue: _role,
          onChanged: (v) => _busy || v == null ? null : setState(() => _role = v),
          child: Column(
            children: [
              for (final (value, label, help) in roles)
                RadioListTile<String>(
                  value: value,
                  contentPadding: EdgeInsets.zero,
                  title: Text(label),
                  subtitle: Text(help),
                ),
            ],
          ),
        ),
        const SizedBox(height: Space.md),
        FilledButton(onPressed: _busy ? null : _send, child: Text(l.orgSettingsInvite)),
      ],
    );
  }
}
