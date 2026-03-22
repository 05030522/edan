import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// 효과음 서비스 (듀오링고 스타일)
/// 싱글톤 패턴으로 앱 전역에서 효과음 재생
class SoundService {
  SoundService._();
  static final SoundService _instance = SoundService._();
  static SoundService get instance => _instance;

  final AudioPlayer _player = AudioPlayer();
  bool _initialized = false;

  /// 초기화 (앱 시작 시 호출)
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    // Web에서는 사용자 인터랙션 후에만 오디오 재생 가능
    await _player.setReleaseMode(ReleaseMode.stop);
  }

  /// 정답 효과음 (띵똥 chime)
  Future<void> playCorrect() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/correct.mp3'));
    } catch (e) {
      debugPrint('효과음 재생 실패 (correct): $e');
    }
  }

  /// 오답 효과음 (삐익 buzzer)
  Future<void> playWrong() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/wrong.mp3'));
    } catch (e) {
      debugPrint('효과음 재생 실패 (wrong): $e');
    }
  }

  /// 퀴즈 완료 효과음 (짝짝짝)
  Future<void> playComplete() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/complete.mp3'));
    } catch (e) {
      debugPrint('효과음 재생 실패 (complete): $e');
    }
  }

  /// 포인트 획득 효과음
  Future<void> playPointEarned() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/point.mp3'));
    } catch (e) {
      debugPrint('효과음 재생 실패 (point): $e');
    }
  }

  /// 리소스 해제
  void dispose() {
    _player.dispose();
  }
}
