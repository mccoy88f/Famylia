import 'package:flutter/material.dart';

/// Palette calda Famylia — arancio, verde acqua, blu pastello.
abstract final class FamyliaColors {
  static const primary = Color(0xFFE87A3B);
  static const primaryDark = Color(0xFFC45E28);
  static const secondary = Color(0xFF4DB6AC);
  static const tertiary = Color(0xFF7EB8DA);
  static const surfaceLight = Color(0xFFFFFBF7);
  static const surfaceDark = Color(0xFF1A1A1E);
  static const onSurfaceDark = Color(0xFFE8E6E3);
}

abstract final class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: FamyliaColors.primary,
        primary: FamyliaColors.primary,
        secondary: FamyliaColors.secondary,
        tertiary: FamyliaColors.tertiary,
        surface: FamyliaColors.surfaceLight,
        brightness: Brightness.light,
      ),
      fontFamily: 'Roboto',
    );
    return base.copyWith(
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: FamyliaColors.primary,
        primary: FamyliaColors.primary,
        secondary: FamyliaColors.secondary,
        brightness: Brightness.dark,
        surface: FamyliaColors.surfaceDark,
      ),
      fontFamily: 'Roboto',
    );
    return base.copyWith(
      scaffoldBackgroundColor: FamyliaColors.surfaceDark,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
