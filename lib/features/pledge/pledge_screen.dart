import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soi/core/links.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/qr_payload.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/passport/passport_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/qr_view.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

part 'pledge_screen.g.dart';

@riverpod
Future<PledgeDetail> pledgeDetail(Ref ref, String code) =>
    ref.watch(pledgesRepoProvider).detail(code.trim().toUpperCase());

/// Public pledge page reached from a poster QR, a share link or a code.
class PledgeScreen extends ConsumerStatefulWidget {
  const PledgeScreen({required this.code, super.key});
  final String code;

  @override
  ConsumerState<PledgeScreen> createState() => _PledgeScreenState();
}

class _PledgeScreenState extends ConsumerState<PledgeScreen> {
  bool _busy = false;

  Future<void> _sign(PledgeDetail p) async {
    final l = AppLocalizations.of(context);
    if (!ref.read(sessionControllerProvider).isSignedIn) {
      unawaited(
        SignInRoute(from: PledgeRoute(code: p.shareCode).location)
            .push<void>(context),
      );
      return;
    }
    setState(() => _busy = true);
    try {
      final r = await ref.read(pledgesRepoProvider).sign(p.shareCode);
      await HapticFeedback.mediumImpact();
      ref.invalidate(pledgeDetailProvider(widget.code));
      ref.invalidate(passportProvider);
      if (!mounted) return;
      showSnack(
        context,
        l.pledgeSignedSnack,
        actionLabel: r.certificateCode == null
            ? null
            : l.passportViewCertificate,
        onAction: r.certificateCode == null
            ? null
            : () =>
                  CertificateRoute(code: r.certificateCode!)
                      .push<void>(context),
      );
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share(PledgeDetail p) async {
    final l = AppLocalizations.of(context);
    await SharePlus.instance.share(
      ShareParams(
        text: l.pledgeShareText(
          p.title,
          p.orgName,
          Links.pledgeDeepLink(p.shareCode).toString(),
        ),
      ),
    );
  }

  Future<void> _showQr(PledgeDetail p) => showSoiSheet<void>(
    context,
    builder: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(p.title, style: ctx.text.titleLarge, textAlign: TextAlign.center),
        const SizedBox(height: Space.lg),
        QrView(QrPayload.pledge(p.shareCode), semanticsLabel: p.shareCode),
        const SizedBox(height: Space.md),
        SelectableText(
          p.shareCode,
          style: ctx.text.headlineSmall!.copyWith(letterSpacing: 4),
        ),
      ],
    ),
  );

  Widget? _actionBar(PledgeDetail p) {
    final l = AppLocalizations.of(context);
    final mine = p.mySignature;
    if (mine != null && mine.certificateCode == null) return null;
    return GlassActionBar(
      child: mine != null
          ? FilledButton.tonalIcon(
              onPressed: () =>
                  CertificateRoute(code: mine.certificateCode!)
                      .push<void>(context),
              icon: const Icon(Icons.workspace_premium_outlined),
              label: Text(l.passportViewCertificate),
            )
          : FilledButton(
              onPressed: _busy || !p.isActive ? null : () => _sign(p),
              child: _busy
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(l.pledgeSign),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final async = ref.watch(pledgeDetailProvider(widget.code));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(l.pledgeTitle),
        actions: [
          async.maybeWhen(
            data: (p) => Row(
              children: [
                IconButton(
                  tooltip: l.pledgeShowQr,
                  icon: const Icon(Icons.qr_code_2),
                  onPressed: () => _showQr(p),
                ),
                IconButton(
                  tooltip: l.commonShare,
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () => _share(p),
                ),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: async.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          error: e,
          onRetry: () => ref.invalidate(pledgeDetailProvider(widget.code)),
        ),
        data: (p) {
          final mine = p.mySignature;
          return ListView(
            padding: pageInsets(context),
            children: [
              Row(
                children: [
                  if (p.campaign != null)
                    SoiTag(p.campaign!, tone: TagTone.saffron),
                  if (p.campaign != null) const SizedBox(width: Space.sm),
                  if (!p.isActive) SoiTag(l.pledgesFilterClosed),
                ],
              ),
              const SizedBox(height: Space.md),
              Text(p.title, style: context.text.headlineMedium),
              const SizedBox(height: Space.sm),
              InkWell(
                onTap: () => OrgRoute(id: p.orgId).push<void>(context),
                borderRadius: BorderRadius.circular(Radii.sm),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l.pledgeBy(p.orgName), style: context.text.bodyMedium),
                    if (p.orgVerified) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: c.greenMid,
                        semanticLabel: l.discoverVerified,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: Space.xl),
              Container(
                padding: const EdgeInsets.all(Space.xl),
                decoration: BoxDecoration(
                  color: c.bg,
                  borderRadius: BorderRadius.circular(Radii.xl),
                  border: Border(
                    left: BorderSide(color: c.saffron, width: 4),
                    top: BorderSide(color: c.line),
                    right: BorderSide(color: c.line),
                    bottom: BorderSide(color: c.line),
                  ),
                ),
                child: Text(
                  p.body,
                  style: context.text.bodyLarge!.copyWith(
                    color: c.ink,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: Space.md),
              Text(
                l.pledgeSignatures(p.signatures),
                style: context.text.bodySmall,
              ),
              const SizedBox(height: Space.xl),
              if (mine != null)
                Notice(
                  '${l.pledgeSigned}. ${l.pledgeSignedNo(mine.signatureNo, Fmt.dayYear(mine.signedAt))}',
                  icon: Icons.check_circle_outline,
                )
              else if (!p.isActive)
                Notice(l.pledgeClosed, tone: TagTone.neutral),
              const SizedBox(height: Space.lg),
              Notice(
                l.pledgeWhatThisIsBody,
                title: l.pledgeWhatThisIs,
                tone: TagTone.neutral,
                icon: Icons.info_outline,
              ),
              if (p.canManage) ...[
                const SizedBox(height: Space.lg),
                OutlinedButton.icon(
                  onPressed: () =>
                      PledgeEditRoute(code: p.shareCode).push<void>(context),
                  icon: const Icon(Icons.edit_outlined),
                  label: Text(l.commonEdit),
                ),
              ],
            ],
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: async.maybeWhen(
        data: _actionBar,
        orElse: () => null,
      ),
    );
  }
}
