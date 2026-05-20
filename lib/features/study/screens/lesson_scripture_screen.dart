import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../bible/data/matthew_bible_data.dart';
import '../../bible/models/bible_book.dart';
import '../../bible/providers/bible_progress_provider.dart';
import '../../premium/providers/premium_provider.dart';
import '../models/lesson_data.dart';

/// 레슨 성경 읽기 화면 (1/5 단계)
/// - 상단: 마태복음 해당 장 전체 본문 (스크롤)
/// - 하단: 내용 해설 (유료, 블러 + 잠금)
class LessonScriptureScreen extends ConsumerWidget {
  const LessonScriptureScreen({
    super.key,
    required this.pathId,
    required this.lessonId,
  });

  final String pathId;
  final String lessonId;

  /// "마태복음 1장" 형태에서 장 번호만 추출
  int? _parseChapter(String reference) {
    final match = RegExp(r'(\d+)장').firstMatch(reference);
    if (match == null) return null;
    return int.tryParse(match.group(1) ?? '');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final lesson =
        LessonDataStore.getLesson(pathId, lessonId) ??
        LessonDataStore.defaultLesson;

    final chapterNum = _parseChapter(lesson.scriptureReference);
    final BibleChapter? fullChapter =
        chapterNum != null && MatthewBibleData.hasChapter(chapterNum)
        ? MatthewBibleData.getChapter(chapterNum)
        : null;

    // 통독 진행도 마킹 (이번 화면 진입 = 해당 장 읽음)
    if (chapterNum != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(bibleProgressProvider.notifier).markRead('마태복음', chapterNum);
      });
    }

    final isPremium = ref.watch(premiumProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => context.go('/home'),
        ),
        title: Text('1/5', style: AppTypography.titleMedium(subTextColor)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacingLG),
            child: Icon(Icons.more_horiz, color: subTextColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 진행 도트
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingXL,
                vertical: AppTheme.spacingSM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.2),
                    ),
                  );
                }),
              ),
            ),

            // 본문 영역
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.spacingLG),

                    // 타이틀
                    Text(
                      lesson.title,
                      style: AppTypography.headlineMedium(textColor),
                    ),
                    const SizedBox(height: AppTheme.spacingSM),

                    // 성경 구절 레퍼런스
                    Text(
                      lesson.scriptureReference,
                      style: AppTypography.scriptureReference(AppColors.gold),
                    ),
                    const SizedBox(height: AppTheme.spacingXL),

                    // 성경 본문 (전체 절, 스크롤 가능)
                    _ScriptureSection(
                      isDark: isDark,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      fullChapter: fullChapter,
                      fallbackText: lesson.scriptureText,
                      reference: lesson.scriptureReference,
                    ),
                    const SizedBox(height: AppTheme.spacingXL),

                    // 내용 해설 (유료 콘텐츠)
                    _ExplanationSection(
                      isDark: isDark,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      explanationText: lesson.scriptureText,
                      isPremium: isPremium,
                      onUnlock: () =>
                          ref.read(premiumProvider.notifier).unlock(),
                    ),
                    const SizedBox(height: AppTheme.spacingXL),

                    // 묵상 가이드 (기존)
                    if (lesson.meditationGuide != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppTheme.spacingLG),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusMedium,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: AppColors.primaryDark,
                              size: 20,
                            ),
                            const SizedBox(width: AppTheme.spacingSM),
                            Expanded(
                              child: Text(
                                lesson.meditationGuide!,
                                style: AppTypography.bodyMedium(
                                  AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // 하단 버튼
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/study/$pathId/$lessonId/quiz');
                  },
                  child: Text(
                    '퀴즈 풀기',
                    style: AppTypography.button(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 성경 본문 섹션 (마태복음 전체 절 또는 폴백 요약)
class _ScriptureSection extends StatelessWidget {
  const _ScriptureSection({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
    required this.fullChapter,
    required this.fallbackText,
    required this.reference,
  });

  final bool isDark;
  final Color textColor;
  final Color subTextColor;
  final BibleChapter? fullChapter;
  final String fallbackText;
  final String reference;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: const Border(left: BorderSide(color: AppColors.gold, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 라벨
          Row(
            children: [
              Icon(Icons.menu_book, size: 18, color: AppColors.gold),
              const SizedBox(width: 6),
              Text(
                '말씀 전문',
                style: AppTypography.label(
                  AppColors.gold,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMD),

          if (fullChapter != null)
            // 스크롤 가능한 절 목록 (최대 높이 제한)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: fullChapter!.verses.length,
                  itemBuilder: (context, index) {
                    final v = fullChapter!.verses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            child: Text(
                              '${v.verse}',
                              style: AppTypography.label(
                                AppColors.primaryDark,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              v.text,
                              style: AppTypography.scripture(
                                textColor,
                              ).copyWith(height: 1.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          else
            // 폴백: 요약 텍스트만
            Text(fallbackText, style: AppTypography.scripture(textColor)),
        ],
      ),
    );
  }
}

/// 내용 해설 섹션 (유료 콘텐츠 - 블러 + 잠금)
class _ExplanationSection extends StatelessWidget {
  const _ExplanationSection({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
    required this.explanationText,
    required this.isPremium,
    required this.onUnlock,
  });

  final bool isDark;
  final Color textColor;
  final Color subTextColor;
  final String explanationText;
  final bool isPremium;
  final VoidCallback onUnlock;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? AppColors.darkCard : Colors.white;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology_outlined,
                        size: 18,
                        color: AppColors.primaryDark,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '내용 해설',
                        style: AppTypography.label(
                          AppColors.primaryDark,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (!isPremium) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lock_outline,
                                size: 10,
                                color: AppColors.gold,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '유료',
                                style: AppTypography.label(AppColors.gold)
                                    .copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMD),
                  Text(
                    explanationText,
                    style: AppTypography.bodyMedium(
                      textColor,
                    ).copyWith(height: 1.7),
                  ),
                ],
              ),
            ),

            // 잠금 오버레이
            if (!isPremium)
              Positioned.fill(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: (isDark ? Colors.black : Colors.white).withValues(
                        alpha: 0.3,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock,
                              color: AppColors.gold,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingMD),
                          Text(
                            '유료 콘텐츠',
                            style: AppTypography.titleMedium(
                              textColor,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '풍성한 묵상을 위해 잠금을 해제해 보세요',
                            style: AppTypography.bodySmall(subTextColor),
                          ),
                          const SizedBox(height: AppTheme.spacingMD),
                          ElevatedButton.icon(
                            onPressed: onUnlock,
                            icon: const Icon(Icons.lock_open, size: 16),
                            label: Text(
                              '미리보기 (베타)',
                              style: AppTypography.button(
                                Colors.white,
                              ).copyWith(fontSize: 13),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
