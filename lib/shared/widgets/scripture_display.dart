import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Displays a Bible verse with a gold left border and serif typography.
///
/// The widget uses [AppTypography.scripture] for the verse body and
/// [AppTypography.scriptureReference] for the reference line.
class ScriptureDisplay extends StatelessWidget {
  const ScriptureDisplay({
    super.key,
    required this.text,
    required this.reference,
    this.padding,
    this.backgroundColor,
    this.borderWidth = 4.0,
    this.borderColor,
  });

  /// The scripture/verse text.
  final String text;

  /// The book, chapter, and verse reference (e.g. "Genesis 1:1").
  final String reference;

  /// Outer padding around the widget. Defaults to `EdgeInsets.all(16)`.
  final EdgeInsetsGeometry? padding;

  /// Optional background color behind the verse block.
  final Color? backgroundColor;

  /// Width of the left gold border. Defaults to 4.
  final double borderWidth;

  /// Color of the left border. Defaults to [AppColors.gold].
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final Color refColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final Color effectiveBorderColor = borderColor ?? AppColors.gold;
    final Color effectiveBackground = backgroundColor ??
        (isDark
            ? AppColors.darkCard
            : AppColors.lightCard);

    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: effectiveBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gold left border
            Container(
              width: borderWidth,
              decoration: BoxDecoration(
                color: effectiveBorderColor,
                borderRadius: BorderRadius.circular(borderWidth / 2),
              ),
            ),
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: AppTypography.scripture(textColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    reference,
                    style: AppTypography.scriptureReference(refColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
