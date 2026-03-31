import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Glass-style card with semi-transparent background.
///
/// Adapts to light/dark mode using [AppColors].
/// Uses simple opacity instead of BackdropFilter for performance.
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

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blurAmount;
  final double? opacity;
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

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: effectiveBorder,
      ),
      padding: padding,
      child: child,
    );
  }
}
