import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 다크/라이트 모드별 공용 컬러를 한 줄로 쓰게 해주는 BuildContext 확장.
///
/// Before:
///   final isDark = Theme.of(context).brightness == Brightness.dark;
///   final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
///
/// After:
///   final textColor = context.textPrimary;
extension EdenThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  Color get textTertiary =>
      isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary;

  Color get bg => isDark ? AppColors.darkBackground : AppColors.lightBackground;

  Color get bgSecondary => isDark
      ? AppColors.darkBackgroundSecondary
      : AppColors.lightBackgroundSecondary;

  Color get card => isDark ? AppColors.darkCard : AppColors.lightCard;
}
