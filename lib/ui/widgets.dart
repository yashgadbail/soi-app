import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/l10n/generated/app_localizations.dart';

/// Shared building blocks. Screens compose these; they do not restyle them.

class SoiCard extends StatelessWidget {
  const SoiCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(Space.lg),
    this.color,
    this.borderColor,
    this.semanticsLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.xl),
      side: BorderSide(color: borderColor ?? c.line),
    );
    final body = Padding(padding: padding, child: child);
    final card = Material(
      color: color ?? c.bg,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: onTap == null
          ? body
          : InkWell(onTap: onTap, child: body),
    );
    return RepaintBoundary(
      child: semanticsLabel == null
          ? card
          : Semantics(button: onTap != null, label: semanticsLabel, child: card),
    );
  }
}

/// Micro-caps section label.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.trailing, this.padding});
  final String text;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: Space.md),
      child: Row(
        children: [
          Expanded(
            child: Text(text.toUpperCase(), style: context.text.labelSmall),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

enum TagTone { neutral, green, saffron, gold, danger }

/// Small status tag.
class SoiTag extends StatelessWidget {
  const SoiTag(this.label, {super.key, this.tone = TagTone.neutral, this.icon});
  final String label;
  final TagTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final (bg, fg) = switch (tone) {
      TagTone.neutral => (c.bgAlt, c.body),
      TagTone.green => (c.greenSoft, c.greenDark),
      TagTone.saffron => (c.saffronSoft, c.saffronInk),
      TagTone.gold => (c.saffronSoft, c.saffronInk),
      TagTone.danger => (c.dangerSoft, c.danger),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Radii.pill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label, style: context.text.labelSmall!.copyWith(color: fg, letterSpacing: 0.3)),
        ],
      ),
    );
  }
}

/// Selectable filter chip with a 48dp touch target.
class SoiFilterChip extends StatelessWidget {
  const SoiFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
    this.icon,
  });
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Space.tap,
      child: Center(
        child: FilterChip(
          label: Text(label),
          avatar: icon == null ? null : Icon(icon, size: 16),
          selected: selected,
          onSelected: onSelected,
        ),
      ),
    );
  }
}

/// Initials avatar for people without photos (everyone; the app stores none).
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.name, {super.key, this.size = 40, this.tone = TagTone.green});
  final String name;
  final double size;
  final TagTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    final initials = parts.isEmpty
        ? '?'
        : parts.length == 1
            ? parts.first.characters.first.toUpperCase()
            : (parts.first.characters.first + parts.last.characters.first).toUpperCase();
    final (bg, fg) = switch (tone) {
      TagTone.saffron || TagTone.gold => (c.saffronSoft, c.saffronInk),
      TagTone.danger => (c.dangerSoft, c.danger),
      TagTone.neutral => (c.bgAlt, c.body),
      TagTone.green => (c.greenSoft, c.greenDark),
    };
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: context.text.labelLarge!.copyWith(color: fg, fontSize: size * 0.38),
        ),
      ),
    );
  }
}

/// A row of key/value facts.
class FactRow extends StatelessWidget {
  const FactRow({required this.icon, required this.label, required this.value, super.key, this.onTap});
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: c.muted),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.text.labelSmall),
                const SizedBox(height: 2),
                Text(value, style: context.text.bodyLarge!.copyWith(color: c.ink)),
              ],
            ),
          ),
          if (onTap != null) Icon(Icons.chevron_right_rounded, color: c.muted),
        ],
      ),
    );
    if (onTap == null) return row;
    return InkWell(borderRadius: BorderRadius.circular(Radii.md), onTap: onTap, child: row);
  }
}

/// Inline notice (info / warning) used instead of dialogs for non-blocking facts.
class Notice extends StatelessWidget {
  const Notice(this.text, {super.key, this.tone = TagTone.green, this.icon, this.title});
  final String text;
  final String? title;
  final TagTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final (bg, fg, border) = switch (tone) {
      TagTone.green => (c.greenSoft, c.greenDark, c.greenTint),
      TagTone.saffron || TagTone.gold => (c.saffronSoft, c.saffronInk, c.saffronSoft),
      TagTone.danger => (c.dangerSoft, c.danger, c.dangerSoft),
      TagTone.neutral => (c.bg, c.body, c.line),
    };
    return Container(
      padding: const EdgeInsets.all(Space.lg),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? Icons.info_outline_rounded, size: 20, color: fg),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title!, style: context.text.titleSmall!.copyWith(color: fg)),
                  const SizedBox(height: 4),
                ],
                Text(text, style: context.text.bodySmall!.copyWith(color: fg, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Big number + caption, for the Passport hero and Manage stats.
class StatTile extends StatelessWidget {
  const StatTile({required this.value, required this.label, super.key, this.onDark = false});
  final String value;
  final String label;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.text.headlineMedium!.copyWith(
            color: onDark ? Colors.white : c.ink,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: context.text.labelSmall!.copyWith(
            color: onDark ? Colors.white.withValues(alpha: 0.7) : c.muted,
          ),
        ),
      ],
    );
  }
}

/// Snackbar helpers: the only success channel in the app.
void showSnack(BuildContext context, String message, {String? actionLabel, VoidCallback? onAction}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: onAction == null ? 3 : 5),
        action: actionLabel == null || onAction == null
            ? null
            : SnackBarAction(label: actionLabel, onPressed: onAction),
      ),
    );
}

void showErrorSnack(BuildContext context, Object error) {
  final l = AppLocalizations.of(context);
  showSnack(context, SoiError.from(error).message(l));
}

/// Confirmation dialog for irreversible actions. Returns true when confirmed.
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final l = AppLocalizations.of(context);
  final c = context.soi;
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(l.commonCancel)),
        FilledButton(
          style: destructive ? FilledButton.styleFrom(backgroundColor: c.danger) : null,
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Bottom sheet with consistent padding and safe area.
Future<T?> showSoiSheet<T>(BuildContext context, {required WidgetBuilder builder, bool scrollable = false}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        left: Space.page,
        right: Space.page,
        bottom: MediaQuery.viewInsetsOf(ctx).bottom + Space.xl,
      ),
      child: scrollable
          ? SingleChildScrollView(child: builder(ctx))
          : builder(ctx),
    ),
  );
}

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) showSnack(context, AppLocalizations.of(context).commonCopied);
}

/// Translates a validator key (or null) into decoration text.
String? fieldError(BuildContext context, String? key) =>
    key == null ? null : errorMessage(AppLocalizations.of(context), key);

/// Page-level padding used by every list/scroll view.
const pagePadding = EdgeInsets.fromLTRB(Space.page, Space.sm, Space.page, 40);
