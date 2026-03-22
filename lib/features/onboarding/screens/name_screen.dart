import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/supabase_constants.dart';
import '../providers/onboarding_provider.dart';

/// 닉네임 최대 글자수
const int _maxNameLength = 12;
/// 닉네임 최소 글자수
const int _minNameLength = 2;

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
  bool _isChecking = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// 닉네임 유효성 검사 (한글, 영어, 숫자만 허용)
  static final _validNameRegex = RegExp(r'^[가-힣a-zA-Z0-9]+$');

  /// Supabase에서 닉네임 중복 검사 (대소문자 무시)
  Future<bool> _isNameTaken(String name) async {
    try {
      final result = await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .select('id')
          .ilike('display_name', name)
          .limit(1);
      return (result as List).isNotEmpty;
    } catch (e) {
      // 오류 시 중복 없는 것으로 처리 (사용자 경험 우선)
      return false;
    }
  }

  Future<void> _handleNext() async {
    final name = _nameController.text.trim();

    // 최소 글자 수 검사
    if (name.length < _minNameLength) {
      setState(() {
        _errorText = '이름은 $_minNameLength자 이상이어야 해요';
      });
      return;
    }

    // 허용 문자 검사 (한글, 영어, 숫자만)
    if (!_validNameRegex.hasMatch(name)) {
      setState(() {
        _errorText = '한글, 영어, 숫자만 사용할 수 있어요';
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isChecking = true;
    });

    // 중복 검사
    final taken = await _isNameTaken(name);

    if (!mounted) return;

    if (taken) {
      setState(() {
        _errorText = '이미 사용 중인 이름이에요. 다른 이름을 입력해주세요';
        _isChecking = false;
      });
      return;
    }

    setState(() => _isChecking = false);

    ref.read(onboardingProvider.notifier).setName(name);
    if (mounted) context.go('/onboarding/photo');
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

    final currentLength = _nameController.text.length;

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

              // 진행 표시 (1/5)
              _buildProgressIndicator(1, 5),
              const SizedBox(height: AppTheme.spacing3XL),

              // 에덴 아이콘
              const Icon(
                Icons.eco,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 타이틀
              Text(
                '에덴에서 사용할\n이름을 알려주세요',
                style: AppTypography.headlineLarge(textColor),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                '최소 ${_minNameLength}자 · 최대 ${_maxNameLength}자',
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
                  counterText: '$currentLength / $_maxNameLength',
                  suffixIcon: _isChecking
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleNext(),
                autofocus: true,
                maxLength: _maxNameLength,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                onChanged: (_) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[가-힣a-zA-Z0-9]'), // 한글, 영어, 숫자만 허용
                  ),
                ],
              ),

              const Spacer(),

              // 다음 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isChecking ? null : _handleNext,
                  child: _isChecking
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          '다음',
                          style: AppTypography.button(Colors.white),
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
