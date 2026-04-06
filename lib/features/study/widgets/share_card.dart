import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/luyang_image.dart';

/// 묵상 완료 공유카드 위젯
/// RepaintBoundary 키로 이미지 캡처 가능
class ShareCard extends StatelessWidget {
  const ShareCard({
    super.key,
    required this.date,
    required this.scriptureReference,
    required this.scriptureText,
    required this.lessonTitle,
  });

  final String date;
  final String scriptureReference;
  final String scriptureText;
  final String lessonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingXXL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2D3436), // 다크 슬레이트
            Color(0xFF1A1A2E), // 딥 네이비
            Color(0xFF16213E), // 미드나잇 블루
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ━━━ 상단: 앱 이름 + 날짜 ━━━
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 에덴 로고 + 루양
              Row(
                children: [
                  const LuyangImage(
                    size: 32,
                    backgroundColor: Color(0x40FFFFFF),
                    shadow: false,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '에덴 묵상',
                    style: AppTypography.titleMedium(
                      Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),

              // 날짜
              Text(
                date,
                style: AppTypography.label(
                  Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingXXL),

          // ━━━ 묵상 주제 ━━━
          Text(
            lessonTitle,
            style: AppTypography.headlineMedium(
              Colors.white.withValues(alpha: 0.85),
            ),
          ),

          const SizedBox(height: AppTheme.spacingXL),

          // ━━━ 성경 구절 ━━━
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border(
                left: BorderSide(
                  color: AppColors.gold.withValues(alpha: 0.6),
                  width: 3,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scriptureText,
                  style: AppTypography.scripture(
                    Colors.white.withValues(alpha: 0.9),
                  ).copyWith(fontSize: 16, height: 1.7),
                ),
                const SizedBox(height: AppTheme.spacingMD),
                Text(
                  '- $scriptureReference',
                  style: AppTypography.scriptureReference(
                    AppColors.gold.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppTheme.spacingXXL),

          // ━━━ 하단: 장식 라인 ━━━
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '🕊️',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingLG),

          // 앱 CTA 영역
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingMD,
              horizontal: AppTheme.spacingMD,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LuyangImage(
                  size: 28,
                  backgroundColor: Color(0x40FFFFFF),
                  shadow: false,
                ),
                const SizedBox(width: 8),
                Text(
                  '에덴에서 나도 묵상하기',
                  style: AppTypography.label(
                    Colors.white.withValues(alpha: 0.7),
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
