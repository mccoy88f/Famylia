import 'package:flutter/material.dart';

import 'famylia_accent_presets.dart';

/// Tema pulito giorno/notte con accento famiglia configurabile.
abstract final class AppTheme {
  static ThemeData light({required Color accent}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.light,
      surface: const Color(0xFFF8F9FC),
      onSurface: const Color(0xFF1A1D26),
      surfaceContainerHighest: const Color(0xFFEEF0F5),
      outline: const Color(0xFFD8DCE6),
    );
    return _base(scheme, accent);
  }

  static ThemeData dark({required Color accent}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
      surface: const Color(0xFF12141A),
      onSurface: const Color(0xFFE8EAEF),
      surfaceContainerHighest: const Color(0xFF1E222C),
      outline: const Color(0xFF3A4050),
    );
    return _base(scheme, accent);
  }

  static ThemeData _base(ColorScheme scheme, Color accent) {
    final isDark = scheme.brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(
        primary: accent,
        onPrimary: _onAccent(accent),
        secondary: accent.withValues(alpha: 0.75),
        tertiary: isDark ? const Color(0xFF8BA4C4) : const Color(0xFF6B7A94),
      ),
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? const Color(0xFF1A1E28) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.5)),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1A1E28) : Colors.white,
        indicatorColor: accent.withValues(alpha: 0.18),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
            color: scheme.onSurface.withValues(alpha: 0.85),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide(color: scheme.outline.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: isDark
            ? const Color(0xFF1E222C)
            : const Color(0xFFF0F2F7),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outline.withValues(alpha: 0.35),
        thickness: 1,
      ),
      fontFamily: 'Roboto',
    );
  }

  static Color _onAccent(Color accent) {
    final luminance = accent.computeLuminance();
    return luminance > 0.5 ? const Color(0xFF1A1D26) : Colors.white;
  }

  static Color accentFromFamily(String? hex) =>
      FamyliaAccentPresets.colorFromHex(hex);
}
