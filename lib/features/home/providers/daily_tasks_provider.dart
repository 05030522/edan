import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final DateTime? lastResetDate;

  const DailyTasksState({
    this.tasks = const [],
    this.totalFpEarned = 0,
    this.lastResetDate,
  });

  DailyTasksState copyWith({
    List<DailyTask>? tasks,
    int? totalFpEarned,
    DateTime? lastResetDate,
  }) {
    return DailyTasksState(
      tasks: tasks ?? this.tasks,
      totalFpEarned: totalFpEarned ?? this.totalFpEarned,
      lastResetDate: lastResetDate ?? this.lastResetDate,
    );
  }

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  bool get allCompleted => tasks.every((t) => t.isCompleted);
}

/// 기본 태스크 목록
const _defaultTasks = [
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
];

/// 일일 태스크 프로바이더
class DailyTasksNotifier extends StateNotifier<DailyTasksState> {
  DailyTasksNotifier()
    : super(
        DailyTasksState(tasks: _defaultTasks, lastResetDate: DateTime.now()),
      ) {
    // 초기화 시 날짜 체크
    _checkAndResetIfNewDay();
  }

  /// 날짜가 변경되었으면 태스크 리셋
  void _checkAndResetIfNewDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (state.lastResetDate != null) {
      final lastReset = DateTime(
        state.lastResetDate!.year,
        state.lastResetDate!.month,
        state.lastResetDate!.day,
      );
      if (lastReset == today) return; // 오늘 이미 리셋됨
    }

    // 새 날 → 리셋
    state = DailyTasksState(
      tasks: _defaultTasks,
      totalFpEarned: 0,
      lastResetDate: today,
    );
  }

  /// 화면 진입 시 호출 → 날짜 변경 체크
  void ensureFreshTasks() {
    _checkAndResetIfNewDay();
  }

  /// 태스크 완료 처리 → 보상 달란트 반환
  int completeTask(DailyTaskType type) {
    _checkAndResetIfNewDay(); // 혹시 날짜가 바뀌었으면 리셋

    final tasks = [...state.tasks];
    final index = tasks.indexWhere((t) => t.type == type);
    if (index == -1 || tasks[index].isCompleted) return 0;

    final reward = tasks[index].rewardFp;
    tasks[index] = tasks[index].copyWith(isCompleted: true);

    state = state.copyWith(
      tasks: tasks,
      totalFpEarned: state.totalFpEarned + reward,
    );

    // 활동 카운터 증가 (업적용)
    _incrementCounter(type);

    return reward;
  }

  /// 활동 카운터 증가 (업적 추적용)
  Future<void> _incrementCounter(DailyTaskType type) async {
    final key = switch (type) {
      DailyTaskType.meditation => 'total_meditation_count',
      DailyTaskType.prayer => 'total_prayer_count',
      DailyTaskType.bibleReading => 'total_bible_count',
    };
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + 1);
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
}

/// 프로바이더 정의
final dailyTasksProvider =
    StateNotifierProvider<DailyTasksNotifier, DailyTasksState>((ref) {
      return DailyTasksNotifier();
    });
