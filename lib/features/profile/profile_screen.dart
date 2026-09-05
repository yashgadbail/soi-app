import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/links.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

const _appVersion = String.fromEnvironment('APP_VERSION', defaultValue: '2.0.0');

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context, title: l.profileSignOutConfirmTitle, body: l.profileSignOutConfirmBody, confirmLabel: l.commonSignOut);
    if (!ok || !context.mounted) return;
    try {
      await ref.read(authRepoProvider).signOut();
      if (context.mounted) {
        showSnack(context, l.profileSignedOut);
        const DiscoverRoute().go(context);
      }
    } catch (e) {
      if (context.mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(
      context,
      title: l.profileDeleteConfirmTitle,
      body: l.profileDeleteConfirmBody,
      confirmLabel: l.profileDeleteConfirmAction,
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    try {
      await ref.read(accountRepoProvider).deleteMyAccount();
      await ref.read(authRepoProvider).signOut();
      if (context.mounted) {
        showSnack(context, l.profileDeleted);
        const DiscoverRoute().go(context);
      }
    } catch (e) {
      if (context.mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _open(Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final s = ref.watch(sessionControllerProvider);

    if (!s.isSignedIn) {
      return Scaffold(
        appBar: AppBar(title: Text(l.profileTitle)),
        body: SignedOutView(
          icon: Icons.person_outline,
          onSignIn: () => const SignInRoute(from: '/profile').push<void>(context),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.profileTitle)),
      body: ListView(
        padding: pagePadding,
        children: [
          SoiCard(
            onTap: () => const NameEditRoute().push<void>(context),
            child: Row(
              children: [
                InitialsAvatar(s.displayName, size: 52),
                const SizedBox(width: Space.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.profile?.fullName ?? '', style: context.text.titleLarge),
                      const SizedBox(height: 2),
                      Text(s.email ?? '', style: context.text.bodySmall, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(l.profileNameOnCertificates, style: context.text.labelSmall),
                    ],
                  ),
                ),
                Icon(Icons.edit_outlined, color: c.muted),
              ],
            ),
          ),
          const SizedBox(height: Space.xl),
          SectionLabel(l.profileOrganisations),
          if (s.memberships.isEmpty)
            Text(l.profileNoOrganisations, style: context.text.bodyMedium)
          else
            SoiCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (final (i, m) in s.memberships.indexed) ...[
                    if (i > 0) const Divider(),
                    _MembershipTile(m: m),
                  ],
                ],
              ),
            ),
          const SizedBox(height: Space.md),
          OutlinedButton.icon(
            onPressed: () => const OrgNewRoute().push<void>(context),
            icon: const Icon(Icons.add_business_outlined),
            label: Text(l.profileRegisterOrg),
          ),
          const SizedBox(height: Space.sm),
          OutlinedButton.icon(
            onPressed: () => const ClaimRoute().push<void>(context),
            icon: const Icon(Icons.school_outlined),
            label: Text(l.profileLinkSchool),
          ),
          const SizedBox(height: Space.xl),
          SectionLabel(l.profileAppearance),
          SoiCard(
            padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
            child: Row(
              children: [
                Icon(Icons.brightness_auto_outlined, color: c.muted),
                const SizedBox(width: Space.md),
                Expanded(child: Text(l.profileAppearanceSystem, style: context.text.bodyMedium)),
              ],
            ),
          ),
          const SizedBox(height: Space.xl),
          SectionLabel(l.profileLegal),
          SoiCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _LinkTile(icon: Icons.privacy_tip_outlined, label: l.profilePrivacy, onTap: () => _open(Uri.parse(Links.privacy))),
                const Divider(),
                _LinkTile(icon: Icons.shield_outlined, label: l.profileChildSafety, onTap: () => _open(Uri.parse(Links.childSafety))),
                const Divider(),
                _LinkTile(icon: Icons.mail_outline, label: l.profileSupport, onTap: () => _open(Links.mailto(Links.supportEmail, subject: 'SOI app'))),
              ],
            ),
          ),
          const SizedBox(height: Space.sm),
          Text(l.profileVersion(_appVersion), style: context.text.bodySmall!.copyWith(color: c.muted)),
          const SizedBox(height: Space.xxl),
          OutlinedButton.icon(
            onPressed: () => _signOut(context, ref),
            icon: const Icon(Icons.logout),
            label: Text(l.commonSignOut),
          ),
          const SizedBox(height: Space.sm),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: c.danger),
            onPressed: () => _deleteAccount(context, ref),
            child: Text(l.profileDeleteAccount),
          ),
        ],
      ),
    );
  }
}

class _MembershipTile extends StatelessWidget {
  const _MembershipTile({required this.m});
  final Membership m;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final role = switch (m.role) {
      'owner' => l.orgSettingsRoleOwner,
      'admin' => l.orgSettingsRoleAdmin,
      'coordinator' => l.orgSettingsRoleCoordinator,
      _ => l.orgSettingsRoleMember,
    };
    return ListTile(
      leading: InitialsAvatar(m.orgName, tone: TagTone.saffron),
      title: Text(m.orgName, style: context.text.titleSmall),
      subtitle: Row(
        children: [
          SoiTag(role, tone: m.isCoordinator ? TagTone.green : TagTone.neutral),
          if (m.isVerified) ...[
            const SizedBox(width: 6),
            Icon(Icons.verified, size: 14, color: c.greenMid, semanticLabel: l.discoverVerified),
          ],
        ],
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: c.muted),
      onTap: () => m.isCoordinator
          ? OrgSettingsRoute(id: m.orgId).push<void>(context)
          : OrgRoute(id: m.orgId).push<void>(context),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.open_in_new, size: 18),
        onTap: onTap,
      );
}
