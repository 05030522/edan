import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../auth/providers/auth_provider.dart';

/// 프로필 화면
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // 화면 진입 시 프로필 최신 데이터로 갱신
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).refreshProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    // Auth 프로바이더에서 실제 데이터 읽기
    final authState = ref.watch(authProvider);
    final profile = authState.profile;
    final displayName = profile?.displayName.isNotEmpty == true
        ? profile!.displayName
        : '에덴 사용자';
    final currentLevel = profile?.currentLevel ?? 1;
    final streakCount = profile?.currentStreak ?? 0;
    final totalFP = profile?.faithPoints ?? 0;

    // 레벨 인덱스 안전하게 접근
    final levelIndex =
        (currentLevel - 1).clamp(0, AppConstants.levelNames.length - 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 정보',
          style: AppTypography.titleLarge(textColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: textColor),
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(authProvider.notifier).refreshProfile(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          child: Column(
            children: [
              // 프로필 정보
              GlassCard(
                child: Column(
                  children: [
                    // 아바타
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primaryDark,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),

                    // 이름
                    Text(
                      displayName,
                      style: AppTypography.headlineMedium(textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacingSM),

                    // 레벨 배지
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMD,
                        vertical: AppTheme.spacingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gardenSoil.withValues(alpha: 0.15),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusRound),
                      ),
                      child: Text(
                        'Lv.$currentLevel ${AppConstants.levelNames[levelIndex]}',
                        style: AppTypography.label(AppColors.gardenSoil),
                      ),
                    ),

                    // 레벨 진행 바
                    if (currentLevel < AppConstants.levelThresholds.length) ...[
                      const SizedBox(height: AppTheme.spacingLG),
                      _buildLevelProgress(
                        currentFP: totalFP,
                        currentLevel: currentLevel,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 통계 행
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.local_fire_department,
                      iconColor: AppColors.streakFlame,
                      value: '$streakCount',
                      label: '스트릭',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.calendar_today,
                      iconColor: AppColors.primary,
                      value: '$currentLevel',
                      label: '레벨',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.stars,
                      iconColor: AppColors.gold,
                      value: '$totalFP',
                      label: 'FP',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 캘린더 히트맵
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '묵상 기록',
                      style: AppTypography.titleMedium(textColor),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    _CalendarHeatmap(),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 교회 정보
              if (profile?.churchName != null && profile!.churchName!.isNotEmpty) ...[
                GlassCard(
                  child: Row(
                    children: [
                      Icon(
                        Icons.church_outlined,
                        color: subTextColor,
                        size: 22,
                      ),
                      const SizedBox(width: AppTheme.spacingMD),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '소속 교회',
                              style: AppTypography.label(subTextColor),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              profile.churchName!,
                              style: AppTypography.bodyLarge(textColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXL),
              ],

              // 설정 버튼
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/profile/settings'),
                  icon: Icon(Icons.settings_outlined, color: subTextColor),
                  label: Text(
                    '설정',
                    style: AppTypography.button(subTextColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 레벨 진행 바
  Widget _buildLevelProgress({
    required int currentFP,
    required int currentLevel,
    required Color textColor,
    required Color subTextColor,
  }) {
    final currentThreshold = AppConstants.levelThresholds[currentLevel - 1];
    final nextThreshold = currentLevel < AppConstants.levelThresholds.length
        ? AppConstants.levelThresholds[currentLevel]
        : AppConstants.levelThresholds.last;
    final progress = nextThreshold > currentThreshold
        ? ((currentFP - currentThreshold) / (nextThreshold - currentThreshold))
            .clamp(0.0, 1.0)
        : 1.0;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            color: AppColors.primary,
            minHeight: 8,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          '$currentFP / $nextThreshold FP',
          style: AppTypography.label(subTextColor),
        ),
      ],
    );
  }
}

/// 통계 카드 위젯
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GlassCard(
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            value,
            style: AppTypography.streakNumber(textColor),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.label(subTextColor),
          ),
        ],
      ),
    );
  }
}

/// 캘린더 히트맵 위젯 (GitHub 스타일)
class _CalendarHeatmap extends ConsumerWidget {
  // 히트맵 색상 단계 (라이트)
  static const _lightEmpty = Color(0xFFEBEDF0);
  static const _lightLevel1 = Color(0xFFD4EDDA);
  static const _lightLevel2 = Color(0xFFA5D6A7);
  static const _lightLevel3 = Color(0xFF7BA884);
  static const _lightLevel4 = Color(0xFF4A7C59);

  // 히트맵 색상 단계 (다크)
  static const _darkEmpty = Color(0xFF2D2D2D);
  static const _darkLevel1 = Color(0xFF0E4429);
  static const _darkLevel2 = Color(0xFF006D32);
  static const _darkLevel3 = Color(0xFF26A641);
  static const _darkLevel4 = Color(0xFF39D353);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final authState = ref.watch(authProvider);
    final profile = authState.profile;
    final streak = profile?.currentStreak ?? 0;
    final lastStudy = profile?.lastStudyDate;

    // 최근 35일 기준으로 완료 날짜 세트 생성
    final completedDays = <DateTime>{};
    if (lastStudy != null && streak > 0) {
      final lastDay = DateTime(lastStudy.year, lastStudy.month, lastStudy.day);
      for (int i = 0; i < streak; i++) {
        completedDays.add(lastDay.subtract(Duration(days: i)));
      }
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 35일 전부터 오늘까지 (5주)
    final startDate = today.subtract(const Duration(days: 34));

    // 요일 라벨
    const dayLabels = ['월', '', '수', '', '금', '', ''];

    return Column(
      children: [
        // 요일 헤더 + 그리드
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 요일 라벨 열
            Column(
              children: List.generate(7, (i) {
                return SizedBox(
                  height: 18,
                  child: dayLabels[i].isNotEmpty
                      ? Text(
                          dayLabels[i],
                          style: TextStyle(
                            fontSize: 10,
                            color: subTextColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              }),
            ),
            const SizedBox(width: 6),

            // 히트맵 그리드
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 5주
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemCount: 35,
                itemBuilder: (context, index) {
                  // index를 주(column) 우선으로 재배열: 위→아래, 왼→오른
                  final week = index % 5;
                  final dayOfWeek = index ~/ 5;
                  final dayOffset = week * 7 + dayOfWeek;
                  final date = startDate.add(Duration(days: dayOffset));
                  final dateNorm =
                      DateTime(date.year, date.month, date.day);

                  final isCompleted = completedDays.contains(dateNorm);
                  final isFuture = dateNorm.isAfter(today);
                  final isToday = dateNorm == today;

                  Color cellColor;
                  if (isFuture) {
                    cellColor = isDark ? _darkEmpty : _lightEmpty;
                  } else if (isCompleted) {
                    // 스트릭 연속 일수에 따라 색 농도 결정
                    final daysAgo = today.difference(dateNorm).inDays;
                    if (daysAgo == 0) {
                      cellColor = isDark ? _darkLevel4 : _lightLevel4;
                    } else if (daysAgo <= 3) {
                      cellColor = isDark ? _darkLevel3 : _lightLevel3;
                    } else if (daysAgo <= 10) {
                      cellColor = isDark ? _darkLevel2 : _lightLevel2;
                    } else {
                      cellColor = isDark ? _darkLevel1 : _lightLevel1;
                    }
                  } else {
                    cellColor = isDark ? _darkEmpty : _lightEmpty;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.circular(3),
                      border: isToday
                          ? Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.4)
                                  : AppColors.primaryDark.withValues(alpha: 0.5),
                              width: 1.5,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 범례
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '적음',
              style: TextStyle(fontSize: 10, color: subTextColor),
            ),
            const SizedBox(width: 4),
            ...[
              isDark ? _darkEmpty : _lightEmpty,
              isDark ? _darkLevel1 : _lightLevel1,
              isDark ? _darkLevel2 : _lightLevel2,
              isDark ? _darkLevel3 : _lightLevel3,
              isDark ? _darkLevel4 : _lightLevel4,
            ].map((c) => Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(2),
                  ),
                )),
            const SizedBox(width: 4),
            Text(
              '많음',
              style: TextStyle(fontSize: 10, color: subTextColor),
            ),
          ],
        ),
      ],
    );
  }
}
