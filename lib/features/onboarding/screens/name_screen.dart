import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// 온보딩 - 이름 입력 화면
class OnboardingNameScreen extends ConsumerStatefulWidget {
  const OnboardingNameScreen({super.key});

  @override
  ConsumerState<OnboardingNameScreen> createState() =>
      _OnboardingNameScreenState();
}

class _OnboardingNameScreenState extends ConsumerState<OnboardingNameScreen> {
  final _nameController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleNext() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorText = '이름을 입력해주세요';
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    // TODO: 프로필에 이름 저장
    context.go('/onboarding/church');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.spacing3XL),

              // 진행 표시
              _buildProgressIndicator(1, 4),
              const SizedBox(height: AppTheme.spacing3XL),

              // 램비 캐릭터 아이콘
              const Icon(
                Icons.pets,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 타이틀
              Text(
                '안녕~ 나는 램비야!\n이름이 뭐야?',
                style: AppTypography.headlineLarge(textColor),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                '에덴에서 사용할 이름을 알려주세요',
                style: AppTypography.bodyMedium(subTextColor),
              ),
              const SizedBox(height: AppTheme.spacingXXL),

              // 이름 입력
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '이름을 입력하세요',
                  prefixIcon: const Icon(Icons.person_outlined),
                  errorText: _errorText,
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleNext(),
              ),

              const Spacer(),

              // 다음 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  child: Text(
                    '다음',
                    style: AppTypography.button(AppColors.lightTextPrimary),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
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
