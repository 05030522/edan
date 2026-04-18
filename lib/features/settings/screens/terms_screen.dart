import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/context_theme.dart';

/// 이용약관 화면
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = context.textPrimary;
    final subTextColor = context.textSecondary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('이용약관', style: AppTypography.titleLarge(textColor)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('에덴 서비스 이용약관', style: AppTypography.headlineMedium(textColor)),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              '시행일: 2026년 5월 1일',
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
                  '- 일일 연속 묵상 및 포인트 시스템\n'
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
                  '- 불법적이거나 부적절한 콘텐츠를 게시하지 않을 것\n'
                  '- 타 종교 또는 이용자를 비방하지 않을 것',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제4조 (회원 가입 및 탈퇴)',
              content:
                  '회원가입은 소셜 로그인(카카오/구글/네이버)을 통해 이루어집니다.\n\n'
                  '만 14세 미만은 법정대리인의 동의가 필요합니다.\n\n'
                  '이용자는 언제든지 [설정 > 회원 탈퇴]를 통해 계정을 삭제할 수 있으며, '
                  '탈퇴 시 모든 개인정보와 학습 기록은 지체 없이 파기됩니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제5조 (서비스 요금)',
              content:
                  '에덴의 모든 기능은 무료로 제공됩니다. '
                  '향후 유료 기능이 도입될 경우 사전에 공지하며, '
                  '기존 무료 기능은 계속 무료로 유지됩니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제6조 (저작권)',
              content:
                  '서비스 내 제공되는 성경 본문은 공적 저작권 또는 이용 허가된 번역본을 사용합니다.\n\n'
                  '이용자가 작성한 묵상 기록, 기도, 댓글 등 콘텐츠의 저작권은 '
                  '해당 이용자에게 귀속되며, 서비스는 이를 서비스 운영 범위 내에서만 이용합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제7조 (서비스의 변경 및 중단)',
              content:
                  '서비스는 운영상 필요한 경우 서비스의 전부 또는 일부를 변경하거나 '
                  '중단할 수 있으며, 이 경우 사전에 앱 내 공지 또는 이메일을 통해 고지합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제8조 (약관의 변경)',
              content:
                  '본 약관은 관련 법령 및 서비스 정책에 따라 변경될 수 있으며, '
                  '변경 시 시행일 최소 7일 전에 앱 내 공지합니다. '
                  '이용자가 변경된 약관에 동의하지 않는 경우 서비스 이용을 중단하고 탈퇴할 수 있습니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제9조 (면책)',
              content:
                  '서비스는 무료로 제공되며, 서비스 이용으로 발생한 손해에 대해 '
                  '법적 책임을 지지 않습니다. 다만, 서비스의 고의 또는 중과실에 의한 경우는 예외로 합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '제10조 (분쟁 해결)',
              content:
                  '본 약관과 관련한 분쟁은 대한민국 법률에 따라 해결하며, '
                  '관할 법원은 서비스 운영자의 소재지를 관할하는 법원으로 합니다.\n\n'
                  '문의처: kjinhx96@gmail.com',
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
          Text(title, style: AppTypography.titleMedium(textColor)),
          const SizedBox(height: AppTheme.spacingSM),
          Text(content, style: AppTypography.bodyMedium(subTextColor)),
        ],
      ),
    );
  }
}
