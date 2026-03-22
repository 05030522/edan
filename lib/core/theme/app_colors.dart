import 'package:flutter/material.dart';

/// 에덴 앱 컬러 팔레트
/// Sacred & Cute 디자인 시스템
class AppColors {
  AppColors._();

  // ─── 메인 컬러 ───
  static const Color primary = Color(0xFFB8D4BE); // 에덴 녹색
  static const Color primaryDark = Color(0xFF7BA884);
  static const Color gold = Color(0xFFE5C88E); // 언약 금색
  static const Color pink = Color(0xFFF2E2E2); // 은혜 핑크
  static const Color purple = Color(0xFFD4D0E6); // 셀라 보라

  // ─── 라이트 모드 ───
  static const Color lightBackground = Color(0xFFFDF6ED); // 새벽빛
  static const Color lightBackgroundSecondary = Color(0xFFF5EDE3);
  static const Color lightTextPrimary = Color(0xFF2D2A3A);
  static const Color lightTextSecondary = Color(0xFF5D5A6D);
  static const Color lightTextTertiary = Color(0xFF9A97A8);
  static const Color lightCard = Color(0xB3FFFFFF);

  // ─── 다크 모드 ───
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color darkBackgroundSecondary = Color(0xFF252542);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFA0A0B0);
  static const Color darkTextTertiary = Color(0xFF6A6A7A);
  static const Color darkCard = Color(0x14FFFFFF);

  // ─── 시멘틱 ───
  static const Color success = Color(0xFF7BA884);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);

  // ─── 스트릭 불꽃 ───
  static const Color streakFlame = Color(0xFFFF8A65);
  static const Color streakFlameBright = Color(0xFFFFAB40);
  static const Color streakRainbow = Color(0xFFE040FB);

  // ─── 퀴즈 ───
  static const Color quizCorrect = Color(0xFF4CAF50);
  static const Color quizCorrectDark = Color(0xFF2E7D32);
  static const Color quizIncorrectDark = Color(0xFFC62828);
  static const Color goldDark = Color(0xFFB8960A);

  // ─── 정원 레벨 ───
  static const Color gardenSoil = Color(0xFF8D6E63);
  static const Color gardenSprout = Color(0xFFA5D6A7);
  static const Color gardenFlower = Color(0xFFF48FB1);
  static const Color gardenTree = Color(0xFF66BB6A);
  static const Color gardenParadise = Color(0xFFFFD54F);
}
