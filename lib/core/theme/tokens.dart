import 'package:flutter/material.dart';

/// Brand palette, resolved per brightness.
///
/// Independence-day palette: India green + saffron. `deep` is reserved for
/// the certificate and hero surfaces where gravitas beats freshness; it is
/// identical in both themes because a certificate must look the same
/// everywhere.
@immutable
class SoiColors extends ThemeExtension<SoiColors> {
  const SoiColors({
    required this.green,
    required this.greenDark,
    required this.greenMid,
    required this.greenSoft,
    required this.greenTint,
    required this.saffron,
    required this.saffronSoft,
    required this.saffronInk,
    required this.gold,
    required this.ink,
    required this.body,
    required this.muted,
    required this.line,
    required this.bg,
    required this.bgAlt,
    required this.danger,
    required this.dangerSoft,
    required this.success,
    required this.successSoft,
  });

  /// Fixed certificate palette (same in light and dark).
  static const deep = Color(0xFF083D2D);
  static const certGold = Color(0xFFC9A227);
  static const certSaffron = Color(0xFFFF9933);
  static const certQrInk = Color(0xFF083D2D);

  static const light = SoiColors(
    green: Color(0xFF0E7C5A),
    greenDark: Color(0xFF0A5C43),
    greenMid: Color(0xFF12946C),
    greenSoft: Color(0xFFE4F5EE),
    greenTint: Color(0xFFC9EADD),
    saffron: Color(0xFFFF9933),
    saffronSoft: Color(0xFFFFF2E3),
    saffronInk: Color(0xFF8A4B0F),
    gold: Color(0xFFC9A227),
    ink: Color(0xFF101820),
    body: Color(0xFF495563),
    muted: Color(0xFF8794A3),
    line: Color(0xFFDDE5EC),
    bg: Color(0xFFFFFFFF),
    bgAlt: Color(0xFFF3F6F8),
    danger: Color(0xFFC0392B),
    dangerSoft: Color(0xFFFDEDEC),
    success: Color(0xFF12946C),
    successSoft: Color(0xFFE4F5EE),
  );

  static const dark = SoiColors(
    green: Color(0xFF3DBF92),
    greenDark: Color(0xFF2AA079),
    greenMid: Color(0xFF4FD1A3),
    greenSoft: Color(0xFF12362A),
    greenTint: Color(0xFF1B4A39),
    saffron: Color(0xFFFFA64D),
    saffronSoft: Color(0xFF3A2A14),
    saffronInk: Color(0xFFFFC38A),
    gold: Color(0xFFD9B44A),
    ink: Color(0xFFF2F5F3),
    body: Color(0xFFB8C4BE),
    muted: Color(0xFF7F8C86),
    line: Color(0xFF253129),
    bg: Color(0xFF16211C),
    bgAlt: Color(0xFF0F1714),
    danger: Color(0xFFE5675A),
    dangerSoft: Color(0xFF3B1D1A),
    success: Color(0xFF4FD1A3),
    successSoft: Color(0xFF12362A),
  );

  final Color green;
  final Color greenDark;
  final Color greenMid;
  final Color greenSoft;
  final Color greenTint;
  final Color saffron;
  final Color saffronSoft;
  final Color saffronInk;
  final Color gold;
  final Color ink;
  final Color body;
  final Color muted;
  final Color line;
  final Color bg;
  final Color bgAlt;
  final Color danger;
  final Color dangerSoft;
  final Color success;
  final Color successSoft;

  @override
  SoiColors copyWith({
    Color? green,
    Color? greenDark,
    Color? greenMid,
    Color? greenSoft,
    Color? greenTint,
    Color? saffron,
    Color? saffronSoft,
    Color? saffronInk,
    Color? gold,
    Color? ink,
    Color? body,
    Color? muted,
    Color? line,
    Color? bg,
    Color? bgAlt,
    Color? danger,
    Color? dangerSoft,
    Color? success,
    Color? successSoft,
  }) {
    return SoiColors(
      green: green ?? this.green,
      greenDark: greenDark ?? this.greenDark,
      greenMid: greenMid ?? this.greenMid,
      greenSoft: greenSoft ?? this.greenSoft,
      greenTint: greenTint ?? this.greenTint,
      saffron: saffron ?? this.saffron,
      saffronSoft: saffronSoft ?? this.saffronSoft,
      saffronInk: saffronInk ?? this.saffronInk,
      gold: gold ?? this.gold,
      ink: ink ?? this.ink,
      body: body ?? this.body,
      muted: muted ?? this.muted,
      line: line ?? this.line,
      bg: bg ?? this.bg,
      bgAlt: bgAlt ?? this.bgAlt,
      danger: danger ?? this.danger,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
    );
  }

  @override
  SoiColors lerp(SoiColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return SoiColors(
      green: l(green, other.green),
      greenDark: l(greenDark, other.greenDark),
      greenMid: l(greenMid, other.greenMid),
      greenSoft: l(greenSoft, other.greenSoft),
      greenTint: l(greenTint, other.greenTint),
      saffron: l(saffron, other.saffron),
      saffronSoft: l(saffronSoft, other.saffronSoft),
      saffronInk: l(saffronInk, other.saffronInk),
      gold: l(gold, other.gold),
      ink: l(ink, other.ink),
      body: l(body, other.body),
      muted: l(muted, other.muted),
      line: l(line, other.line),
      bg: l(bg, other.bg),
      bgAlt: l(bgAlt, other.bgAlt),
      danger: l(danger, other.danger),
      dangerSoft: l(dangerSoft, other.dangerSoft),
      success: l(success, other.success),
      successSoft: l(successSoft, other.successSoft),
    );
  }
}

/// Spacing scale (dp). Use these instead of magic numbers.
abstract final class Space {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Horizontal page padding.
  static const double page = 20;

  /// Vertical rhythm between sections of a screen.
  static const double section = 28;

  /// Minimum touch target. 48dp is the Android accessibility floor, and it
  /// matters more than usual here: many users are students on cheap phones.
  static const double tap = 48;
}

/// Corner radii.
abstract final class Radii {
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double pill = 999;
}

/// Motion durations and curves. Restrained on purpose: entrance only on
/// first paint, no per-scroll replay, nothing over 400 ms.
abstract final class Motion {
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration base = Duration(milliseconds: 240);
  static const Duration enter = Duration(milliseconds: 380);
  static const Duration count = Duration(milliseconds: 900);

  /// Gentle deceleration; matches the platform feel.
  static const Curve out = Cubic(0.22, 1, 0.36, 1);
  static const Curve standard = Curves.easeInOutCubic;
}

extension SoiThemeX on BuildContext {
  SoiColors get soi => Theme.of(this).extension<SoiColors>()!;
  ColorScheme get scheme => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
