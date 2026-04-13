import 'package:flutter/material.dart';

import '../../core/services/social_auth_service.dart';
import '../../core/theme/app_typography.dart';

/// 소셜 로그인 버튼 위젯
/// 카카오(노란색), 구글(흰색), 네이버(녹색) 브랜드 가이드라인 준수
class SocialLoginButton extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final brandInfo = SocialAuthService.getProviderBrandInfo(provider);
    final Color bgColor = brandInfo['color'];
    final Color textColor = brandInfo['textColor'];
    final String label = brandInfo['label'];

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: provider == SocialProvider.google ? 1 : 0,
          shadowColor: provider == SocialProvider.google
              ? Colors.black.withValues(alpha: 0.2)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: provider == SocialProvider.google
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 소셜 아이콘
                  _buildIcon(provider, textColor),
                  const SizedBox(width: 12),
                  // 로그인 텍스트
                  Text(
                    label,
                    style: AppTypography.button(
                      textColor,
                    ).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildIcon(SocialProvider provider, Color color) {
    switch (provider) {
      case SocialProvider.kakao:
        return _KakaoIcon();
      case SocialProvider.google:
        return _GoogleIcon();
      case SocialProvider.naver:
        return _NaverIcon();
    }
  }
}

/// 카카오 아이콘 (말풍선)
class _KakaoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _KakaoIconPainter()),
    );
  }
}

class _KakaoIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF191919)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2 - 1;
    final rx = size.width * 0.45;
    final ry = size.height * 0.35;

    // 말풍선 몸체 (타원)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
      paint,
    );

    // 말풍선 꼬리
    final tailPath = Path()
      ..moveTo(cx - 2, cy + ry - 1)
      ..lineTo(cx - 4, size.height)
      ..lineTo(cx + 3, cy + ry - 1)
      ..close();
    canvas.drawPath(tailPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 구글 아이콘 (G 로고)
class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 파란색 (오른쪽 위)
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      -0.4, // 시작 각도
      -1.8, // 호 길이
      false,
      bluePaint,
    );

    // 빨간색 (오른쪽 아래)
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      -0.4,
      1.2,
      false,
      redPaint,
    );

    // 노란색 (아래)
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      0.8,
      1.2,
      false,
      yellowPaint,
    );

    // 초록색 (왼쪽)
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      2.0,
      1.2,
      false,
      greenPaint,
    );

    // 가운데 가로선 (파란색)
    final linePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(center.dx - 1, center.dy - 1.5, radius, 3),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 네이버 아이콘 (N 로고)
class _NaverIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _NaverIconPainter()),
    );
  }
}

class _NaverIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final margin = w * 0.15;

    // N 글자
    final path = Path()
      // 왼쪽 세로선
      ..moveTo(margin, h - margin)
      ..lineTo(margin, margin)
      ..lineTo(margin + w * 0.15, margin)
      // 대각선
      ..lineTo(w - margin - w * 0.15, h - margin)
      // 오른쪽 세로선
      ..lineTo(w - margin - w * 0.15, margin)
      ..lineTo(w - margin, margin)
      ..lineTo(w - margin, h - margin)
      ..lineTo(w - margin - w * 0.15, h - margin)
      // 대각선 되돌아오기
      ..lineTo(margin + w * 0.15, margin)
      ..lineTo(margin + w * 0.15, h - margin)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 소셜 로그인 버튼 그룹
/// 구분선과 함께 3개 소셜 로그인 버튼을 표시
class SocialLoginButtonGroup extends StatelessWidget {
  final void Function(SocialProvider provider) onSocialLogin;
  final SocialProvider? loadingProvider;

  const SocialLoginButtonGroup({
    super.key,
    required this.onSocialLogin,
    this.loadingProvider,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;
    final orTextColor = isDark ? Colors.white54 : Colors.black45;

    return Column(
      children: [
        // 구분선 "또는"
        Row(
          children: [
            Expanded(child: Divider(color: dividerColor, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '또는',
                style: TextStyle(
                  color: orTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Divider(color: dividerColor, thickness: 1)),
          ],
        ),
        const SizedBox(height: 20),

        // 카카오 로그인
        SocialLoginButton(
          provider: SocialProvider.kakao,
          onPressed: () => onSocialLogin(SocialProvider.kakao),
          isLoading: loadingProvider == SocialProvider.kakao,
        ),
        const SizedBox(height: 10),

        // 구글 로그인
        SocialLoginButton(
          provider: SocialProvider.google,
          onPressed: () => onSocialLogin(SocialProvider.google),
          isLoading: loadingProvider == SocialProvider.google,
        ),
        const SizedBox(height: 10),

        // 네이버 로그인
        SocialLoginButton(
          provider: SocialProvider.naver,
          onPressed: () => onSocialLogin(SocialProvider.naver),
          isLoading: loadingProvider == SocialProvider.naver,
        ),
      ],
    );
  }
}
