import 'package:flutter/material.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/l10n/generated/app_localizations.dart';

/// The three non-content states every async screen must render distinctly.
/// An error is never allowed to look like an empty list.

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          if (label != null) ...[
            const SizedBox(height: Space.md),
            Text(label!, style: context.text.bodySmall),
          ],
        ],
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.error,
    super.key,
    this.onRetry,
    this.compact = false,
  });

  final Object error;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final e = SoiError.from(error);
    final c = context.soi;
    final String title;
    final String body;
    final IconData icon;
    switch (e.kind) {
      case SoiErrorKind.offline:
        title = l.stateOfflineTitle;
        body = l.stateOfflineBody;
        icon = Icons.wifi_off_rounded;
      case SoiErrorKind.notFound:
        title = l.stateNotFoundTitle;
        body = l.stateNotFoundBody;
        icon = Icons.search_off_rounded;
      case SoiErrorKind.notSignedIn:
      case SoiErrorKind.notAuthorised:
      case SoiErrorKind.rule:
        title = l.stateErrorTitle;
        body = e.message(l);
        icon = Icons.error_outline_rounded;
      case SoiErrorKind.unknown:
        title = l.stateErrorTitle;
        body = l.stateErrorBody;
        icon = Icons.error_outline_rounded;
    }

    if (compact) {
      return Container(
        padding: const EdgeInsets.all(Space.lg),
        decoration: BoxDecoration(
          color: c.dangerSoft,
          borderRadius: BorderRadius.circular(Radii.lg),
        ),
        child: Row(
          children: [
            Icon(icon, color: c.danger, size: 20),
            const SizedBox(width: Space.md),
            Expanded(child: Text(body, style: context.text.bodySmall!.copyWith(color: c.danger))),
            if (onRetry != null)
              TextButton(onPressed: onRetry, child: Text(l.commonRetry)),
          ],
        ),
      );
    }

    return _StateScaffold(
      icon: icon,
      iconColor: c.danger,
      iconBg: c.dangerSoft,
      title: title,
      body: body,
      action: onRetry == null
          ? null
          : FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l.commonRetry),
            ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    required this.title,
    required this.body,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  final String title;
  final String body;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return _StateScaffold(
      icon: icon,
      iconColor: c.muted,
      iconBg: c.bg,
      title: title,
      body: body,
      action: action,
    );
  }
}

class SignedOutView extends StatelessWidget {
  const SignedOutView({
    required this.onSignIn,
    super.key,
    this.title,
    this.body,
    this.icon = Icons.lock_outline_rounded,
  });

  final VoidCallback onSignIn;
  final String? title;
  final String? body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    return _StateScaffold(
      icon: icon,
      iconColor: c.green,
      iconBg: c.greenSoft,
      title: title ?? l.stateSignedOutTitle,
      body: body ?? l.stateSignedOutBody,
      action: FilledButton(onPressed: onSignIn, child: Text(l.commonSignIn)),
    );
  }
}

class _StateScaffold extends StatelessWidget {
  const _StateScaffold({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: Space.xxxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, size: 32, color: iconColor),
              ),
              const SizedBox(height: Space.lg),
              Text(title, style: context.text.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: Space.sm),
              Text(body, style: context.text.bodyMedium, textAlign: TextAlign.center),
              if (action != null) ...[
                const SizedBox(height: Space.xxl),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
