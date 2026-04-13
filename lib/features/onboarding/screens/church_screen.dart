import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/kakao_place_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/onboarding_provider.dart';

/// 온보딩 - 교회 선택 화면 (카카오 지도 검색)
class OnboardingChurchScreen extends ConsumerStatefulWidget {
  const OnboardingChurchScreen({super.key});

  @override
  ConsumerState<OnboardingChurchScreen> createState() =>
      _OnboardingChurchScreenState();
}

class _OnboardingChurchScreenState
    extends ConsumerState<OnboardingChurchScreen> {
  final _searchController = TextEditingController();
  KakaoChurchResult? _selectedChurch;
  List<KakaoChurchResult> _searchResults = [];
  bool _isSearching = false;
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  /// 검색어 변경 시 debounce 적용 (0.5초 후 검색)
  void _onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await KakaoPlaceService.searchChurch(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    });
  }

  void _handleNext() {
    if (_selectedChurch != null) {
      // "이름 (주소)" 형식으로 저장
      final churchName = _selectedChurch!.name;
      ref.read(onboardingProvider.notifier).setChurch(churchName);
    } else {
      ref.read(onboardingProvider.notifier).setChurch(null);
    }
    context.go('/onboarding/notification');
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
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.spacing3XL),

              // 진행 표시 (3/5)
              _buildProgressIndicator(3, 5),
              const SizedBox(height: AppTheme.spacingMD),

              // 건너뛰기 버튼
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go('/onboarding/notification'),
                  child: Text(
                    '건너뛰기',
                    style: AppTypography.bodyMedium(subTextColor),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

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

              // 교회 검색 입력
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '교회 이름을 검색하세요',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isSearching
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchResults = [];
                              _selectedChurch = null;
                            });
                          },
                        )
                      : null,
                ),
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // 선택된 교회 표시
              if (_selectedChurch != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingLG,
                    vertical: AppTheme.spacingMD,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingSM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedChurch!.name,
                              style: AppTypography.bodyLarge(
                                AppColors.primaryDark,
                              ),
                            ),
                            Text(
                              _selectedChurch!.shortAddress,
                              style: AppTypography.bodySmall(subTextColor),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: subTextColor, size: 18),
                        onPressed: () {
                          setState(() => _selectedChurch = null);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMD),
              ],

              // 검색 결과 목록
              Expanded(
                child: _buildSearchResults(textColor, subTextColor, cardColor),
              ),

              // 교회 안 다닌다
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() => _selectedChurch = null);
                    ref.read(onboardingProvider.notifier).setChurch(null);
                    context.go('/onboarding/notification');
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

  Widget _buildSearchResults(
    Color textColor,
    Color subTextColor,
    Color cardColor,
  ) {
    // 아직 검색 안 한 경우
    if (_searchController.text.isEmpty && _searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.church_outlined, size: 48, color: subTextColor),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              '교회 이름을 입력하면\n카카오 지도에서 검색해요',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(subTextColor),
            ),
          ],
        ),
      );
    }

    // 검색 중
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    // 검색 결과 없음
    if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: subTextColor),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              '검색 결과가 없어요\n교회 이름을 다시 확인해주세요',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(subTextColor),
            ),
          ],
        ),
      );
    }

    // 검색 결과 목록
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final church = _searchResults[index];
        final isSelected = _selectedChurch?.id == church.id;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingSM),
          child: Material(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.15)
                : cardColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              onTap: () {
                setState(() => _selectedChurch = church);
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
                      color: isSelected ? AppColors.primaryDark : subTextColor,
                      size: 20,
                    ),
                    const SizedBox(width: AppTheme.spacingMD),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            church.name,
                            style: AppTypography.bodyLarge(
                              isSelected ? AppColors.primaryDark : textColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            church.roadAddress ?? church.address,
                            style: AppTypography.bodySmall(subTextColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
