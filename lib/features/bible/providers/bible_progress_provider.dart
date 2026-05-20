import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bible_book.dart';

/// 성경 통독 진행률 상태
class BibleProgressState {
  final Set<String> readChapters; // "{책이름}:{장}" 형태
  final int totalChapters;
  final bool loaded;

  const BibleProgressState({
    this.readChapters = const {},
    this.totalChapters = 0,
    this.loaded = false,
  });

  int get readCount => readChapters.length;
  double get progress => totalChapters == 0 ? 0 : readCount / totalChapters;

  BibleProgressState copyWith({
    Set<String>? readChapters,
    int? totalChapters,
    bool? loaded,
  }) {
    return BibleProgressState(
      readChapters: readChapters ?? this.readChapters,
      totalChapters: totalChapters ?? this.totalChapters,
      loaded: loaded ?? this.loaded,
    );
  }
}

const _kBibleReadChaptersKey = 'bible_read_chapters_v1';

/// 성경 통독 진행률 프로바이더
class BibleProgressNotifier extends StateNotifier<BibleProgressState> {
  BibleProgressNotifier() : super(const BibleProgressState()) {
    final total = bibleBooks.fold<int>(0, (sum, b) => sum + b.totalChapters);
    state = state.copyWith(totalChapters: total);
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_kBibleReadChaptersKey) ?? const [];
    state = state.copyWith(readChapters: saved.toSet(), loaded: true);
  }

  /// 장 읽음 표시 (멱등)
  Future<void> markRead(String bookName, int chapter) async {
    final key = '$bookName:$chapter';
    if (state.readChapters.contains(key)) return;
    final updated = {...state.readChapters, key};
    state = state.copyWith(readChapters: updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kBibleReadChaptersKey, updated.toList());
  }
}

final bibleProgressProvider =
    StateNotifierProvider<BibleProgressNotifier, BibleProgressState>(
      (ref) => BibleProgressNotifier(),
    );
