import 'dart:ui';
import 'package:flutter/material.dart';

/// Design system spacing tokens (8px base grid)
///
/// Extends [ThemeExtension] for seamless integration with Material theme.
/// Access via: `Theme.of(context).extension<AppSpacing>()?.md ?? 0`
class AppSpacing extends ThemeExtension<AppSpacing> {
  /// xs: 4px - micro spacing (icon gaps, inline elements)
  final double xs;

  /// sm: 8px - small spacing (padding inside cards, tight groups)
  final double sm;

  /// md: 16px - medium spacing (default padding, component separation)
  final double md;

  /// lg: 24px - large spacing (section separation)
  final double lg;

  /// xl: 32px - extra large spacing (major section gaps)
  final double xl;

  /// xxl: 48px - double extra large (screen padding, major gaps)
  final double xxl;

  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
    );
  }
}
