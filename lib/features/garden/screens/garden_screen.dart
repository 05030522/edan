import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/luyang_image.dart';
import '../../../shared/widgets/talent_icon.dart';
import '../../auth/providers/auth_provider.dart';
import '../../store/providers/store_provider.dart';

/// 루양의 정원 화면 - 레벨에 따라 정원이 성장하는 시각적 표현
class GardenScreen extends ConsumerWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final profile = ref.watch(authProvider).profile;
    final currentLevel = profile?.currentLevel ?? 1;
    final faithPoints = profile?.faithPoints ?? 0;
    final levelIndex = (currentLevel - 1).clamp(
      0,
      AppConstants.levelNames.length - 1,
    );
    final levelName = AppConstants.levelNames[levelIndex];

    // 다음 레벨까지 필요한 포인트
    final currentThreshold =
        AppConstants.levelThresholds[currentLevel.clamp(
              1,
              AppConstants.levelThresholds.length,
            ) -
            1];
    final nextThreshold = currentLevel < AppConstants.levelThresholds.length
        ? AppConstants.levelThresholds[currentLevel]
        : AppConstants.levelThresholds.last;
    final progress = nextThreshold > currentThreshold
        ? ((faithPoints - currentThreshold) /
                  (nextThreshold - currentThreshold))
              .clamp(0.0, 1.0)
        : 1.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('루양의 정원', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          children: [
            // 정원 시각화
            _GardenView(
              level: currentLevel,
              ownedGardenItemIds: ref
                  .watch(storeProvider)
                  .ownedItemIds
                  .where((id) => _gardenItemData.containsKey(id))
                  .toSet(),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // 레벨 정보 카드
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacingLG),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusRound,
                          ),
                        ),
                        child: Text(
                          'Lv.$currentLevel',
                          style: AppTypography.label(
                            AppColors.primaryDark,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        levelName,
                        style: AppTypography.headlineMedium(textColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingLG),

                  // 레벨 진행도 바
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      backgroundColor: isDark
                          ? Colors.white12
                          : Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getLevelColor(currentLevel),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TalentIcon(size: 12),
                          const SizedBox(width: 3),
                          Text(
                            '$faithPoints',
                            style: AppTypography.bodySmall(subTextColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TalentIcon(size: 12),
                          const SizedBox(width: 3),
                          Text(
                            '$nextThreshold',
                            style: AppTypography.bodySmall(subTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),

                  if (currentLevel < 10) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '다음 레벨까지 ${nextThreshold - faithPoints} ',
                          style: AppTypography.bodySmall(AppColors.primaryDark),
                        ),
                        const TalentIcon(size: 12),
                        Text(
                          ' 남았어요',
                          style: AppTypography.bodySmall(AppColors.primaryDark),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // 전체 레벨 로드맵
            Text('성장 로드맵', style: AppTypography.titleLarge(textColor)),
            const SizedBox(height: AppTheme.spacingMD),

            ...List.generate(10, (index) {
              final level = index + 1;
              final name = AppConstants.levelNames[index];
              final threshold = AppConstants.levelThresholds[index];
              final isUnlocked = currentLevel >= level;
              final isCurrent = currentLevel == level;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? _getLevelColor(level).withValues(alpha: 0.1)
                      : isDark
                      ? Colors.white.withValues(alpha: 0.03)
                      : Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: isCurrent
                      ? Border.all(
                          color: _getLevelColor(level).withValues(alpha: 0.3),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isUnlocked
                            ? _getLevelColor(level).withValues(alpha: 0.15)
                            : (isDark ? Colors.white10 : Colors.grey.shade100),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isUnlocked
                            ? Icon(
                                _getLevelIcon(level),
                                color: _getLevelColor(level),
                                size: 18,
                              )
                            : Icon(Icons.lock, color: subTextColor, size: 14),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lv.$level  $name',
                            style: AppTypography.titleMedium(
                              isUnlocked ? textColor : subTextColor,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TalentIcon(size: 11),
                              const SizedBox(width: 3),
                              Text(
                                '$threshold',
                                style: AppTypography.bodySmall(subTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getLevelColor(level),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '현재',
                          style: AppTypography.label(Colors.white),
                        ),
                      )
                    else if (isUnlocked)
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 20,
                      ),
                  ],
                ),
              );
            }),

            const SizedBox(height: AppTheme.spacingXL),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(int level) {
    if (level <= 2) return AppColors.gardenSoil;
    if (level <= 4) return AppColors.gardenSprout;
    if (level <= 6) return AppColors.gardenFlower;
    if (level <= 8) return AppColors.gardenTree;
    return AppColors.gardenParadise;
  }

  IconData _getLevelIcon(int level) {
    switch (level) {
      case 1:
        return Icons.landscape;
      case 2:
        return Icons.grass;
      case 3:
        return Icons.spa;
      case 4:
        return Icons.eco;
      case 5:
        return Icons.nature;
      case 6:
        return Icons.local_florist;
      case 7:
        return Icons.emoji_nature;
      case 8:
        return Icons.park;
      case 9:
        return Icons.forest;
      case 10:
        return Icons.auto_awesome;
      default:
        return Icons.eco;
    }
  }
}

/// 정원 아이템 데이터 매핑
const _gardenItemData = <String, (IconData, Color)>{
  'tree_olive': (Icons.park, Colors.green),
  'flower_lily': (Icons.local_florist, Colors.white),
  'flower_rose': (Icons.local_florist, Colors.pink),
  'animal_dove': (Icons.flutter_dash, Colors.white),
  'animal_lamb': (Icons.pets, Color(0xFF8D6E63)),
  'tree_fig': (Icons.nature, Colors.green),
  'fountain': (Icons.water_drop, Colors.lightBlue),
  'tree_life': (Icons.eco, AppColors.gardenParadise),
};

/// 정원 아이템 배치 위치
const _gardenItemPositions = <String, (double, double)>{
  'tree_olive': (0.15, 0.2),
  'flower_lily': (0.78, 0.65),
  'flower_rose': (0.85, 0.3),
  'animal_dove': (0.7, 0.12),
  'animal_lamb': (0.25, 0.7),
  'tree_fig': (0.1, 0.5),
  'fountain': (0.5, 0.75),
  'tree_life': (0.5, 0.15),
};

/// 정원 시각적 표현 위젯
class _GardenView extends StatelessWidget {
  final int level;
  final Set<String> ownedGardenItemIds;
  const _GardenView({required this.level, this.ownedGardenItemIds = const {}});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _getGradientColors(),
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 배경 장식들
          ..._buildDecorations(),

          // 구매한 정원 아이템들
          ..._buildOwnedItems(),

          // 중앙 루양 캐릭터
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LuyangImage(
                size: 80,
                backgroundColor: Color(0x33FFFFFF),
                shadow: false,
              ),
              const SizedBox(height: 8),
              Text(
                '루양',
                style: AppTypography.titleLarge(
                  Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOwnedItems() {
    return ownedGardenItemIds.map((id) {
      final data = _gardenItemData[id];
      final pos = _gardenItemPositions[id];
      if (data == null || pos == null) return const SizedBox.shrink();
      final (icon, color) = data;
      final (xFrac, yFrac) = pos;
      return Positioned(
        left: xFrac * 280, // approximate width
        top: yFrac * 280, // approximate height
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) =>
              Transform.scale(scale: value, child: child),
          child: Icon(icon, color: color.withValues(alpha: 0.7), size: 28),
        ),
      );
    }).toList();
  }

  List<Color> _getGradientColors() {
    if (level <= 1) {
      return [const Color(0xFF8D6E63), const Color(0xFF5D4037)]; // 황무지
    } else if (level <= 2) {
      return [const Color(0xFF8D6E63), const Color(0xFF6D8B74)]; // 씨앗
    } else if (level <= 3) {
      return [const Color(0xFFA5D6A7), const Color(0xFF66BB6A)]; // 새싹
    } else if (level <= 4) {
      return [const Color(0xFF81C784), const Color(0xFF4CAF50)]; // 뿌리
    } else if (level <= 5) {
      return [const Color(0xFF66BB6A), const Color(0xFF388E3C)]; // 나무
    } else if (level <= 6) {
      return [const Color(0xFFF48FB1), const Color(0xFF66BB6A)]; // 꽃
    } else if (level <= 7) {
      return [const Color(0xFFFFB74D), const Color(0xFF66BB6A)]; // 열매
    } else if (level <= 8) {
      return [const Color(0xFF4CAF50), const Color(0xFF1B5E20)]; // 울창
    } else if (level <= 9) {
      return [const Color(0xFF2E7D32), const Color(0xFF1B5E20)]; // 숲
    } else {
      return [const Color(0xFFFFD54F), const Color(0xFF4CAF50)]; // 에덴
    }
  }

  List<Widget> _buildDecorations() {
    final decorations = <Widget>[];

    // 레벨에 따라 장식 추가
    if (level >= 2) {
      // 씨앗/작은 풀
      decorations.add(
        Positioned(
          bottom: 40,
          left: 30,
          child: Icon(
            Icons.grass,
            color: Colors.white.withValues(alpha: 0.3),
            size: 24,
          ),
        ),
      );
    }
    if (level >= 3) {
      decorations.add(
        Positioned(
          bottom: 50,
          right: 40,
          child: Icon(
            Icons.spa,
            color: Colors.white.withValues(alpha: 0.3),
            size: 28,
          ),
        ),
      );
    }
    if (level >= 4) {
      decorations.add(
        Positioned(
          bottom: 30,
          left: 60,
          child: Icon(
            Icons.eco,
            color: Colors.white.withValues(alpha: 0.3),
            size: 30,
          ),
        ),
      );
    }
    if (level >= 5) {
      decorations.add(
        Positioned(
          top: 50,
          right: 30,
          child: Icon(
            Icons.nature,
            color: Colors.white.withValues(alpha: 0.3),
            size: 36,
          ),
        ),
      );
    }
    if (level >= 6) {
      decorations.add(
        Positioned(
          top: 40,
          left: 40,
          child: Icon(
            Icons.local_florist,
            color: Colors.white.withValues(alpha: 0.35),
            size: 28,
          ),
        ),
      );
      decorations.add(
        Positioned(
          bottom: 60,
          right: 60,
          child: Icon(
            Icons.local_florist,
            color: Colors.white.withValues(alpha: 0.25),
            size: 22,
          ),
        ),
      );
    }
    if (level >= 7) {
      decorations.add(
        Positioned(
          top: 30,
          right: 60,
          child: Icon(
            Icons.emoji_nature,
            color: Colors.white.withValues(alpha: 0.3),
            size: 24,
          ),
        ),
      );
    }
    if (level >= 8) {
      decorations.add(
        Positioned(
          top: 60,
          left: 20,
          child: Icon(
            Icons.park,
            color: Colors.white.withValues(alpha: 0.3),
            size: 40,
          ),
        ),
      );
    }
    if (level >= 9) {
      decorations.add(
        Positioned(
          bottom: 40,
          right: 20,
          child: Icon(
            Icons.forest,
            color: Colors.white.withValues(alpha: 0.3),
            size: 44,
          ),
        ),
      );
    }
    if (level >= 10) {
      decorations.add(
        Positioned(
          top: 20,
          left: 20,
          child: Icon(
            Icons.auto_awesome,
            color: Colors.amber.withValues(alpha: 0.5),
            size: 24,
          ),
        ),
      );
      decorations.add(
        Positioned(
          top: 20,
          right: 20,
          child: Icon(
            Icons.auto_awesome,
            color: Colors.amber.withValues(alpha: 0.5),
            size: 24,
          ),
        ),
      );
      decorations.add(
        Positioned(
          bottom: 20,
          left: 20,
          child: Icon(
            Icons.auto_awesome,
            color: Colors.amber.withValues(alpha: 0.4),
            size: 18,
          ),
        ),
      );
    }

    return decorations;
  }
}
