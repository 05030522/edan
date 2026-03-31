import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/providers/daily_tasks_provider.dart';
import '../widgets/streak_celebration.dart';

/// 태스크 완료 후 스트릭 체크 공통 유틸
class StreakHelper {
  /// 모든 일일 태스크가 완료되었으면 스트릭 업데이트 + 축하 표시
  static void checkAndUpdate(BuildContext context, WidgetRef ref) {
    final tasksState = ref.read(dailyTasksProvider);
    if (!tasksState.allCompleted) return;

    ref.read(authProvider.notifier).updateStreak().then((newStreak) {
      if (newStreak <= 0) return;

      // Perfect Day 보너스
      const perfectDayBonus = AppConstants.faithPointsPerfectDay;
      ref.read(authProvider.notifier).addFaithPoints(perfectDayBonus);

      // 마일스톤 보너스
      final milestoneBonus =
          AppConstants.streakMilestoneRewards[newStreak];
      if (milestoneBonus != null) {
        ref.read(authProvider.notifier).addFaithPoints(milestoneBonus);
      }

      // 축하 다이얼로그
      if (context.mounted) {
        StreakCelebration.show(
          context,
          streakCount: newStreak,
          bonusFp: perfectDayBonus,
        );
      }
    });
  }
}
