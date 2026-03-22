import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Unified button widget for the Eden app with primary, secondary, and text
/// variants plus loading and disabled states.
class EdenButton extends StatelessWidget {
  const EdenButton._({
    super.key,
    required this.label,
    required this.onPressed,
    required this.variant,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = false,
    this.icon,
  });

  // ─── Named constructors ───

  /// Filled button with primary (Eden green) background.
  const factory EdenButton.primary({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool isLoading,
    bool isDisabled,
    bool fullWidth,
    IconData? icon,
  }) = _PrimaryButton;

  /// Outlined button with primary border.
  const factory EdenButton.secondary({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool isLoading,
    bool isDisabled,
    bool fullWidth,
    IconData? icon,
  }) = _SecondaryButton;

  /// Text-only button.
  const factory EdenButton.text({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool isLoading,
    bool isDisabled,
    bool fullWidth,
    IconData? icon,
  }) = _TextButton;

  final String label;
  final VoidCallback? onPressed;
  // ignore: library_private_types_in_public_api
  final _EdenButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;
  final IconData? icon;

  bool get _enabled => !isDisabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    final Widget child = _buildChild(context, isDark, textPrimary);

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: child,
      );
    }
    return child;
  }

  Widget _buildChild(BuildContext context, bool isDark, Color textPrimary) {
    final Widget labelWidget = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == _EdenButtonVariant.primary
                    ? Colors.white
                    : AppColors.primary,
              ),
            ),
          )
        : _buildLabel(isDark, textPrimary);

    switch (variant) {
      case _EdenButtonVariant.primary:
        return ElevatedButton(
          onPressed: _enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            disabledBackgroundColor: AppColors.primaryDark.withValues(alpha: 0.4),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: labelWidget,
        );
      case _EdenButtonVariant.secondary:
        return OutlinedButton(
          onPressed: _enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: isDark ? AppColors.primary : AppColors.primaryDark,
            side: BorderSide(
              color: _enabled
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: labelWidget,
        );
      case _EdenButtonVariant.text:
        return TextButton(
          onPressed: _enabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: isDark ? AppColors.primary : AppColors.primaryDark,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: labelWidget,
        );
    }
  }

  Widget _buildLabel(bool isDark, Color textPrimary) {
    final Color labelColor;
    switch (variant) {
      case _EdenButtonVariant.primary:
        labelColor = Colors.white;
        break;
      case _EdenButtonVariant.secondary:
      case _EdenButtonVariant.text:
        labelColor = isDark ? AppColors.primary : AppColors.primaryDark;
        break;
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label, style: AppTypography.button(labelColor)),
        ],
      );
    }
    return Text(label, style: AppTypography.button(labelColor));
  }
}

// ─── Variant enum ───

enum _EdenButtonVariant { primary, secondary, text }

// ─── Variant subclasses (allow const factory constructors) ───

class _PrimaryButton extends EdenButton {
  const _PrimaryButton({
    super.key,
    required super.label,
    required super.onPressed,
    super.isLoading = false,
    super.isDisabled = false,
    super.fullWidth = false,
    super.icon,
  }) : super._(variant: _EdenButtonVariant.primary);
}

class _SecondaryButton extends EdenButton {
  const _SecondaryButton({
    super.key,
    required super.label,
    required super.onPressed,
    super.isLoading = false,
    super.isDisabled = false,
    super.fullWidth = false,
    super.icon,
  }) : super._(variant: _EdenButtonVariant.secondary);
}

class _TextButton extends EdenButton {
  const _TextButton({
    super.key,
    required super.label,
    required super.onPressed,
    super.isLoading = false,
    super.isDisabled = false,
    super.fullWidth = false,
    super.icon,
  }) : super._(variant: _EdenButtonVariant.text);
}
