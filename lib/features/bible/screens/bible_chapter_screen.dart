import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../models/bible_book.dart';
import '../providers/bible_provider.dart';

/// 성경 전문 보기 - 장 선택 + 본문 읽기 화면
class BibleChapterScreen extends ConsumerStatefulWidget {
  final String bookName;

  const BibleChapterScreen({super.key, required this.bookName});

  @override
  ConsumerState<BibleChapterScreen> createState() => _BibleChapterScreenState();
}

class _BibleChapterScreenState extends ConsumerState<BibleChapterScreen> {
  @override
  void initState() {
    super.initState();
    // 책 이름으로 해당 BibleBook 찾아서 선택
    final book = bibleBooks.firstWhere(
      (b) => b.name == widget.bookName,
      orElse: () => bibleBooks.first,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bibleNavigationProvider.notifier).selectBook(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final navState = ref.watch(bibleNavigationProvider);
    final book = navState.selectedBook ??
        bibleBooks.firstWhere(
          (b) => b.name == widget.bookName,
          orElse: () => bibleBooks.first,
        );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            if (navState.selectedChapter != null) {
              // 본문 보기 → 장 선택으로
              ref.read(bibleNavigationProvider.notifier).selectBook(book);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          navState.selectedChapter != null
              ? '${book.name} ${navState.selectedChapter}장'
              : book.name,
          style: AppTypography.titleLarge(textColor),
        ),
        centerTitle: true,
      ),
      body: navState.selectedChapter != null
          ? _buildChapterContent(navState, textColor, subTextColor)
          : _buildChapterGrid(book, textColor, subTextColor),
    );
  }

  /// 장 선택 그리드
  Widget _buildChapterGrid(
    BibleBook book,
    Color textColor,
    Color subTextColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Text(
            '읽고 싶은 장을 선택하세요',
            style: AppTypography.bodyMedium(subTextColor),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingLG,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: book.totalChapters,
            itemBuilder: (context, index) {
              final chapter = index + 1;
              return Material(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  onTap: () {
                    ref
                        .read(bibleNavigationProvider.notifier)
                        .selectChapter(chapter);
                  },
                  child: Center(
                    child: Text(
                      '$chapter',
                      style: AppTypography.titleMedium(textColor),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// 장 본문 표시
  Widget _buildChapterContent(
    BibleNavigationState navState,
    Color textColor,
    Color subTextColor,
  ) {
    final chapter = navState.chapterContent;
    if (chapter == null) {
      return Center(
        child: Text(
          '성경 내용을 준비 중입니다...',
          style: AppTypography.bodyMedium(subTextColor),
        ),
      );
    }

    return Column(
      children: [
        // 본문
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            itemCount: chapter.verses.length,
            itemBuilder: (context, index) {
              final verse = chapter.verses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingMD),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 절 번호
                    SizedBox(
                      width: 28,
                      child: Text(
                        '${verse.verse}',
                        style: AppTypography.label(
                          AppColors.primaryDark,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    // 본문 텍스트
                    Expanded(
                      child: Text(
                        verse.text,
                        style: AppTypography.scripture(textColor).copyWith(
                          height: 1.8,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // 하단 이전/다음 장 네비게이션
        _buildBottomNav(navState, textColor, subTextColor),
      ],
    );
  }

  /// 하단 이전/다음 장 버튼
  Widget _buildBottomNav(
    BibleNavigationState navState,
    Color textColor,
    Color subTextColor,
  ) {
    final book = navState.selectedBook!;
    final chapter = navState.selectedChapter!;
    final hasPrev = chapter > 1;
    final hasNext = chapter < book.totalChapters;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLG,
        vertical: AppTheme.spacingMD,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackgroundSecondary
            : AppColors.lightBackgroundSecondary,
        border: Border(
          top: BorderSide(
            color: subTextColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 이전 장
            TextButton.icon(
              onPressed: hasPrev
                  ? () => ref
                      .read(bibleNavigationProvider.notifier)
                      .selectChapter(chapter - 1)
                  : null,
              icon: const Icon(Icons.chevron_left, size: 18),
              label: Text(
                hasPrev ? '${chapter - 1}장' : '',
                style: AppTypography.bodySmall(
                  hasPrev ? AppColors.primaryDark : subTextColor,
                ),
              ),
            ),
            // 장 목록으로
            TextButton(
              onPressed: () {
                ref
                    .read(bibleNavigationProvider.notifier)
                    .selectBook(book);
              },
              child: Text(
                '목록',
                style: AppTypography.bodySmall(subTextColor),
              ),
            ),
            // 다음 장
            TextButton.icon(
              onPressed: hasNext
                  ? () => ref
                      .read(bibleNavigationProvider.notifier)
                      .selectChapter(chapter + 1)
                  : null,
              icon: Text(
                hasNext ? '${chapter + 1}장' : '',
                style: AppTypography.bodySmall(
                  hasNext ? AppColors.primaryDark : subTextColor,
                ),
              ),
              label: const Icon(Icons.chevron_right, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
