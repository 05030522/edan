import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 상점 상태
class StoreState {
  final Set<String> ownedItemIds;
  final String? equippedFrame;
  final String? equippedTitle;

  const StoreState({
    this.ownedItemIds = const {},
    this.equippedFrame,
    this.equippedTitle,
  });

  StoreState copyWith({
    Set<String>? ownedItemIds,
    String? equippedFrame,
    String? equippedTitle,
    bool clearFrame = false,
    bool clearTitle = false,
  }) {
    return StoreState(
      ownedItemIds: ownedItemIds ?? this.ownedItemIds,
      equippedFrame: clearFrame ? null : (equippedFrame ?? this.equippedFrame),
      equippedTitle: clearTitle ? null : (equippedTitle ?? this.equippedTitle),
    );
  }

  bool isOwned(String itemId) => ownedItemIds.contains(itemId);
}

/// 상점 프로바이더
class StoreNotifier extends StateNotifier<StoreState> {
  static const _keyOwnedItems = 'purchased_items';
  static const _keyEquippedFrame = 'equipped_frame';
  static const _keyEquippedTitle = 'equipped_title';

  StoreNotifier() : super(const StoreState()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final itemsJson = prefs.getString(_keyOwnedItems);
      final frame = prefs.getString(_keyEquippedFrame);
      final title = prefs.getString(_keyEquippedTitle);

      final items = itemsJson != null
          ? Set<String>.from(jsonDecode(itemsJson) as List)
          : <String>{};

      state = StoreState(
        ownedItemIds: items,
        equippedFrame: frame,
        equippedTitle: title,
      );
    } catch (e) {
      debugPrint('상점 데이터 로드 실패: $e');
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _keyOwnedItems,
        jsonEncode(state.ownedItemIds.toList()),
      );
      if (state.equippedFrame != null) {
        await prefs.setString(_keyEquippedFrame, state.equippedFrame!);
      } else {
        await prefs.remove(_keyEquippedFrame);
      }
      if (state.equippedTitle != null) {
        await prefs.setString(_keyEquippedTitle, state.equippedTitle!);
      } else {
        await prefs.remove(_keyEquippedTitle);
      }
    } catch (e) {
      debugPrint('상점 데이터 저장 실패: $e');
    }
  }

  /// 아이템 구매 (FP 차감은 호출 측에서 처리)
  Future<void> markPurchased(String itemId) async {
    final newOwned = {...state.ownedItemIds, itemId};
    state = state.copyWith(ownedItemIds: newOwned);
    await _save();
  }

  /// 프레임 장착/해제
  Future<void> equipFrame(String? frameId) async {
    if (frameId == state.equippedFrame) {
      state = state.copyWith(clearFrame: true);
    } else {
      state = state.copyWith(equippedFrame: frameId);
    }
    await _save();
  }

  /// 칭호 장착/해제
  Future<void> equipTitle(String? titleId) async {
    if (titleId == state.equippedTitle) {
      state = state.copyWith(clearTitle: true);
    } else {
      state = state.copyWith(equippedTitle: titleId);
    }
    await _save();
  }
}

/// 프로바이더 정의
final storeProvider = StateNotifierProvider<StoreNotifier, StoreState>((ref) {
  return StoreNotifier();
});
