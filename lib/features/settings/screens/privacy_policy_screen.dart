import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// 개인정보 처리방침 화면
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          '개인정보 처리방침',
          style: AppTypography.titleLarge(textColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '에덴 개인정보 처리방침',
              style: AppTypography.headlineMedium(textColor),
            ),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              '시행일: 2026년 3월 6일',
              style: AppTypography.bodySmall(subTextColor),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            _buildSection(
              title: '1. 수집하는 개인정보',
              content:
                  '에덴은 서비스 제공을 위해 다음의 개인정보를 수집합니다.\n\n'
                  '- 이름 (닉네임)\n'
                  '- 이메일 주소 (소셜 로그인 시)\n'
                  '- 교회 정보 (선택)\n'
                  '- 알림 설정 시간\n'
                  '- 앱 사용 기록 (학습 진행도, 스트릭 등)',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '2. 개인정보의 이용 목적',
              content:
                  '수집된 개인정보는 다음의 목적을 위해 이용됩니다.\n\n'
                  '- 서비스 제공 및 개인화\n'
                  '- 학습 진도 및 스트릭 관리\n'
                  '- 푸시 알림 전송\n'
                  '- 서비스 개선 및 통계 분석',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '3. 개인정보의 보유 및 이용 기간',
              content:
                  '이용자의 개인정보는 서비스 이용 기간 동안 보유되며, '
                  '회원 탈퇴 시 지체 없이 파기합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '4. 개인정보의 제3자 제공',
              content:
                  '에덴은 이용자의 동의 없이 개인정보를 제3자에게 제공하지 않습니다. '
                  '다만, 법령에 의한 경우는 예외로 합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '5. 이용자의 권리',
              content:
                  '이용자는 언제든지 자신의 개인정보를 조회, 수정, 삭제할 수 있으며, '
                  '회원 탈퇴를 통해 개인정보 처리 정지를 요청할 수 있습니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '6. 문의',
              content:
                  '개인정보 처리방침에 관한 문의사항은 앱 내 설정 > 문의하기를 통해 연락해 주세요.',
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
