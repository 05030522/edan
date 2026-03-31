/// 성경 책 모델
class BibleBook {
  final String name; // 예: '창세기'
  final String testament; // 'old' or 'new'
  final int totalChapters;

  const BibleBook({
    required this.name,
    required this.testament,
    required this.totalChapters,
  });
}

/// 성경 장 모델 (전문 텍스트 포함)
class BibleChapter {
  final String bookName;
  final int chapter;
  final List<BibleVerse> verses;

  const BibleChapter({
    required this.bookName,
    required this.chapter,
    required this.verses,
  });

  String get reference => '$bookName $chapter장';
}

/// 성경 구절 모델
class BibleVerse {
  final int verse;
  final String text;

  const BibleVerse({
    required this.verse,
    required this.text,
  });
}

/// 성경 66권 목록 (장 수 포함)
const List<BibleBook> bibleBooks = [
  // ── 구약 39권 ──
  BibleBook(name: '창세기', testament: 'old', totalChapters: 50),
  BibleBook(name: '출애굽기', testament: 'old', totalChapters: 40),
  BibleBook(name: '레위기', testament: 'old', totalChapters: 27),
  BibleBook(name: '민수기', testament: 'old', totalChapters: 36),
  BibleBook(name: '신명기', testament: 'old', totalChapters: 34),
  BibleBook(name: '여호수아', testament: 'old', totalChapters: 24),
  BibleBook(name: '사사기', testament: 'old', totalChapters: 21),
  BibleBook(name: '룻기', testament: 'old', totalChapters: 4),
  BibleBook(name: '사무엘상', testament: 'old', totalChapters: 31),
  BibleBook(name: '사무엘하', testament: 'old', totalChapters: 24),
  BibleBook(name: '열왕기상', testament: 'old', totalChapters: 22),
  BibleBook(name: '열왕기하', testament: 'old', totalChapters: 25),
  BibleBook(name: '역대상', testament: 'old', totalChapters: 29),
  BibleBook(name: '역대하', testament: 'old', totalChapters: 36),
  BibleBook(name: '에스라', testament: 'old', totalChapters: 10),
  BibleBook(name: '느헤미야', testament: 'old', totalChapters: 13),
  BibleBook(name: '에스더', testament: 'old', totalChapters: 10),
  BibleBook(name: '욥기', testament: 'old', totalChapters: 42),
  BibleBook(name: '시편', testament: 'old', totalChapters: 150),
  BibleBook(name: '잠언', testament: 'old', totalChapters: 31),
  BibleBook(name: '전도서', testament: 'old', totalChapters: 12),
  BibleBook(name: '아가', testament: 'old', totalChapters: 8),
  BibleBook(name: '이사야', testament: 'old', totalChapters: 66),
  BibleBook(name: '예레미야', testament: 'old', totalChapters: 52),
  BibleBook(name: '예레미야애가', testament: 'old', totalChapters: 5),
  BibleBook(name: '에스겔', testament: 'old', totalChapters: 48),
  BibleBook(name: '다니엘', testament: 'old', totalChapters: 12),
  BibleBook(name: '호세아', testament: 'old', totalChapters: 14),
  BibleBook(name: '요엘', testament: 'old', totalChapters: 3),
  BibleBook(name: '아모스', testament: 'old', totalChapters: 9),
  BibleBook(name: '오바댜', testament: 'old', totalChapters: 1),
  BibleBook(name: '요나', testament: 'old', totalChapters: 4),
  BibleBook(name: '미가', testament: 'old', totalChapters: 7),
  BibleBook(name: '나훔', testament: 'old', totalChapters: 3),
  BibleBook(name: '하박국', testament: 'old', totalChapters: 3),
  BibleBook(name: '스바냐', testament: 'old', totalChapters: 3),
  BibleBook(name: '학개', testament: 'old', totalChapters: 2),
  BibleBook(name: '스가랴', testament: 'old', totalChapters: 14),
  BibleBook(name: '말라기', testament: 'old', totalChapters: 4),
  // ── 신약 27권 ──
  BibleBook(name: '마태복음', testament: 'new', totalChapters: 28),
  BibleBook(name: '마가복음', testament: 'new', totalChapters: 16),
  BibleBook(name: '누가복음', testament: 'new', totalChapters: 24),
  BibleBook(name: '요한복음', testament: 'new', totalChapters: 21),
  BibleBook(name: '사도행전', testament: 'new', totalChapters: 28),
  BibleBook(name: '로마서', testament: 'new', totalChapters: 16),
  BibleBook(name: '고린도전서', testament: 'new', totalChapters: 16),
  BibleBook(name: '고린도후서', testament: 'new', totalChapters: 13),
  BibleBook(name: '갈라디아서', testament: 'new', totalChapters: 6),
  BibleBook(name: '에베소서', testament: 'new', totalChapters: 6),
  BibleBook(name: '빌립보서', testament: 'new', totalChapters: 4),
  BibleBook(name: '골로새서', testament: 'new', totalChapters: 4),
  BibleBook(name: '데살로니가전서', testament: 'new', totalChapters: 5),
  BibleBook(name: '데살로니가후서', testament: 'new', totalChapters: 3),
  BibleBook(name: '디모데전서', testament: 'new', totalChapters: 6),
  BibleBook(name: '디모데후서', testament: 'new', totalChapters: 4),
  BibleBook(name: '디도서', testament: 'new', totalChapters: 3),
  BibleBook(name: '빌레몬서', testament: 'new', totalChapters: 1),
  BibleBook(name: '히브리서', testament: 'new', totalChapters: 13),
  BibleBook(name: '야고보서', testament: 'new', totalChapters: 5),
  BibleBook(name: '베드로전서', testament: 'new', totalChapters: 5),
  BibleBook(name: '베드로후서', testament: 'new', totalChapters: 3),
  BibleBook(name: '요한일서', testament: 'new', totalChapters: 5),
  BibleBook(name: '요한이서', testament: 'new', totalChapters: 1),
  BibleBook(name: '요한삼서', testament: 'new', totalChapters: 1),
  BibleBook(name: '유다서', testament: 'new', totalChapters: 1),
  BibleBook(name: '요한계시록', testament: 'new', totalChapters: 28),
];
