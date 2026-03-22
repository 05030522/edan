import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 일일 태스크 타입
enum DailyTaskType {
  meditation, // 묵상하기
  prayer, // 기도하기
  bibleReading, // 말씀 읽기
}

/// 일일 태스크 모델
class DailyTask {
  final DailyTaskType type;
  final String title;
  final String subtitle;
  final int rewardFp;
  final bool isCompleted;

  const DailyTask({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.rewardFp,
    this.isCompleted = false,
  });

  DailyTask copyWith({bool? isCompleted}) {
    return DailyTask(
      type: type,
      title: title,
      subtitle: subtitle,
      rewardFp: rewardFp,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// 일일 태스크 상태
class DailyTasksState {
  final List<DailyTask> tasks;
  final int totalFpEarned;

  const DailyTasksState({
    this.tasks = const [],
    this.totalFpEarned = 0,
  });

  DailyTasksState copyWith({
    List<DailyTask>? tasks,
    int? totalFpEarned,
  }) {
    return DailyTasksState(
      tasks: tasks ?? this.tasks,
      totalFpEarned: totalFpEarned ?? this.totalFpEarned,
    );
  }

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  bool get allCompleted => tasks.every((t) => t.isCompleted);
}

/// 일일 태스크 프로바이더
class DailyTasksNotifier extends StateNotifier<DailyTasksState> {
  DailyTasksNotifier()
      : super(const DailyTasksState(
          tasks: [
            DailyTask(
              type: DailyTaskType.meditation,
              title: '묵상하기',
              subtitle: '홍해를 여시는 하나님',
              rewardFp: 10,
            ),
            DailyTask(
              type: DailyTaskType.prayer,
              title: '기도하기',
              subtitle: '주님과 나란히 걷는 여정',
              rewardFp: 5,
            ),
            DailyTask(
              type: DailyTaskType.bibleReading,
              title: '말씀 읽기',
              subtitle: '창세기 1장',
              rewardFp: 5,
            ),
          ],
        ));

  /// 태스크 완료 처리 → 보상 FP 반환
  int completeTask(DailyTaskType type) {
    final tasks = [...state.tasks];
    final index = tasks.indexWhere((t) => t.type == type);
    if (index == -1 || tasks[index].isCompleted) return 0;

    final reward = tasks[index].rewardFp;
    tasks[index] = tasks[index].copyWith(isCompleted: true);

    state = state.copyWith(
      tasks: tasks,
      totalFpEarned: state.totalFpEarned + reward,
    );

    return reward;
  }

  /// 태스크 완료 상태 토글 (테스트용)
  void toggleTask(DailyTaskType type) {
    final tasks = [...state.tasks];
    final index = tasks.indexWhere((t) => t.type == type);
    if (index == -1) return;

    final task = tasks[index];
    tasks[index] = task.copyWith(isCompleted: !task.isCompleted);

    state = state.copyWith(tasks: tasks);
  }

  /// 모든 태스크 리셋 (새 날)
  void resetTasks() {
    state = const DailyTasksState(
      tasks: [
        DailyTask(
          type: DailyTaskType.meditation,
          title: '묵상하기',
          subtitle: '홍해를 여시는 하나님',
          rewardFp: 10,
        ),
        DailyTask(
          type: DailyTaskType.prayer,
          title: '기도하기',
          subtitle: '주님과 나란히 걷는 여정',
          rewardFp: 5,
        ),
        DailyTask(
          type: DailyTaskType.bibleReading,
          title: '말씀 읽기',
          subtitle: '창세기 1장',
          rewardFp: 5,
        ),
      ],
    );
  }
}

/// 프로바이더 정의
final dailyTasksProvider =
    StateNotifierProvider<DailyTasksNotifier, DailyTasksState>((ref) {
  return DailyTasksNotifier();
});
