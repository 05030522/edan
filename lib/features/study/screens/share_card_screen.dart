import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../models/lesson_data.dart';
import '../widgets/share_card.dart';

/// 묵상 완료 공유카드 화면
class ShareCardScreen extends ConsumerStatefulWidget {
  const ShareCardScreen({
    super.key,
    required this.pathId,
    required this.lessonId,
  });

  final String pathId;
  final String lessonId;

  @override
  ConsumerState<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends ConsumerState<ShareCardScreen> {
  final GlobalKey _repaintKey = GlobalKey();
  bool _isCapturing = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    // 레슨 데이터 조회
    final lesson =
        LessonDataStore.getLesson(widget.pathId, widget.lessonId) ??
        LessonDataStore.defaultLesson;
    final now = DateTime.now();
    final dateStr = '${now.year}.${now.month}.${now.day}';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => context.go('/home'),
        ),
        title: Text('묵상 완료', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.spacingLG),

                    // 축하 메시지
                    Text(
                      '오늘의 묵상을 마쳤어요! ✨',
                      style: AppTypography.headlineMedium(textColor),
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    Text(
                      '카드를 공유해서 함께 은혜를 나눠요',
                      style: AppTypography.bodyMedium(
                        isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXXL),

                    // ━━━ 공유 카드 (캡처 대상) ━━━
                    RepaintBoundary(
                      key: _repaintKey,
                      child: ShareCard(
                        date: dateStr,
                        scriptureReference: lesson.scriptureReference,
                        scriptureText: lesson.scriptureText,
                        lessonTitle: lesson.title,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXL),
                  ],
                ),
              ),
            ),

            // ━━━ 하단 버튼들 ━━━
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              child: Column(
                children: [
                  // 공유하기 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _isCapturing ? null : _shareCard,
                      icon: _isCapturing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.share, size: 20),
                      label: Text(
                        _isCapturing ? '준비 중...' : '카드 공유하기',
                        style: AppTypography.button(Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 홈으로 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => context.go('/home'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDark,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                        ),
                      ),
                      child: Text(
                        '홈으로',
                        style: AppTypography.button(AppColors.primaryDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 카드 캡처 + 공유
  Future<void> _shareCard() async {
    if (!mounted) return;
    setState(() => _isCapturing = true);

    try {
      // RepaintBoundary → 이미지 캡처
      final boundary =
          _repaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();

      // 레슨 정보로 공유 텍스트 구성
      final lesson =
          LessonDataStore.getLesson(widget.pathId, widget.lessonId) ??
          LessonDataStore.defaultLesson;

      final shareText =
          '오늘의 묵상: ${lesson.title} 🌿\n'
          '${lesson.scriptureReference}\n\n'
          '나도 에덴에서 매일 묵상하기 👇\n'
          'https://github.com/05030522/edan';

      // share_plus로 이미지 + 텍스트 + 링크 공유
      await Share.shareXFiles(
        [
          XFile.fromData(
            bytes,
            name: 'eden_meditation.png',
            mimeType: 'image/png',
          ),
        ],
        text: shareText,
        subject: '에덴 묵상 - ${lesson.title}',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('공유에 실패했어요: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }
}
