import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// 이용약관 화면
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '이용약관',
          style: AppTypography.titleLarge(textColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '에덴 서비스 이용약관',
              style: AppTypography.headlineMedium(textColor),
            ),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              '시행일: 2026년 3월 6일',
              style: AppTypography.bodySmall(subTextColor),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            _buildSection(
              title: '제1조 (목적)',
              content:
                  '본 약관은 에덴(이하 "서비스")이 제공하는 성경 묵상 관련 서비스의 '
                  '이용 조건 및 절차, 이용자와 서비스 간의 권리, 의무 및 책임 사항을 규정함을 목적으로 합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제2조 (서비스의 내용)',
              content:
                  '서비스는 다음의 기능을 제공합니다.\n\n'
                  '- 성경 말씀 묵상 및 학습\n'
                  '- 퀴즈를 통한 복습\n'
                  '- 일일 스트릭 및 포인트 시스템\n'
                  '- 커뮤니티 기능 (교회 연결)\n'
                  '- 정원 꾸미기 및 캐릭터 성장',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제3조 (이용자의 의무)',
              content:
                  '이용자는 서비스 이용 시 다음 사항을 준수해야 합니다.\n\n'
                  '- 타인의 정보를 도용하지 않을 것\n'
                  '- 서비스 운영을 방해하지 않을 것\n'
                  '- 불법적이거나 부적절한 콘텐츠를 게시하지 않을 것',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제4조 (서비스의 변경 및 중단)',
              content:
                  '서비스는 운영상 필요한 경우 서비스의 전부 또는 일부를 변경하거나 '
                  '중단할 수 있으며, 이 경우 사전에 공지합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제5조 (면책)',
              content:
                  '서비스는 무료로 제공되며, 서비스 이용으로 발생한 손해에 대해 '
                  '법적 책임을 지지 않습니다. 다만, 서비스의 고의 또는 중과실에 의한 경우는 예외로 합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제6조 (분쟁 해결)',
              content:
                  '본 약관과 관련한 분쟁은 대한민국 법률에 따라 해결하며, '
                  '관할 법원은 서비스 운영자의 소재지를 관할하는 법원으로 합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            const SizedBox(height: AppTheme.spacingXXL),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.titleMedium(textColor),
          ),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            content,
            style: AppTypography.bodyMedium(subTextColor),
          ),
        ],
      ),
    );
  }
}
