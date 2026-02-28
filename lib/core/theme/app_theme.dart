import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// 에덴 앱 테마
/// Material 3 기반, Sacred & Cute 디자인
class AppTheme {
  AppTheme._();

  // ─── 공통 상수 ───
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXLarge = 20;
  static const double radiusRound = 100;

  static const double spacingXS = 4;
  static const double spacingSM = 8;
  static const double spacingMD = 12;
  static const double spacingLG = 16;
  static const double spacingXL = 24;
  static const double spacingXXL = 32;
  static const double spacing3XL = 48;

  // ─── 라이트 테마 ───
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.gold,
        tertiary: AppColors.purple,
        surface: AppColors.lightBackground,
        error: AppColors.error,
        onPrimary: AppColors.lightTextPrimary,
        onSecondary: AppColors.lightTextPrimary,
        onSurface: AppColors.lightTextPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
        titleTextStyle: AppTypography.titleLarge(AppColors.lightTextPrimary),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge(AppColors.lightTextPrimary),
        displayMedium: AppTypography.displayMedium(AppColors.lightTextPrimary),
        headlineLarge: AppTypography.headlineLarge(AppColors.lightTextPrimary),
        headlineMedium: AppTypography.headlineMedium(AppColors.lightTextPrimary),
        titleLarge: AppTypography.titleLarge(AppColors.lightTextPrimary),
        titleMedium: AppTypography.titleMedium(AppColors.lightTextPrimary),
        bodyLarge: AppTypography.bodyLarge(AppColors.lightTextPrimary),
        bodyMedium: AppTypography.bodyMedium(AppColors.lightTextPrimary),
        bodySmall: AppTypography.bodySmall(AppColors.lightTextSecondary),
        labelLarge: AppTypography.button(AppColors.lightTextPrimary),
        labelSmall: AppTypography.label(AppColors.lightTextTertiary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightTextPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
          textStyle: AppTypography.button(AppColors.lightTextPrimary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTypography.bodyMedium(AppColors.lightTextTertiary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXLarge),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.lightTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBackgroundSecondary,
        thickness: 1,
      ),
    );
  }

  // ─── 다크 테마 ───
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.gold,
        tertiary: AppColors.purple,
        surface: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: AppColors.darkTextPrimary,
        onSecondary: AppColors.darkTextPrimary,
        onSurface: AppColors.darkTextPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: AppTypography.titleLarge(AppColors.darkTextPrimary),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge(AppColors.darkTextPrimary),
        displayMedium: AppTypography.displayMedium(AppColors.darkTextPrimary),
        headlineLarge: AppTypography.headlineLarge(AppColors.darkTextPrimary),
        headlineMedium: AppTypography.headlineMedium(AppColors.darkTextPrimary),
        titleLarge: AppTypography.titleLarge(AppColors.darkTextPrimary),
        titleMedium: AppTypography.titleMedium(AppColors.darkTextPrimary),
        bodyLarge: AppTypography.bodyLarge(AppColors.darkTextPrimary),
        bodyMedium: AppTypography.bodyMedium(AppColors.darkTextPrimary),
        bodySmall: AppTypography.bodySmall(AppColors.darkTextSecondary),
        labelLarge: AppTypography.button(AppColors.darkTextPrimary),
        labelSmall: AppTypography.label(AppColors.darkTextTertiary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightTextPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTypography.bodyMedium(AppColors.darkTextTertiary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXLarge),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackgroundSecondary,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBackgroundSecondary,
        thickness: 1,
      ),
    );
  }
}
