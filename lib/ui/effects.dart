import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:soi/core/theme/tokens.dart';

/// Visual effects used sparingly: one glass layer for chrome, a shimmer for
/// loading, a pop-in for confirmations. Each respects reduce-motion and is
/// cheap enough for a mid-range phone (a single BackdropFilter at most).

/// Frosted glass surface. Use for chrome that floats over scrolling content
/// (the tab bar, a pinned search bar), never for content itself.
class GlassSurface extends StatelessWidget {
  const GlassSurface({
    required this.child,
    super.key,
    this.blur = 18,
    this.opacity,
    this.borderRadius,
    this.border = true,
    this.padding,
  });

  final Widget child;
  final double blur;
  final double? opacity;
  final BorderRadius? borderRadius;
  final bool border;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final tint = c.bg.withValues(alpha: opacity ?? (dark ? 0.62 : 0.66));
    final radius = borderRadius ?? BorderRadius.zero;
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: tint,
            borderRadius: radius,
            border: border ? Border.all(color: c.line.withValues(alpha: 0.7)) : null,
          ),
          child: padding == null ? child : Padding(padding: padding!, child: child),
        ),
      ),
    );
  }
}

/// Light glass tile for use over the brand gradients (Welcome, Passport).
/// No blur: on a flat gradient a translucent white with a hairline reads as
/// glass and costs nothing.
class GradientGlassTile extends StatelessWidget {
  const GradientGlassTile({required this.child, super.key, this.padding = const EdgeInsets.all(Space.lg)});
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: child,
    );
  }
}

/// Skeleton placeholder with a moving highlight. Wrap any group of
/// [SkeletonBox]es in one [Shimmer] so they animate together.
class Shimmer extends StatefulWidget {
  const Shimmer({required this.child, super.key});
  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));

  @override
  void initState() {
    super.initState();
    _c.repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    final c = context.soi;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          colors: [c.bgAlt, c.bg, c.bgAlt],
          stops: const [0.35, 0.5, 0.65],
          transform: _Slide(_c.value),
        ).createShader(bounds),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _Slide extends GradientTransform {
  const _Slide(this.t);
  final double t;
  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues((t * 2 - 1) * bounds.width * 1.5, 0, 0);
}

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.height = 14, this.width, this.radius = Radii.sm});
  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: c.line.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(radius)),
    );
  }
}

/// A card-shaped skeleton matching the drive card's proportions.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key, this.lines = 3});
  final int lines;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    return Container(
      padding: const EdgeInsets.all(Space.xl),
      margin: const EdgeInsets.only(bottom: Space.md),
      decoration: BoxDecoration(
        color: c.bg,
        borderRadius: BorderRadius.circular(Radii.xl),
        border: Border.all(color: c.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [SkeletonBox(width: 72, height: 22, radius: Radii.pill), Spacer(), SkeletonBox(width: 32)]),
          const SizedBox(height: Space.lg),
          const SkeletonBox(height: 20, width: 240),
          const SizedBox(height: Space.sm),
          for (var i = 0; i < lines - 1; i++) ...[
            SkeletonBox(width: 140 + 40.0 * i),
            const SizedBox(height: Space.sm),
          ],
        ],
      ),
    );
  }
}

/// Scale + fade entrance for a confirmation icon or a freshly loaded hero.
class PopIn extends StatefulWidget {
  const PopIn({required this.child, super.key, this.delay = Duration.zero});
  final Widget child;
  final Duration delay;

  @override
  State<PopIn> createState() => _PopInState();
}

class _PopInState extends State<PopIn> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 420));
  late final Animation<double> _scale = CurvedAnimation(parent: _c, curve: Curves.easeOutBack);
  late final Animation<double> _fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.delay, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: Tween<double>(begin: 0.6, end: 1).animate(_scale), child: widget.child),
    );
  }
}

/// Centres content and caps its width on wide windows, per the adaptive
/// layout rule "constrain, then centre". Phones are unaffected.
class ContentWidth extends StatelessWidget {
  const ContentWidth({required this.child, super.key, this.maxWidth = 720});
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth), child: child),
    );
  }
}
