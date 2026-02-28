import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 에덴 앱 타이포그래피
/// UI: Pretendard (google_fonts 통해 Noto Sans KR 대체)
/// 성경 구절: Noto Serif KR
class AppTypography {
  AppTypography._();

  /// UI 텍스트 스타일 (Noto Sans KR - Pretendard 대체)
  static TextStyle get _baseUI => GoogleFonts.notoSansKr();

  /// 성경 구절 전용 스타일 (Noto Serif KR)
  static TextStyle get _baseScripture => GoogleFonts.notoSerifKr();

  // ─── 디스플레이 ───
  static TextStyle displayLarge(Color color) => _baseUI.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle displayMedium(Color color) => _baseUI.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: color,
      );

  // ─── 헤드라인 ───
  static TextStyle headlineLarge(Color color) => _baseUI.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle headlineMedium(Color color) => _baseUI.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ─── 타이틀 ───
  static TextStyle titleLarge(Color color) => _baseUI.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle titleMedium(Color color) => _baseUI.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ─── 본문 ───
  static TextStyle bodyLarge(Color color) => _baseUI.copyWith(
        fontSize: 16,
        color: color,
        height: 1.6,
      );

  static TextStyle bodyMedium(Color color) => _baseUI.copyWith(
        fontSize: 14,
        color: color,
        height: 1.6,
      );

  static TextStyle bodySmall(Color color) => _baseUI.copyWith(
        fontSize: 12,
        color: color,
      );

  // ─── 성경 구절 ───
  static TextStyle scripture(Color color) => _baseScripture.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.8,
        letterSpacing: 0.3,
      );

  static TextStyle scriptureReference(Color color) => _baseScripture.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      );

  // ─── 포인트/숫자 ───
  static TextStyle pointDisplay(Color color) => _baseUI.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle streakNumber(Color color) => _baseUI.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // ─── 버튼 ───
  static TextStyle button(Color color) => _baseUI.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ─── 레이블 ───
  static TextStyle label(Color color) => _baseUI.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
