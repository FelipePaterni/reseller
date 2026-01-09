import 'package:flutter/material.dart';

/// Design system color palette for Reseller app
///
/// Organized by semantic purpose. Light theme by default.
/// Dark theme variants are interpolated via [AppTheme].
@immutable
abstract class AppColors {
  // ============ Brand (Warm Palette) ============
  /// Background: soft cream
  static const Color brandBackground = Color(0xFFF6EFE7);

  /// Primary brand accent: warm terracotta
  static const Color brandAccent = Color(0xFFC78B54);

  /// Brand accent dark: deeper terracotta for contrast
  static const Color brandAccentDark = Color(0xFFA0673D);

  // ============ Semantic (Text) ============
  /// Primary text: dark brown for warm palette
  static const Color textPrimary = Color(0xFF6B4A2A);

  /// Secondary/muted text: lighter brown
  static const Color textSecondary = Color(0xFF8C6A4A);

  /// Tertiary text: very light, for hints
  static const Color textTertiary = Color(0xFFB8A89D);

  /// Inverted text for dark backgrounds
  static const Color textInverted = Color(0xFFFAF8F5);

  // ============ Surface ============
  /// Card/Surface background
  static const Color surface = Colors.white;

  /// Surface variant: subtle alternative
  static const Color surfaceVariant = Color(0xFFFAF8F5);

  // ============ Semantic States ============
  /// Error/destructive action
  static const Color error = Color(0xFFB3261E);

  /// Success state
  static const Color success = Color(0xFF2E7D32);

  /// Warning state
  static const Color warning = Color(0xFFF57C00);

  /// Info/neutral state
  static const Color info = Color(0xFF1976D2);

  // ============ Utility ============
  /// Subtle shadow tint (based on brand)
  static const Color shadowDark = Color(0x1A6B4A2A);

  /// Overlay/scrim tint
  static const Color scrim = Color(0x1F000000);

  /// Divider/border line color
  static const Color divider = Color(0xFFE8DDD2);

  /// Disabled/inactive state
  static const Color disabled = Color(0xFFCCC2B8);
}
