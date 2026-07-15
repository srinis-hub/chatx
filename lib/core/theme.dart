import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Brand Colors
  static const Color primary = Color(0xFFA100FF);
  static const Color secondary = Color(0xFF00C2FF);

  // Light Theme Colors
  static const Color background = Color(0xFFF8F9FC);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F3F6);

  static const Color textPrimary = Color(0xFF1B1B1B);
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color border = Color(0xFFE5E7EB);

  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF453A);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error,
    ),

    scaffoldBackgroundColor: background,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),

    cardTheme: CardThemeData(
      color: surface,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: border, width: 0.8),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      hintStyle: const TextStyle(color: textSecondary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    dividerColor: border,

    iconTheme: const IconThemeData(color: textPrimary, size: 24),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
        color: textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
  );
}
