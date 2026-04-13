import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bible_book.dart';
import '../data/matthew_bible_data.dart';

/// 현재 선택된 성경 책/장 상태
class BibleNavigationState {
  final BibleBook? selectedBook;
  final int? selectedChapter;
  final BibleChapter? chapterContent;

  const BibleNavigationState({
    this.selectedBook,
    this.selectedChapter,
    this.chapterContent,
  });

  BibleNavigationState copyWith({
    BibleBook? selectedBook,
    int? selectedChapter,
    BibleChapter? chapterContent,
    bool clearChapter = false,
    bool clearContent = false,
  }) {
    return BibleNavigationState(
      selectedBook: selectedBook ?? this.selectedBook,
      selectedChapter: clearChapter
          ? null
          : (selectedChapter ?? this.selectedChapter),
      chapterContent: clearContent
          ? null
          : (chapterContent ?? this.chapterContent),
    );
  }
}

/// 성경 네비게이션 프로바이더
final bibleNavigationProvider =
    StateNotifierProvider<BibleNavigationNotifier, BibleNavigationState>(
      (ref) => BibleNavigationNotifier(),
    );

class BibleNavigationNotifier extends StateNotifier<BibleNavigationState> {
  BibleNavigationNotifier() : super(const BibleNavigationState());

  /// 책 선택
  void selectBook(BibleBook book) {
    state = BibleNavigationState(selectedBook: book);
  }

  /// 장 선택 → 실제 데이터 로드
  void selectChapter(int chapter) {
    if (state.selectedBook == null) return;

    final bookName = state.selectedBook!.name;

    // 마태복음은 실제 데이터 사용
    if (bookName == '마태복음' && MatthewBibleData.hasChapter(chapter)) {
      state = state.copyWith(
        selectedChapter: chapter,
        chapterContent: MatthewBibleData.getChapter(chapter),
      );
      return;
    }

    // 다른 책은 준비 중 안내
    final placeholderVerses = [
      BibleVerse(
        verse: 1,
        text:
            '$bookName $chapter장은 아직 준비 중이에요.\n\n'
            '현재 마태복음 전문을 읽을 수 있어요.\n'
            '다른 성경 본문도 곧 추가될 예정이에요!',
      ),
    ];

    state = state.copyWith(
      selectedChapter: chapter,
      chapterContent: BibleChapter(
        bookName: bookName,
        chapter: chapter,
        verses: placeholderVerses,
      ),
    );
  }

  /// 초기화
  void reset() {
    state = const BibleNavigationState();
  }
}
