import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// 온보딩 - 교회 선택 화면
class OnboardingChurchScreen extends ConsumerStatefulWidget {
  const OnboardingChurchScreen({super.key});

  @override
  ConsumerState<OnboardingChurchScreen> createState() =>
      _OnboardingChurchScreenState();
}

class _OnboardingChurchScreenState
    extends ConsumerState<OnboardingChurchScreen> {
  final _searchController = TextEditingController();
  String? _selectedChurch;

  // 플레이스홀더 교회 데이터
  static const List<String> _churches = [
    '사랑의교회',
    '온누리교회',
    '여의도순복음교회',
    '소망교회',
    '분당우리교회',
    '새문안교회',
    '영락교회',
    '광림교회',
  ];

  List<String> get _filteredChurches {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _churches;
    return _churches
        .where((c) => c.toLowerCase().contains(query))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleNext() {
    // TODO: 교회 정보 저장
    context.go('/onboarding/notification');
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
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;

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
              _buildProgressIndicator(2, 4),
              const SizedBox(height: AppTheme.spacing3XL),

              // 타이틀
              Text(
                '어떤 교회를 다니고 있어?',
                style: AppTypography.headlineLarge(textColor),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                '같은 교회 친구들과 함께할 수 있어요',
                style: AppTypography.bodyMedium(subTextColor),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 교회 검색
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '교회 이름을 검색하세요',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // 교회 목록
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredChurches.length,
                  itemBuilder: (context, index) {
                    final church = _filteredChurches[index];
                    final isSelected = _selectedChurch == church;
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppTheme.spacingSM,
                      ),
                      child: Material(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : cardColor,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusMedium),
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMedium),
                          onTap: () {
                            setState(() {
                              _selectedChurch = church;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingLG,
                              vertical: AppTheme.spacingMD,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.church_outlined,
                                  color: isSelected
                                      ? AppColors.primaryDark
                                      : subTextColor,
                                  size: 20,
                                ),
                                const SizedBox(width: AppTheme.spacingMD),
                                Expanded(
                                  child: Text(
                                    church,
                                    style: AppTypography.bodyLarge(
                                      isSelected
                                          ? AppColors.primaryDark
                                          : textColor,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primaryDark,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 교회 안 다닌다
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedChurch = null;
                    });
                    _handleNext();
                  },
                  child: Text(
                    '교회를 다니고 있지 않아요',
                    style: AppTypography.bodyMedium(subTextColor),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingSM),

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
