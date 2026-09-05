import 'package:flutter/material.dart';
import 'package:soi/core/theme/tokens.dart';

/// Entrance animation: fade + slide up, staggered by index on first paint
/// only. It never replays on scroll (the caller caps the stagger index), and
/// it respects the platform's reduced-motion setting.
class FadeInUp extends StatefulWidget {
  const FadeInUp({required this.child, super.key, this.index = 0, this.distance = 14});
  final Widget child;
  final int index;
  final double distance;

  @override
  State<FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: Motion.enter);
  late final Animation<double> _t = CurvedAnimation(parent: _c, curve: Motion.out);

  @override
  void initState() {
    super.initState();
    final delay = Duration(milliseconds: 55 * widget.index.clamp(0, 6));
    Future<void>.delayed(delay, () {
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
    return AnimatedBuilder(
      animation: _t,
      builder: (context, child) => Opacity(
        opacity: _t.value,
        child: Transform.translate(
          offset: Offset(0, (1 - _t.value) * widget.distance),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

/// Counts up to [value] once. The Passport number is the emotional payoff
/// of the whole app; it is the only number that animates.
class CountUp extends StatelessWidget {
  const CountUp(this.value, {super.key, this.style, this.decimals = 0});
  final num value;
  final TextStyle? style;
  final int decimals;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return Text(value.toStringAsFixed(decimals), style: style);
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: Motion.count,
      curve: Motion.out,
      builder: (context, v, _) => Text(v.toStringAsFixed(decimals), style: style),
    );
  }
}

/// Subtle scale on press for cards that navigate.
class PressScale extends StatefulWidget {
  const PressScale({required this.child, required this.onTap, super.key});
  final Widget child;
  final VoidCallback onTap;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _down ? 0.985 : 1,
        duration: Motion.fast,
        curve: Motion.standard,
        child: widget.child,
      ),
    );
  }
}
