import 'package:flutter/material.dart';

class AppTheme {
  // =========================================================
  // LIGHT THEME
  // =========================================================

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xFFF7F8FC),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4C5DFF),
      brightness: Brightness.light,
    ),

    cardColor: Colors.white,

    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );

  // =========================================================
  // DARK THEME
  // =========================================================

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: Colors.black,

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4C5DFF),
      brightness: Brightness.dark,
    ),

    cardColor: const Color(0xFF171717),

    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF171717),
    ),
  );
}