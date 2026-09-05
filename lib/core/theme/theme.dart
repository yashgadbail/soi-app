import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soi/core/theme/tokens.dart';

/// Light and dark [ThemeData] built from the brand tokens.
///
/// Material 3 components are styled once here so screens never set colours,
/// radii or paddings inline. If a screen needs a raw colour, add a token.
abstract final class SoiTheme {
  static const fontFamily = 'Inter';

  /// Transparent, non-scrimmed system bars so the page colour runs under the
  /// status bar like the platform apps do. Icons follow the theme.
  static SystemUiOverlayStyle systemBars({required bool dark}) => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
        statusBarBrightness: dark ? Brightness.dark : Brightness.light,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: dark ? Brightness.light : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      );

  /// Light icons for screens that open on the deep-green hero.
  static SystemUiOverlayStyle get systemBarsOnDark => systemBars(dark: true);

  static ThemeData light() => _build(Brightness.light, SoiColors.light);
  static ThemeData dark() => _build(Brightness.dark, SoiColors.dark);

  static ThemeData _build(Brightness brightness, SoiColors c) {
    final isDark = brightness == Brightness.dark;
    final base = ColorScheme.fromSeed(
      seedColor: c.green,
      brightness: brightness,
    );
    final scheme = base.copyWith(
      primary: c.green,
      onPrimary: isDark ? const Color(0xFF06231A) : Colors.white,
      primaryContainer: c.greenSoft,
      onPrimaryContainer: isDark ? c.greenMid : c.greenDark,
      secondary: c.saffron,
      onSecondary: const Color(0xFF3A2000),
      secondaryContainer: c.saffronSoft,
      onSecondaryContainer: c.saffronInk,
      tertiary: c.gold,
      surface: c.bg,
      onSurface: c.ink,
      onSurfaceVariant: c.body,
      surfaceContainerLowest: c.bg,
      surfaceContainerLow: c.bgAlt,
      surfaceContainer: c.bgAlt,
      surfaceContainerHigh: isDark ? const Color(0xFF1E2B25) : const Color(0xFFE6EDF1),
      surfaceContainerHighest: isDark ? const Color(0xFF26352E) : const Color(0xFFDDE5EC),
      outline: c.muted,
      outlineVariant: c.line,
      error: c.danger,
      onError: Colors.white,
      errorContainer: c.dangerSoft,
      onErrorContainer: c.danger,
    );

    final text = _textTheme(c);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: fontFamily,
      textTheme: text,
      scaffoldBackgroundColor: c.bgAlt,
      canvasColor: c.bgAlt,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      extensions: [c],
      appBarTheme: AppBarTheme(
        backgroundColor: c.bgAlt,
        surfaceTintColor: Colors.transparent,
        foregroundColor: c.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
        systemOverlayStyle: SoiTheme.systemBars(dark: isDark),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.bg,
        surfaceTintColor: Colors.transparent,
        indicatorColor: c.greenSoft,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelMedium!.copyWith(
            color: states.contains(WidgetState.selected) ? c.green : c.muted,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? c.greenDark : c.muted,
            size: 24,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: c.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.xl),
          side: BorderSide(color: c.line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: Space.xl),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.lg)),
          textStyle: text.labelLarge!.copyWith(fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: Space.xl),
          side: BorderSide(color: c.line, width: 1.5),
          foregroundColor: c.ink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.lg)),
          textStyle: text.labelLarge!.copyWith(fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(Space.tap, Space.tap),
          foregroundColor: c.green,
          textStyle: text.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(Space.tap, Space.tap),
          foregroundColor: c.body,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.bg,
        selectedColor: c.greenSoft,
        side: BorderSide(color: c.line),
        labelStyle: text.labelMedium!.copyWith(color: c.ink),
        secondaryLabelStyle: text.labelMedium!.copyWith(color: c.greenDark),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.pill)),
        showCheckmark: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.bg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: c.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: c.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: c.green, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: c.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: c.danger, width: 2),
        ),
        labelStyle: text.bodyMedium!.copyWith(color: c.muted),
        hintStyle: text.bodyMedium!.copyWith(color: c.muted),
        helperStyle: text.bodySmall!.copyWith(color: c.muted),
        errorStyle: text.bodySmall!.copyWith(color: c.danger),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.ink,
        contentTextStyle: text.bodyMedium!.copyWith(color: c.bg),
        actionTextColor: c.saffron,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.bg,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.xl)),
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.bg,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.xl)),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      listTileTheme: ListTileThemeData(
        iconColor: c.body,
        textColor: c.ink,
        minVerticalPadding: 12,
        contentPadding: const EdgeInsets.symmetric(horizontal: Space.lg),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: c.greenSoft,
          selectedForegroundColor: c.greenDark,
          foregroundColor: c.body,
          side: BorderSide(color: c.line),
          textStyle: text.labelMedium,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.green),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Colors.white : c.muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.green : c.line,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Type scale. One place, so screens stay consistent.
  static TextTheme _textTheme(SoiColors c) {
    TextStyle s(double size, FontWeight w, {double? h, double ls = 0, Color? color}) =>
        TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          fontWeight: w,
          height: h,
          letterSpacing: ls,
          color: color ?? c.ink,
        );
    return TextTheme(
      displayLarge: s(40, FontWeight.w800, ls: -1, h: 1.05),
      displayMedium: s(34, FontWeight.w800, ls: -0.8, h: 1.1),
      displaySmall: s(28, FontWeight.w800, ls: -0.5, h: 1.15),
      headlineLarge: s(26, FontWeight.w800, ls: -0.4, h: 1.2),
      headlineMedium: s(24, FontWeight.w800, ls: -0.3, h: 1.2),
      headlineSmall: s(20, FontWeight.w700, ls: -0.2, h: 1.25),
      titleLarge: s(18, FontWeight.w700, h: 1.3),
      titleMedium: s(16, FontWeight.w700, h: 1.3),
      titleSmall: s(14, FontWeight.w600, h: 1.3),
      bodyLarge: s(16, FontWeight.w400, h: 1.5, color: c.body),
      bodyMedium: s(15, FontWeight.w400, h: 1.45, color: c.body),
      bodySmall: s(13, FontWeight.w500, h: 1.4, color: c.muted),
      labelLarge: s(14, FontWeight.w600, h: 1.2),
      labelMedium: s(12, FontWeight.w600, h: 1.2, color: c.body),
      labelSmall: s(11, FontWeight.w700, ls: 0.8, h: 1.2, color: c.muted),
    );
  }
}
