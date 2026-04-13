import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../models/bible_book.dart';
import '../providers/bible_provider.dart';

// 매 빌드마다 필터링하지 않도록 캐시
final _oldTestament = bibleBooks.where((b) => b.testament == 'old').toList();
final _newTestament = bibleBooks.where((b) => b.testament == 'new').toList();

/// 성경 전문 보기 - 책 목록 화면
class BibleBooksScreen extends ConsumerStatefulWidget {
  const BibleBooksScreen({super.key});

  @override
  ConsumerState<BibleBooksScreen> createState() => _BibleBooksScreenState();
}

class _BibleBooksScreenState extends ConsumerState<BibleBooksScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final oldTestament = _oldTestament;
    final newTestament = _newTestament;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('성경', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryDark,
          unselectedLabelColor: subTextColor,
          indicatorColor: AppColors.primaryDark,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: '구약'),
            Tab(text: '신약'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookList(oldTestament, textColor, subTextColor),
          _buildBookList(newTestament, textColor, subTextColor),
        ],
      ),
    );
  }

  Widget _buildBookList(
    List<BibleBook> books,
    Color textColor,
    Color subTextColor,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLG,
        vertical: AppTheme.spacingMD,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingSM),
          child: Material(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              onTap: () {
                ref.read(bibleNavigationProvider.notifier).selectBook(book);
                context.push('/bible-full/${Uri.encodeComponent(book.name)}');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLG,
                  vertical: AppTheme.spacingMD,
                ),
                child: Row(
                  children: [
                    // 책 아이콘
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          book.name.substring(0, 1),
                          style: AppTypography.titleMedium(
                            AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMD),
                    // 책 이름
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.name,
                            style: AppTypography.titleMedium(textColor),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${book.totalChapters}장',
                            style: AppTypography.bodySmall(subTextColor),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: subTextColor.withValues(alpha: 0.5),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
