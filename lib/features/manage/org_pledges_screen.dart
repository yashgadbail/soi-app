import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soi/core/links.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/qr_payload.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/features/pledge/pledge_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/qr_view.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

part 'org_pledges_screen.g.dart';

enum _Filter { active, closed }

/// An organisation's pledges: open, share, see signers, edit, close, delete.
class OrgPledgesScreen extends ConsumerStatefulWidget {
  const OrgPledgesScreen({required this.orgId, super.key});
  final String orgId;

  @override
  ConsumerState<OrgPledgesScreen> createState() => _OrgPledgesScreenState();
}

class _OrgPledgesScreenState extends ConsumerState<OrgPledgesScreen> {
  _Filter _filter = _Filter.active;

  void _refresh(OrgPledge p) {
    ref.invalidate(orgPledgesProvider(widget.orgId));
    ref.invalidate(pledgeDetailProvider(p.shareCode));
  }

  Future<void> _toggleStatus(OrgPledge p) async {
    final l = AppLocalizations.of(context);
    try {
      await ref.read(pledgesRepoProvider).setStatus(p.id, p.isActive ? 'closed' : 'active');
      _refresh(p);
      if (mounted) showSnack(context, p.isActive ? l.pledgesClosed : l.pledgesReopened);
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _delete(OrgPledge p) async {
    final l = AppLocalizations.of(context);
    if (p.signatures > 0) {
      // Signed pledges cannot be deleted: everyone who signed holds a
      // certificate for these exact words. Offer the constructive path.
      final close = await confirmDialog(context, title: l.pledgesDeleteBlockedTitle, body: l.pledgesDeleteBlockedBody, confirmLabel: l.pledgesClose);
      if (close && p.isActive) await _toggleStatus(p);
      return;
    }
    final ok = await confirmDialog(context, title: l.pledgesDeleteTitle, body: l.pledgesDeleteBody, confirmLabel: l.commonDelete, destructive: true);
    if (!ok) return;
    try {
      await ref.read(pledgesRepoProvider).delete(p.id);
      _refresh(p);
      if (mounted) showSnack(context, l.pledgesDeleted);
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _signers(OrgPledge p) async {
    final l = AppLocalizations.of(context);
    await showSoiSheet<void>(
      context,
      scrollable: true,
      builder: (ctx) => Consumer(
        builder: (ctx, ref, _) {
          final signers = ref.watch(pledgeSignersProvider(p.id));
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.pledgesSigners, style: ctx.text.titleLarge),
              Text(p.title, style: ctx.text.bodySmall),
              const SizedBox(height: Space.md),
              signers.when(
                loading: () => const Padding(padding: EdgeInsets.all(Space.xl), child: LoadingView()),
                error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(pledgeSignersProvider(p.id)), compact: true),
                data: (rows) => rows.isEmpty
                    ? Text(l.pledgeSignatures(0), style: ctx.text.bodyMedium)
                    : Column(
                        children: [
                          for (final s in rows)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: InitialsAvatar(s.name, size: 36),
                              title: Text(s.name),
                              subtitle: Text(Fmt.dayYear(s.signedAt)),
                              trailing: Text('#${s.signatureNo}', style: ctx.text.labelMedium),
                            ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _qr(OrgPledge p) => showSoiSheet<void>(
        context,
        builder: (ctx) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(p.title, style: ctx.text.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: Space.lg),
            QrView(QrPayload.pledge(p.shareCode), semanticsLabel: p.shareCode),
            const SizedBox(height: Space.md),
            SelectableText(p.shareCode, style: ctx.text.headlineSmall!.copyWith(letterSpacing: 4)),
            const SizedBox(height: Space.md),
            OutlinedButton.icon(
              onPressed: () => SharePlus.instance.share(ShareParams(text: '${p.title}: ${Links.pledgeDeepLink(p.shareCode)}')),
              icon: const Icon(Icons.share_outlined),
              label: Text(l10n(ctx).commonShare),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final pledges = ref.watch(orgPledgesProvider(widget.orgId));

    return Scaffold(
      appBar: AppBar(title: Text(l.pledgesTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => PledgeNewRoute(id: widget.orgId).push<void>(context),
        icon: const Icon(Icons.add),
        label: Text(l.pledgesNew),
      ),
      body: pledges.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(orgPledgesProvider(widget.orgId))),
        data: (rows) {
          if (rows.isEmpty) {
            return EmptyView(icon: Icons.handshake_outlined, title: l.pledgesEmptyTitle, body: l.pledgesEmptyBody);
          }
          final visible = rows.where((p) => (_filter == _Filter.active) == p.isActive).toList();
          return ListView(
            padding: pagePadding.copyWith(bottom: 96),
            children: [
              Row(
                children: [
                  SoiFilterChip(label: l.pledgesFilterActive, selected: _filter == _Filter.active, onSelected: (_) => setState(() => _filter = _Filter.active)),
                  const SizedBox(width: Space.sm),
                  SoiFilterChip(label: l.pledgesFilterClosed, selected: _filter == _Filter.closed, onSelected: (_) => setState(() => _filter = _Filter.closed)),
                ],
              ),
              const SizedBox(height: Space.md),
              if (visible.isEmpty) Padding(padding: const EdgeInsets.all(Space.xl), child: Text(l.discoverNoMatchTitle, textAlign: TextAlign.center, style: context.text.bodyMedium)),
              for (final p in visible)
                Padding(
                  padding: const EdgeInsets.only(bottom: Space.md),
                  child: SoiCard(
                    onTap: () => PledgeRoute(code: p.shareCode).push<void>(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (p.campaign != null) SoiTag(p.campaign!, tone: TagTone.saffron),
                            const Spacer(),
                            Text(p.shareCode, style: context.text.labelMedium!.copyWith(letterSpacing: 2, color: c.muted)),
                          ],
                        ),
                        const SizedBox(height: Space.sm),
                        Text(p.title, style: context.text.titleMedium),
                        const SizedBox(height: 4),
                        Text('${l.pledgeSignatures(p.signatures)} · ${Fmt.dayYear(p.createdAt)}', style: context.text.bodySmall),
                        const SizedBox(height: Space.md),
                        Wrap(
                          spacing: Space.xs,
                          children: [
                            TextButton.icon(onPressed: () => _qr(p), icon: const Icon(Icons.qr_code_2, size: 18), label: Text(l.pledgeShowQr)),
                            TextButton.icon(onPressed: () => _signers(p), icon: const Icon(Icons.people_outline, size: 18), label: Text(l.pledgesSigners)),
                            TextButton.icon(onPressed: () => PledgeEditRoute(code: p.shareCode).push<void>(context), icon: const Icon(Icons.edit_outlined, size: 18), label: Text(l.commonEdit)),
                            TextButton.icon(onPressed: () => _toggleStatus(p), icon: Icon(p.isActive ? Icons.lock_outline : Icons.lock_open_outlined, size: 18), label: Text(p.isActive ? l.pledgesClose : l.pledgesReopen)),
                            TextButton.icon(style: TextButton.styleFrom(foregroundColor: c.danger), onPressed: () => _delete(p), icon: const Icon(Icons.delete_outline, size: 18), label: Text(l.commonDelete)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

AppLocalizations l10n(BuildContext context) => AppLocalizations.of(context);

@riverpod
Future<List<Signer>> pledgeSigners(Ref ref, String id) => ref.watch(pledgesRepoProvider).signers(id);
