import 'package:flutter_test/flutter_test.dart';
import 'package:eden_app/shared/utils/level_calculator.dart';
import 'package:eden_app/core/constants/app_constants.dart';

void main() {
  group('LevelCalculator.calculate (기본 임계값)', () {
    test('FP 0 → 레벨 1', () {
      expect(LevelCalculator.calculate(0), 1);
    });

    test('음수 FP여도 최소 레벨 1 보장', () {
      expect(LevelCalculator.calculate(-100), 1);
    });

    test('레벨 경계 정확히 일치: 100 FP → 레벨 2', () {
      expect(LevelCalculator.calculate(100), 2);
    });

    test('경계 직전: 99 FP → 레벨 1', () {
      expect(LevelCalculator.calculate(99), 1);
    });

    test('중간 레벨: 1400 FP → 레벨 5 (자라는 나무)', () {
      expect(LevelCalculator.calculate(1400), 5);
    });

    test('최대 레벨 도달: 17000 FP → 레벨 10 (에덴)', () {
      expect(LevelCalculator.calculate(17000), 10);
    });

    test('최대 레벨 초과: 매우 큰 FP → 레벨 10 유지', () {
      expect(LevelCalculator.calculate(999999), 10);
    });

    test('모든 임계값이 오름차순이면 레벨도 단조 증가', () {
      int prevLevel = 1;
      for (final threshold in AppConstants.levelThresholds) {
        final level = LevelCalculator.calculate(threshold);
        expect(
          level >= prevLevel,
          true,
          reason: 'FP $threshold에서 레벨 감소 발생',
        );
        prevLevel = level;
      }
    });
  });

  group('LevelCalculator.calculate (커스텀 임계값)', () {
    test('빈 임계값 배열 → 레벨 1 반환 (안전 기본값)', () {
      expect(LevelCalculator.calculate(100, thresholds: []), 1);
    });

    test('단일 임계값 [0] → 항상 레벨 1', () {
      expect(LevelCalculator.calculate(0, thresholds: [0]), 1);
      expect(LevelCalculator.calculate(500, thresholds: [0]), 1);
    });

    test('커스텀 [0, 50, 100]로 계산', () {
      expect(LevelCalculator.calculate(0, thresholds: [0, 50, 100]), 1);
      expect(LevelCalculator.calculate(49, thresholds: [0, 50, 100]), 1);
      expect(LevelCalculator.calculate(50, thresholds: [0, 50, 100]), 2);
      expect(LevelCalculator.calculate(99, thresholds: [0, 50, 100]), 2);
      expect(LevelCalculator.calculate(100, thresholds: [0, 50, 100]), 3);
    });
  });
}
