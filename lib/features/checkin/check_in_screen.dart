import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/qr_payload.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/passport/passport_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/effects.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// QR check-in. One scan → one `check_in` call, latched so a stream of
/// frames can never fire twice. Pledge QRs open the pledge page instead.
class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> with WidgetsBindingObserver {
  final _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    autoStart: false,
  );

  /// Set the instant a code is accepted; cleared when the result sheet
  /// closes. Guards against the per-frame callback re-entering.
  bool _handling = false;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _start();
  }

  Future<void> _start() async {
    if (!ref.read(sessionControllerProvider).isSignedIn) return;
    try {
      await _controller.start();
      if (mounted && _permissionDenied) setState(() => _permissionDenied = false);
    } on MobileScannerException catch (e) {
      if (mounted && e.errorCode == MobileScannerErrorCode.permissionDenied) {
        setState(() => _permissionDenied = true);
      }
    } catch (_) {
      // Camera unavailable (emulator, hardware): the manual path still works.
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _start();
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        _controller.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) return;
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null) return;
    await _handleRaw(raw);
  }

  Future<void> _handleRaw(String raw) async {
    if (_handling) return;
    final l = AppLocalizations.of(context);
    final payload = QrPayload.parse(raw);
    if (payload == null) {
      showSnack(context, l.checkInUnknownQr);
      return;
    }
    _handling = true;
    await _controller.stop();
    try {
      switch (payload) {
        case PledgePayload(:final shareCode):
          await HapticFeedback.selectionClick();
          if (mounted) await PledgeRoute(code: shareCode).push<void>(context);
        case CheckInPayload(:final driveId, :final code):
          await _checkIn(driveId, code);
      }
    } finally {
      _handling = false;
      if (mounted) await _start();
    }
  }

  Future<void> _checkIn(String driveId, String code) async {
    final l = AppLocalizations.of(context);
    try {
      final result = await ref.read(drivesRepoProvider).checkIn(driveId, code);
      await HapticFeedback.mediumImpact();
      ref.invalidate(passportProvider);
      if (!mounted) return;
      await showSoiSheet<void>(context, builder: (ctx) => _ResultSheet(result: result));
    } on SoiError catch (e) {
      await HapticFeedback.heavyImpact();
      if (!mounted) return;
      await showSoiSheet<void>(
        context,
        builder: (ctx) => _FailureSheet(message: e.message(l), offline: e.isOffline),
      );
    }
  }

  Future<void> _manualEntry() async {
    final l = AppLocalizations.of(context);
    final value = await showSoiSheet<String>(
      context,
      builder: (ctx) => _ManualSheet(title: l.checkInManualTitle, lead: l.checkInManualLead, hint: l.checkInManualHint),
    );
    if (value == null || value.trim().isEmpty || !mounted) return;
    final v = value.trim();
    // Accept a bare 6-char pledge code as a convenience.
    final asPledge = RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(v) ? QrPayload.pledge(v.toUpperCase()) : v;
    await _handleRaw(asPledge);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final signedIn = ref.watch(sessionControllerProvider.select((s) => s.isSignedIn));

    ref.listen(sessionControllerProvider.select((s) => s.isSignedIn), (prev, now) {
      if (now && !(prev ?? false)) _start();
      if (!now) _controller.stop();
    });

    if (!signedIn) {
      return Scaffold(
        appBar: AppBar(title: Text(l.checkInTitle)),
        body: SignedOutView(
          icon: Icons.qr_code_scanner,
          body: l.checkInSignInFirst,
          onSignIn: () => const SignInRoute(from: '/check-in').push<void>(context),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(l.checkInTitle),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, state, _) => IconButton(
              tooltip: l.checkInTorch,
              icon: Icon(state.torchState == TorchState.on ? Icons.flashlight_on : Icons.flashlight_off),
              onPressed: state.isRunning ? _controller.toggleTorch : null,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_permissionDenied)
            ColoredBox(
              color: c.bgAlt,
              child: EmptyView(
                icon: Icons.no_photography_outlined,
                title: l.checkInPermissionTitle,
                body: l.checkInPermissionBody,
                action: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton(onPressed: _start, child: Text(l.checkInAllowCamera)),
                    const SizedBox(height: Space.sm),
                    TextButton(
                      onPressed: AppSettings.openAppSettings,
                      child: Text(l.checkInOpenSettings),
                    ),
                  ],
                ),
              ),
            )
          else
            MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
              errorBuilder: (context, error) => ColoredBox(
                color: c.bgAlt,
                child: EmptyView(
                  icon: Icons.videocam_off_outlined,
                  title: l.checkInPermissionTitle,
                  body: l.checkInPermissionBody,
                  action: FilledButton(onPressed: _start, child: Text(l.commonRetry)),
                ),
              ),
            ),
          if (!_permissionDenied) const _Reticle(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Space.page, 0, Space.page, Space.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_permissionDenied)
                      Text(l.checkInLead, style: context.text.titleSmall!.copyWith(color: Colors.white), textAlign: TextAlign.center),
                    const SizedBox(height: Space.md),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 1.5),
                      ),
                      onPressed: _manualEntry,
                      icon: const Icon(Icons.keyboard_outlined),
                      label: Text(l.checkInEnterCode),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Reticle extends StatelessWidget {
  const _Reticle();
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: CustomPaint(painter: _CornerPainter()),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    const len = 28.0;
    final w = size.width;
    final h = size.height;
    for (final (dx, dy) in [(0.0, 0.0), (w, 0.0), (0.0, h), (w, h)]) {
      final sx = dx == 0 ? 1 : -1;
      final sy = dy == 0 ? 1 : -1;
      canvas
        ..drawLine(Offset(dx, dy), Offset(dx + sx * len, dy), p)
        ..drawLine(Offset(dx, dy), Offset(dx, dy + sy * len), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ResultSheet extends StatelessWidget {
  const _ResultSheet({required this.result});
  final CheckInResult result;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final r = result;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PopIn(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: c.greenSoft, shape: BoxShape.circle),
            child: Icon(Icons.check_rounded, size: 38, color: c.greenDark),
          ),
        ),
        const SizedBox(height: Space.lg),
        Text(r.already ? l.checkInAlreadyTitle : l.checkInSuccessTitle, style: context.text.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: Space.sm),
        Text(
          r.already ? l.checkInAlreadyBody(r.driveTitle) : l.checkInSuccessBody(l.commonHours(r.hours), r.driveTitle, r.orgName),
          style: context.text.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Space.xl),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            const PassportRoute().go(context);
          },
          child: Text(l.checkInViewPassport),
        ),
        const SizedBox(height: Space.sm),
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l.checkInScanAnother)),
      ],
    );
  }
}

class _FailureSheet extends StatelessWidget {
  const _FailureSheet({required this.message, required this.offline});
  final String message;
  final bool offline;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(color: c.dangerSoft, shape: BoxShape.circle),
          child: Icon(offline ? Icons.wifi_off_rounded : Icons.close_rounded, size: 32, color: c.danger),
        ),
        const SizedBox(height: Space.lg),
        Text(offline ? l.stateOfflineTitle : l.stateErrorTitle, style: context.text.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: Space.sm),
        Text(message, style: context.text.bodyLarge, textAlign: TextAlign.center),
        const SizedBox(height: Space.xl),
        FilledButton(onPressed: () => Navigator.of(context).pop(), child: Text(l.commonRetry)),
      ],
    );
  }
}

/// Shared "type a code" sheet (also used by Welcome for pledge codes).
class _ManualSheet extends StatefulWidget {
  const _ManualSheet({required this.title, required this.lead, required this.hint});
  final String title;
  final String lead;
  final String hint;

  @override
  State<_ManualSheet> createState() => _ManualSheetState();
}

class _ManualSheetState extends State<_ManualSheet> {
  final _c = TextEditingController();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.title, style: context.text.titleLarge),
        const SizedBox(height: Space.xs),
        Text(widget.lead, style: context.text.bodyMedium),
        const SizedBox(height: Space.lg),
        TextField(
          controller: _c,
          autofocus: true,
          autocorrect: false,
          textInputAction: TextInputAction.go,
          onSubmitted: (v) => Navigator.of(context).pop(v),
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: IconButton(
              tooltip: l.commonCopy,
              icon: const Icon(Icons.content_paste),
              onPressed: () async {
                final data = await Clipboard.getData(Clipboard.kTextPlain);
                if (data?.text != null) _c.text = data!.text!;
              },
            ),
          ),
        ),
        const SizedBox(height: Space.lg),
        FilledButton(onPressed: () => Navigator.of(context).pop(_c.text), child: Text(l.commonContinue)),
      ],
    );
  }
}
