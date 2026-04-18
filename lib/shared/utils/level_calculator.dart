import '../../core/constants/app_constants.dart';

/// 달란트(FP) 기반 레벨 계산기.
///
/// auth_provider 내부에서만 쓰이던 private 로직을 테스트 가능한 순수 함수로 추출.
class LevelCalculator {
  LevelCalculator._();

  /// 달란트 값 [fp]로 현재 레벨(1..N)을 반환.
  ///
  /// - fp가 0 미만이어도 최소 레벨 1을 보장.
  /// - 임계값 배열이 비어 있으면 1을 반환 (안전 기본값).
  static int calculate(int fp, {List<int>? thresholds}) {
    final t = thresholds ?? AppConstants.levelThresholds;
    if (t.isEmpty) return 1;
    for (int i = t.length - 1; i >= 0; i--) {
      if (fp >= t[i]) return i + 1;
    }
    return 1;
  }
}
