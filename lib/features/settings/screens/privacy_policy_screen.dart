import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/context_theme.dart';

/// 개인정보 처리방침 화면
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
        title: Text('개인정보 처리방침', style: AppTypography.titleLarge(textColor)),
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
              '시행일: 2026년 5월 1일',
              style: AppTypography.bodySmall(subTextColor),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            _buildSection(
              title: '1. 수집하는 개인정보 항목',
              content:
                  '에덴(이하 "서비스")은 서비스 제공을 위해 다음의 개인정보를 수집합니다.\n\n'
                  '【필수 항목】\n'
                  '- 이름(닉네임)\n'
                  '- 이메일 주소 (소셜 로그인 시 자동 수집)\n'
                  '- 소셜 로그인 고유 식별자 (카카오/구글/네이버)\n\n'
                  '【선택 항목】\n'
                  '- 교회 정보 (커뮤니티 기능 이용 시)\n'
                  '- 프로필 사진\n'
                  '- 알림 수신 시간\n\n'
                  '【자동 수집 항목】\n'
                  '- 학습 진행도, 연속 묵상 기록, 퀴즈 결과\n'
                  '- 앱 사용 로그, 오류 발생 기록 (Sentry)\n'
                  '- 기기 정보 (OS 종류, 앱 버전)',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '2. 개인정보의 이용 목적',
              content:
                  '수집된 개인정보는 다음의 목적을 위해 이용됩니다.\n\n'
                  '- 회원 가입 및 본인 식별\n'
                  '- 서비스 제공 및 개인화\n'
                  '- 학습 진도 및 연속 묵상 관리\n'
                  '- 푸시 알림 전송 (선택 시)\n'
                  '- 서비스 개선, 오류 분석, 통계 분석',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '3. 개인정보의 보유 및 이용 기간',
              content:
                  '이용자의 개인정보는 서비스 이용 기간 동안 보유되며, '
                  '회원 탈퇴 시 지체 없이 파기합니다.\n\n'
                  '다만, 관계 법령에 따라 보존이 필요한 경우 해당 기간 동안 보관합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '4. 개인정보 처리 위탁',
              content:
                  '서비스는 원활한 기능 제공을 위해 아래와 같이 개인정보 처리 업무를 위탁하고 있습니다.\n\n'
                  '【Supabase, Inc. (미국)】\n'
                  '- 위탁 업무: 회원 데이터 저장, 인증, 데이터베이스 운영\n'
                  '- 보유 기간: 회원 탈퇴 시까지\n\n'
                  '【Functional Software, Inc. (Sentry, 미국)】\n'
                  '- 위탁 업무: 앱 오류 및 크래시 수집·분석\n'
                  '- 보유 기간: 90일\n\n'
                  '【카카오, 구글, 네이버】\n'
                  '- 위탁 업무: 소셜 로그인 인증\n'
                  '- 보유 기간: 각 서비스 정책에 따름',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '5. 개인정보의 제3자 제공',
              content:
                  '에덴은 이용자의 동의 없이 개인정보를 제3자에게 제공하지 않습니다. '
                  '다만, 법령에 의한 경우는 예외로 합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '6. 이용자 및 법정대리인의 권리',
              content:
                  '이용자는 언제든지 자신의 개인정보를 조회, 수정, 삭제할 수 있으며, '
                  '회원 탈퇴를 통해 개인정보 처리 정지를 요청할 수 있습니다.\n\n'
                  '회원 탈퇴는 [설정 > 회원 탈퇴] 메뉴 또는 아래 문의처로 요청할 수 있으며, '
                  '요청 접수 후 지체 없이 개인정보를 파기합니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '7. 만 14세 미만 아동의 개인정보',
              content:
                  '에덴은 만 14세 미만 아동의 회원가입을 제한합니다.\n\n'
                  '만 14세 미만 아동이 서비스를 이용하고자 할 경우, '
                  '법정대리인의 동의를 받은 후 이용이 가능하며, '
                  '법정대리인은 아동의 개인정보 열람·수정·삭제를 요구할 수 있습니다.',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '8. 개인정보의 안전성 확보 조치',
              content:
                  '- 전송 구간 암호화 (HTTPS/TLS)\n'
                  '- 비밀번호 저장 시 일방향 암호화\n'
                  '- 접근 권한 최소화 및 주기적 점검\n'
                  '- 개인정보 처리자 교육',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '9. 개인정보 보호책임자 및 문의',
              content:
                  '개인정보 처리방침에 관한 문의사항은 아래로 연락해 주세요.\n\n'
                  '- 개인정보 보호책임자: 권진혁 (Kwon Jinhyuk)\n'
                  '- 이메일: kjinhx96@gmail.com\n'
                  '- 사업자등록번호: 462-16-02793\n\n'
                  '개인정보 침해에 관한 신고나 상담이 필요한 경우 아래 기관에 문의하실 수 있습니다.\n'
                  '- 개인정보 침해신고센터: privacy.kisa.or.kr / 국번없이 118\n'
                  '- 대검찰청 사이버수사과: spo.go.kr / 국번없이 1301',
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            _buildSection(
              title: '10. 개정 이력',
              content:
                  '- 2026년 5월 1일: 최초 시행 (v1.0)\n\n'
                  '본 개인정보 처리방침은 시행일로부터 적용되며, '
                  '변경 시 앱 내 공지 또는 이메일을 통해 사전 고지합니다.',
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
