import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/point_toast.dart';
import '../../../shared/utils/streak_helper.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/daily_tasks_provider.dart';

/// 기도하기 화면 - 한 줄 기도 작성 후 완료
class PrayerScreen extends ConsumerStatefulWidget {
  const PrayerScreen({super.key});

  @override
  ConsumerState<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends ConsumerState<PrayerScreen>
    with SingleTickerProviderStateMixin {
  final _prayerController = TextEditingController();
  bool _isCompleted = false;
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _prayerController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _submitPrayer() async {
    if (_prayerController.text.trim().isEmpty) return;

    final reward =
        ref.read(dailyTasksProvider.notifier).completeTask(DailyTaskType.prayer);

    // 프로필 달란트 즉시 반영
    if (reward > 0) {
      ref.read(authProvider.notifier).addFaithPoints(reward);
    }

    setState(() => _isCompleted = true);
    _animController.forward();

    if (reward > 0) {
      final size = MediaQuery.of(context).size;
      PointToast.show(
        context,
        points: reward,
        sourceOffset: Offset(size.width / 2, size.height * 0.4),
      );
    }

    // 토스트가 뜰 시간 확보
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    // 스트릭 체크 — 축하 다이얼로그가 뜨면 사용자가 닫을 때까지 대기
    await StreakHelper.checkAndUpdate(context, ref);
    if (!mounted) return;

    // 사용자가 축하 다이얼로그를 닫은 후에야 홈으로 복귀
    Navigator.of(context).pop();
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('기도하기', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isCompleted ? _buildCompleted(textColor) : _buildInput(textColor, subTextColor),
      ),
    );
  }

  Widget _buildInput(Color textColor, Color subTextColor) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppTheme.spacingXL),

          // 기도 아이콘
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE5C88E).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volunteer_activism,
                color: Color(0xFFE5C88E),
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          Center(
            child: Text(
              '오늘 하나님께 드리는\n한 줄 기도를 적어보세요',
              textAlign: TextAlign.center,
              style: AppTypography.headlineMedium(textColor),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSM),
          Center(
            child: Text(
              '짧아도 괜찮아요, 마음을 담아 적어보세요',
              style: AppTypography.bodyMedium(subTextColor),
            ),
          ),
          const SizedBox(height: AppTheme.spacing3XL),

          // 기도 입력
          TextField(
            controller: _prayerController,
            maxLength: 100,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '예) 주님, 오늘도 감사합니다...',
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(AppTheme.spacingLG),
            ),
          ),

          const Spacer(),

          // 기도하기 버튼 - 텍스트 변경 시 버튼만 rebuild
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _prayerController,
            builder: (context, value, _) {
              final hasText = value.text.trim().isNotEmpty;
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: hasText ? _submitPrayer : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🙏', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Text('아멘', style: AppTypography.button(Colors.white)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppTheme.spacingXL),
        ],
      ),
    );
  }

  Widget _buildCompleted(Color textColor) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 50),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              '기도를 올려드렸어요',
              style: AppTypography.headlineLarge(textColor),
            ),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              '"${_prayerController.text.trim()}"',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(
                textColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
