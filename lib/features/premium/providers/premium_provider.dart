import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 프리미엄(유료 콘텐츠 잠금 해제) 상태
/// v1: 결제 시스템 미연동 → 기본값 false. 추후 결제 연동 시 확장.
class PremiumNotifier extends StateNotifier<bool> {
  PremiumNotifier() : super(false);

  void unlock() => state = true;
  void lock() => state = false;
}

final premiumProvider = StateNotifierProvider<PremiumNotifier, bool>(
  (ref) => PremiumNotifier(),
);
