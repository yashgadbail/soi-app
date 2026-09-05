import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soi/core/links.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/features/certificate/certificate_card.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

part 'certificate_screen.g.dart';

@riverpod
Future<Certificate> certificate(Ref ref, String code) =>
    ref.watch(accountRepoProvider).verifyCertificate(code.trim().toUpperCase());

/// Certificate page. A network failure is an error with retry; only a
/// server "not found" says the certificate does not exist. Those must never
/// be confused: this screen is what a student shows an admissions officer.
class CertificateScreen extends ConsumerStatefulWidget {
  const CertificateScreen({required this.code, super.key});
  final String code;

  @override
  ConsumerState<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends ConsumerState<CertificateScreen> {
  final GlobalKey<State<StatefulWidget>> _boundary = GlobalKey();
  bool _busy = false;

  Future<void> _shareImage(Certificate c) async {
    final l = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      await WidgetsBinding.instance.endOfFrame;
      final boundary = _boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final ratio = 1080 / boundary.size.width;
      final image = await boundary.toImage(pixelRatio: ratio);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${c.code}.png');
      await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);
      if (!mounted) return;
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path, mimeType: 'image/png')],
        text: l.certificateShareText(c.subjectName ?? '', Links.verifyUrl(c.code!)),
      ));
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _shareLink(Certificate c) async {
    final l = AppLocalizations.of(context);
    await SharePlus.instance.share(ShareParams(
      text: l.certificateShareText(c.subjectName ?? '', Links.verifyUrl(c.code!)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final async = ref.watch(certificateProvider(widget.code));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: Text(l.certificateTitle)),
      body: async.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(certificateProvider(widget.code))),
        data: (cert) {
          if (!cert.found) {
            return EmptyView(
              icon: Icons.search_off_rounded,
              title: l.certificateNotFoundTitle,
              body: l.certificateNotFoundBody,
            );
          }
          return ListView(
            padding: pageInsets(context),
            children: [
              RepaintBoundary(key: _boundary, child: CertificateCard(certificate: cert)),
              const SizedBox(height: Space.xl),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _busy ? null : () => _shareImage(cert),
                      icon: _busy
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.image_outlined),
                      label: Text(l.certificateShareImage),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Space.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _shareLink(cert),
                      icon: const Icon(Icons.link),
                      label: Text(l.certificateShareLink),
                    ),
                  ),
                  const SizedBox(width: Space.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => copyToClipboard(context, cert.code!),
                      icon: const Icon(Icons.copy_outlined),
                      label: Text(l.certificateCopyCode),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Space.xl),
              Notice(
                l.certificateAnyoneCanCheckBody(Uri.parse(Links.verifyPage).host),
                title: l.certificateAnyoneCanCheck,
                tone: TagTone.neutral,
                icon: Icons.verified_user_outlined,
              ),
              const SizedBox(height: Space.sm),
              Text(Links.verifyUrl(cert.code!), style: context.text.bodySmall!.copyWith(color: c.muted)),
            ],
          );
        },
      ),
    );
  }
}
