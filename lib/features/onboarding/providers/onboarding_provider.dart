import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 온보딩 데이터 모델
class OnboardingData {
  final String name;
  final String? churchName;
  final int notificationHour;
  final int notificationMinute;
  final Uint8List? avatarBytes;

  const OnboardingData({
    this.name = '',
    this.churchName,
    this.notificationHour = 8,
    this.notificationMinute = 0,
    this.avatarBytes,
  });

  OnboardingData copyWith({
    String? name,
    String? churchName,
    int? notificationHour,
    int? notificationMinute,
    Uint8List? avatarBytes,
  }) {
    return OnboardingData(
      name: name ?? this.name,
      churchName: churchName ?? this.churchName,
      notificationHour: notificationHour ?? this.notificationHour,
      notificationMinute: notificationMinute ?? this.notificationMinute,
      avatarBytes: avatarBytes ?? this.avatarBytes,
    );
  }

  String get notificationTimeFormatted =>
      '${notificationHour.toString().padLeft(2, '0')}:${notificationMinute.toString().padLeft(2, '0')}';
}

/// 온보딩 프로바이더
class OnboardingNotifier extends StateNotifier<OnboardingData> {
  OnboardingNotifier() : super(const OnboardingData());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setChurch(String? churchName) {
    state = state.copyWith(churchName: churchName);
  }

  void setNotificationTime(int hour, int minute) {
    state = state.copyWith(
      notificationHour: hour,
      notificationMinute: minute,
    );
  }

  void setAvatarBytes(Uint8List bytes) {
    state = state.copyWith(avatarBytes: bytes);
  }

  /// SharedPreferences에 온보딩 데이터 저장
  Future<void> saveToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', state.name);
      await prefs.setBool('onboarding_completed', true);

      if (state.churchName != null) {
        await prefs.setString('church_name', state.churchName!);
      }

      await prefs.setInt('notification_hour', state.notificationHour);
      await prefs.setInt('notification_minute', state.notificationMinute);
      await prefs.setString(
        'notification_time',
        state.notificationTimeFormatted,
      );
    } catch (e) {
      debugPrint('온보딩 데이터 저장 실패: $e');
    }
  }

  /// SharedPreferences에서 저장된 데이터 불러오기
  static Future<OnboardingData?> loadFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final completed = prefs.getBool('onboarding_completed') ?? false;
      if (!completed) return null;

      return OnboardingData(
        name: prefs.getString('user_name') ?? '',
        churchName: prefs.getString('church_name'),
        notificationHour: prefs.getInt('notification_hour') ?? 8,
        notificationMinute: prefs.getInt('notification_minute') ?? 0,
      );
    } catch (e) {
      debugPrint('온보딩 데이터 로드 실패: $e');
      return null;
    }
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingData>((ref) {
  return OnboardingNotifier();
});

/// 로컬에 저장된 사용자 이름 가져오기
final localUserNameProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name') ?? '사용자';
});

/// 로컬에 저장된 교회 이름 가져오기
final localChurchNameProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('church_name');
});

/// 온보딩 완료 여부
final onboardingCompletedProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_completed') ?? false;
});
