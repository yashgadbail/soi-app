import 'package:flutter/material.dart';

/// One colour and icon per cause. Kids and parents scan by colour before
/// they read; the colours stay within AA on their soft tints.
@immutable
class CauseStyle {
  const CauseStyle(this.icon, this.color);
  final IconData icon;
  final Color color;

  /// Soft tint for tiles and tags.
  Color soft(Brightness b) => color.withValues(alpha: b == Brightness.dark ? 0.22 : 0.14);

  /// Text/icon colour on the soft tint.
  Color ink(Brightness b) => b == Brightness.dark ? Color.lerp(color, Colors.white, 0.35)! : Color.lerp(color, Colors.black, 0.15)!;
}

const _styles = <String, CauseStyle>{
  'Environment': CauseStyle(Icons.eco_rounded, Color(0xFF0E7C5A)),
  'Education': CauseStyle(Icons.menu_book_rounded, Color(0xFF3D5AFE)),
  'Health': CauseStyle(Icons.favorite_rounded, Color(0xFFE0457B)),
  'Community': CauseStyle(Icons.groups_rounded, Color(0xFFFF9933)),
  'Animal welfare': CauseStyle(Icons.pets_rounded, Color(0xFFB8860B)),
  'Disaster relief': CauseStyle(Icons.warning_amber_rounded, Color(0xFFC0392B)),
};

const _fallback = CauseStyle(Icons.volunteer_activism_rounded, Color(0xFF12946C));

/// Case-insensitive lookup with a sensible default for free-text causes.
CauseStyle causeStyle(String? cause) {
  if (cause == null) return _fallback;
  for (final e in _styles.entries) {
    if (e.key.toLowerCase() == cause.trim().toLowerCase()) return e.value;
  }
  return _fallback;
}

/// The causes offered as chips when publishing (free text is also allowed).
List<String> get knownCauses => _styles.keys.toList();
