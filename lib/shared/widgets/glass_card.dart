import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Glass morphism card with semi-transparent backdrop blur.
///
/// Adapts to light/dark mode using [AppColors].
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
    this.blurAmount = 10.0,
    this.opacity,
    this.border,
  });

  /// The widget displayed inside the card.
  final Widget child;

  /// Inner padding around [child].
  final EdgeInsetsGeometry padding;

  /// Corner radius of the card. Defaults to 20.
  final double borderRadius;

  /// Sigma value for the backdrop blur. Defaults to 10.
  final double blurAmount;

  /// Background opacity override. When null the card uses the theme
  /// brightness to pick a sensible default (0.7 for light, 0.08 for dark).
  final double? opacity;

  /// Optional border. When null a subtle white/dark border is used.
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? Colors.white.withValues(alpha: opacity ?? 0.08)
        : Colors.white.withValues(alpha: opacity ?? 0.7);

    final Border effectiveBorder = border ??
        Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
          width: 1.0,
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: effectiveBorder,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
