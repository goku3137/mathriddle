import 'package:flutter/material.dart';

class GameTheme {
  // Matte charcoal & black base palette
  static const Color background = Color(0xFF121418);
  static const Color surface = Color(0xFF1A1D24);
  static const Color surfaceElevated = Color(0xFF222630);
  
  // Structural borders & dividers
  static const Color borderSubtle = Color(0xFF2A2E39);
  static const Color borderActive = Color(0xFF3E4452);
  static const Color borderCharcoal = Color(0xFF2A2E39);
  static const Color borderDivider = Color(0xFF2A2E39);

  // Typography Palette
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFFE2E4E9);
  static const Color textLightGrey = Color(0xFFE2E4E9);
  static const Color textMuted = Color(0xFF7A8194);
  static const Color textDim = Color(0xFF505668);

  // Warm Accent Amber / Gold
  static const Color amberAccent = Color(0xFFE5A93C);
  static const Color amberGlow = Color(0x33E5A93C);
  static const Color warmOrange = Color(0xFFF37A1F);
  static const Color primaryOrange = Color(0xFFF37A1F);
  static const Color orangeGlow = Color(0x33F37A1F);

  // Feedback Colors
  static const Color errorRed = Color(0xFFEF5350);
  static const Color successGreen = Color(0xFF4CAF50);

  // High-contrast popup surface (clean off-white over dark backdrop)
  static const Color modalSurface = Color(0xFFF5F6F8);
  static const Color modalTextDark = Color(0xFF14171E);
  static const Color modalTextMuted = Color(0xFF5A6173);
  static const Color modalButtonDark = Color(0xFF1E222B);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: amberAccent,
      colorScheme: const ColorScheme.dark(
        primary: amberAccent,
        surface: surface,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textWhite,
          fontSize: 34,
          fontWeight: FontWeight.w800,
          letterSpacing: 4.0,
        ),
        headlineMedium: TextStyle(
          color: textLight,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.5,
        ),
        titleLarge: TextStyle(
          color: textWhite,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.0,
        ),
        bodyLarge: TextStyle(
          color: textLight,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.8,
        ),
        bodyMedium: TextStyle(
          color: textMuted,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
