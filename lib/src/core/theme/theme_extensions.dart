import 'package:flutter/material.dart';
import 'package:reseller/src/core/theme/app_spacing.dart';

/// Convenient extensions for accessing theme tokens in widgets
///
/// Usage:
/// ```dart
/// Widget build(BuildContext context) {
///   final spacing = context.spacing;
///   return Padding(
///     padding: EdgeInsets.all(spacing.md),
///     child: ...
///   );
/// }
/// ```
extension ThemeContextExtension on BuildContext {
  /// Access spacing tokens safely with fallback defaults
  AppSpacing get spacing =>
      Theme.of(this).extension<AppSpacing>() ??
      const AppSpacing(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48);

  /// Convenience: check if dark mode is active
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get the current color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
