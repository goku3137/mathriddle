import 'package:flutter/material.dart';

/// Readability-first educational color palette & styling dedicated to SMATH Learning.
/// Conforms to WCAG AA / AAA contrast guidelines for long, fatigue-free study.
class LearningTheme {
  LearningTheme._();

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF8F9FA); // Clean warm white reading surface
  static const Color surface = Color(0xFFFFFFFF); // Pure white card surface
  static const Color surfaceSubtle = Color(0xFFF1F5F9); // Soft slate tint for formulas/steps
  static const Color surfaceElevated = Color(0xFFFFFFFF); // Elevated surfaces

  // High-Contrast Typography (Exceeds WCAG AAA)
  static const Color textPrimary = Color(0xFF0F172A); // Deep slate near-black (15.5:1 ratio)
  static const Color textSecondary = Color(0xFF334155); // Rich slate-700 (9.8:1 ratio)
  static const Color textMuted = Color(0xFF64748B); // Slate-500 (4.8:1 ratio)

  // Functional & Semantic Accents
  static const Color primary = Color(0xFF1E293B); // Dark slate header & controls
  static const Color stageBlue = Color(0xFF0284C7); // Educational cerulean
  static const Color stageBlueBg = Color(0xFFE0F2FE); // Soft cerulean tint
  
  // Remember / Key Takeaway Callout
  static const Color takeawayBg = Color(0xFFFFFBEB); // Warm amber paper tint
  static const Color takeawayBorder = Color(0xFFFDE68A); // Warm amber border
  static const Color takeawayText = Color(0xFF92400E); // Deep amber text

  // Feedback Colors (Accessible & Colorblind-Friendly)
  static const Color correctGreen = Color(0xFF166534); // Accessible dark green
  static const Color correctBg = Color(0xFFDCFCE7); // Mint green tint
  static const Color wrongRed = Color(0xFF991B1B); // Accessible dark crimson
  static const Color wrongBg = Color(0xFFFEE2E2); // Blush red tint

  // Borders & Separators
  static const Color border = Color(0xFFE2E8F0); // Subtle slate border
  static const Color borderActive = Color(0xFF94A3B8); // Focused border
  static const Color divider = Color(0xFFE2E8F0); // Subtle hairline separator
}
