import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../auth/providers/auth_provider.dart';

/// 학습 경로별 진척도 상태
class StudyProgressState {
  /// pathId → 완료된 lessonId 목록
  final Map<String, Set<String>> completedLessons;
  final bool isLoading;

  const StudyProgressState({
    this.completedLessons = const {},
    this.isLoading = false,
  });

  /// 특정 경로의 완료된 레슨 수
  int completedCountForPath(String pathId) {
    return completedLessons[pathId]?.length ?? 0;
  }

  /// 특정 레슨이 완료되었는지
  bool isLessonCompleted(String pathId, String lessonId) {
    return completedLessons[pathId]?.contains(lessonId) ?? false;
  }

  StudyProgressState copyWith({
    Map<String, Set<String>>? completedLessons,
    bool? isLoading,
  }) {
    return StudyProgressState(
      completedLessons: completedLessons ?? this.completedLessons,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 학습 진척도 프로바이더
class StudyProgressNotifier extends StateNotifier<StudyProgressState> {
  final Ref _ref;

  StudyProgressNotifier(this._ref) : super(const StudyProgressState()) {
    _loadProgress();
  }

  /// DB에서 진척도 로드
  Future<void> _loadProgress() async {
    final authState = _ref.read(authProvider);
    if (authState.isDevMode) return;

    final userId = SupabaseService.currentUserId;
    if (userId == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final data = await SupabaseService.client
          .from(SupabaseConstants.tableUserProgress)
          .select('path_id, lesson_id')
          .eq('user_id', userId)
          .eq('completed', true);

      final Map<String, Set<String>> completed = {};
      for (final row in data as List) {
        final pathId = row['path_id'] as String;
        final lessonId = row['lesson_id'] as String;
        completed.putIfAbsent(pathId, () => {}).add(lessonId);
      }

      state = state.copyWith(completedLessons: completed, isLoading: false);
    } catch (e) {
      debugPrint('학습 진척도 로드 실패: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  /// 레슨 완료 처리 (로컬 즉시 반영 + 서버 저장)
  Future<void> completeLesson(String pathId, String lessonId) async {
    // 이미 완료된 경우 무시
    if (state.isLessonCompleted(pathId, lessonId)) return;

    // 로컬 즉시 반영
    final updated = Map<String, Set<String>>.from(
      state.completedLessons.map((k, v) => MapEntry(k, Set<String>.from(v))),
    );
    updated.putIfAbsent(pathId, () => {}).add(lessonId);
    state = state.copyWith(completedLessons: updated);

    // 서버 저장
    final authState = _ref.read(authProvider);
    if (authState.isDevMode) return;

    final userId = SupabaseService.currentUserId;
    if (userId == null) return;

    try {
      await SupabaseService.client
          .from(SupabaseConstants.tableUserProgress)
          .upsert({
            'user_id': userId,
            'path_id': pathId,
            'lesson_id': lessonId,
            'completed': true,
            'completed_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      debugPrint('레슨 완료 저장 실패: $e');
    }
  }

  /// 새로고침
  Future<void> refresh() async {
    await _loadProgress();
  }
}

/// 프로바이더 정의
final studyProgressProvider =
    StateNotifierProvider<StudyProgressNotifier, StudyProgressState>((ref) {
      return StudyProgressNotifier(ref);
    });
