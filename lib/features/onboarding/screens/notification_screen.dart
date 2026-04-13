import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/onboarding_provider.dart';

/// 온보딩 - 알림 시간 설정 화면
class OnboardingNotificationScreen extends ConsumerStatefulWidget {
  const OnboardingNotificationScreen({super.key});

  @override
  ConsumerState<OnboardingNotificationScreen> createState() =>
      _OnboardingNotificationScreenState();
}

class _OnboardingNotificationScreenState
    extends ConsumerState<OnboardingNotificationScreen> {
  int _hour = 8;
  int _minute = 0;

  void _incrementHour() {
    setState(() {
      _hour = (_hour + 1) % 24;
    });
  }

  void _decrementHour() {
    setState(() {
      _hour = (_hour - 1 + 24) % 24;
    });
  }

  void _incrementMinute() {
    setState(() {
      _minute = (_minute + 10) % 60;
    });
  }

  void _decrementMinute() {
    setState(() {
      _minute = (_minute - 10 + 60) % 60;
    });
  }

  void _handleNext() {
    ref.read(onboardingProvider.notifier).setNotificationTime(_hour, _minute);
    context.go('/onboarding/complete');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.spacing3XL),

              // 진행 표시 (4/5)
              _buildProgressIndicator(4, 5),
              const SizedBox(height: AppTheme.spacingMD),

              // 건너뛰기 버튼
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go('/onboarding/complete'),
                  child: Text(
                    '건너뛰기',
                    style: AppTypography.bodyMedium(subTextColor),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // 알림 아이콘
              const Icon(
                Icons.notifications_outlined,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 타이틀
              Text(
                '언제 알림을 보내줄까?',
                style: AppTypography.headlineLarge(textColor),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                '매일 묵상 시간을 잊지 않도록 알려줄게요',
                style: AppTypography.bodyMedium(subTextColor),
              ),
              const SizedBox(height: AppTheme.spacing3XL),

              // 시간 선택기
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingXXL,
                    vertical: AppTheme.spacingXL,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 시간
                      _buildTimeColumn(
                        value: _hour.toString().padLeft(2, '0'),
                        onIncrement: _incrementHour,
                        onDecrement: _decrementHour,
                        textColor: textColor,
                      ),

                      // 구분자
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingLG,
                        ),
                        child: Text(
                          ':',
                          style: AppTypography.pointDisplay(textColor),
                        ),
                      ),

                      // 분
                      _buildTimeColumn(
                        value: _minute.toString().padLeft(2, '0'),
                        onIncrement: _incrementMinute,
                        onDecrement: _decrementMinute,
                        textColor: textColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppTheme.spacingLG),

              // 시간대 안내
              Center(
                child: Text(
                  _hour < 12
                      ? '오전 ${_hour == 0 ? 12 : _hour}시 ${_minute.toString().padLeft(2, '0')}분'
                      : '오후 ${_hour == 12 ? 12 : _hour - 12}시 ${_minute.toString().padLeft(2, '0')}분',
                  style: AppTypography.bodyMedium(subTextColor),
                ),
              ),

              const Spacer(),

              // 다음 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  child: Text('다음', style: AppTypography.button(Colors.white)),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn({
    required String value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required Color textColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onIncrement,
          icon: Icon(Icons.keyboard_arrow_up, color: textColor, size: 32),
        ),
        Text(value, style: AppTypography.pointDisplay(textColor)),
        IconButton(
          onPressed: onDecrement,
          icon: Icon(Icons.keyboard_arrow_down, color: textColor, size: 32),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(int current, int total) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index < current;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index < total - 1 ? 4 : 0),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
