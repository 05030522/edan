import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/providers/daily_tasks_provider.dart';
import '../widgets/streak_celebration.dart';

/// 태스크 완료 후 스트릭 체크 공통 유틸
class StreakHelper {
  /// 모든 일일 태스크가 완료되었으면 스트릭 업데이트 + 축하 표시
  ///
  /// 반환: 축하 다이얼로그가 사용자에 의해 닫힌 뒤 resolve되는 Future.
  /// - 축하 다이얼로그가 뜰 조건이 아니면 즉시 resolve
  /// - 호출자는 await 후에 화면 전환(예: Navigator.pop) 하면 안전함
  static Future<void> checkAndUpdate(
      BuildContext context, WidgetRef ref) async {
    final tasksState = ref.read(dailyTasksProvider);
    if (!tasksState.allCompleted) return;

    final newStreak = await ref.read(authProvider.notifier).updateStreak();
    if (newStreak <= 0) return;

    // Perfect Day 보너스
    const perfectDayBonus = AppConstants.faithPointsPerfectDay;
    await ref.read(authProvider.notifier).addFaithPoints(perfectDayBonus);

    // 마일스톤 보너스
    final milestoneBonus = AppConstants.streakMilestoneRewards[newStreak];
    if (milestoneBonus != null) {
      await ref.read(authProvider.notifier).addFaithPoints(milestoneBonus);
    }

    // 축하 다이얼로그 (사용자가 닫을 때까지 await)
    if (!context.mounted) return;
    await StreakCelebration.show(
      context,
      streakCount: newStreak,
      bonusFp: perfectDayBonus,
    );
  }
}
