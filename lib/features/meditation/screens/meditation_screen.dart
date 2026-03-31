import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/point_toast.dart';
import '../../../shared/utils/streak_helper.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/daily_tasks_provider.dart';
import '../../study/data/matthew_meditation_data.dart';

/// 묵상하기 화면 - 말씀을 읽고 느낀 점 작성 후 완료
class MeditationScreen extends ConsumerStatefulWidget {
  const MeditationScreen({super.key});

  @override
  ConsumerState<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends ConsumerState<MeditationScreen>
    with SingleTickerProviderStateMixin {
  final _reflectionController = TextEditingController();
  int _step = 0; // 0: 말씀 읽기, 1: 느낀 점 작성, 2: 완료
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;

  // 오늘의 묵상 말씀 (날짜 기반)
  late final _MeditationContent _todayContent;

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

    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;

    // 마태복음 묵상 데이터가 있으면 확장된 풀에서 선택
    final matthewContents = MatthewMeditationData.meditationContents;
    if (matthewContents.isNotEmpty) {
      final allContents = [
        ..._meditationContents,
        ...matthewContents.map((m) => _MeditationContent(
              theme: m.theme,
              verse: m.topic,
              reference: '마태복음 ${m.chapter}장',
              guide: m.guide,
            )),
      ];
      _todayContent = allContents[dayOfYear % allContents.length];
    } else {
      _todayContent = _meditationContents[dayOfYear % _meditationContents.length];
    }
  }

  @override
  void dispose() {
    _reflectionController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _goToReflection() {
    setState(() => _step = 1);
  }

  void _submitReflection() {
    if (_reflectionController.text.trim().isEmpty) return;

    final reward = ref
        .read(dailyTasksProvider.notifier)
        .completeTask(DailyTaskType.meditation);

    // 프로필 FP 즉시 반영
    if (reward > 0) {
      ref.read(authProvider.notifier).addFaithPoints(reward);
    }

    // 스트릭 체크
    StreakHelper.checkAndUpdate(context, ref);

    setState(() => _step = 2);
    _animController.forward();

    if (reward > 0) {
      final size = MediaQuery.of(context).size;
      PointToast.show(
        context,
        points: reward,
        sourceOffset: Offset(size.width / 2, size.height * 0.4),
      );
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) Navigator.of(context).pop();
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('묵상하기', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
        actions: [
          if (_step < 2)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${_step + 1}/2',
                  style: AppTypography.label(subTextColor),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _step == 0
              ? _buildScriptureStep(textColor, subTextColor)
              : _step == 1
                  ? _buildReflectionStep(textColor, subTextColor)
                  : _buildCompleted(textColor),
        ),
      ),
    );
  }

  /// Step 1: 말씀 읽기
  Widget _buildScriptureStep(Color textColor, Color subTextColor) {
    return SingleChildScrollView(
      key: const ValueKey('step0'),
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 주제
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF8D6E63).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusRound),
              ),
              child: Text(
                _todayContent.theme,
                style: AppTypography.label(const Color(0xFF8D6E63)),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          // 말씀 본문
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            decoration: BoxDecoration(
              color: isDark(context)
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border.all(
                color: const Color(0xFF8D6E63).withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              children: [
                Text(
                  _todayContent.verse,
                  style: AppTypography.scripture(textColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingLG),
                Divider(color: subTextColor.withValues(alpha: 0.2)),
                const SizedBox(height: AppTheme.spacingSM),
                Text(
                  _todayContent.reference,
                  style: AppTypography.scriptureReference(subTextColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          // 묵상 가이드
          Text('묵상 가이드', style: AppTypography.titleLarge(textColor)),
          const SizedBox(height: AppTheme.spacingMD),
          Text(
            _todayContent.guide,
            style: AppTypography.bodyMedium(subTextColor).copyWith(height: 1.8),
          ),
          const SizedBox(height: AppTheme.spacing3XL),

          // 다음 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goToReflection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF8D6E63),
              ),
              child: Text('느낀 점 적기 →',
                  style: AppTypography.button(Colors.white)),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),
        ],
      ),
    );
  }

  /// Step 2: 느낀 점 작성
  Widget _buildReflectionStep(Color textColor, Color subTextColor) {
    return Padding(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 참고 말씀 미니
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8D6E63).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_stories,
                    color: Color(0xFF8D6E63), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _todayContent.reference,
                    style: AppTypography.label(const Color(0xFF8D6E63)),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _step = 0),
                  child: const Text('다시 읽기',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          Text(
            '오늘 말씀을 통해\n느낀 점을 적어보세요',
            style: AppTypography.headlineMedium(textColor),
          ),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            '짧은 한 줄이라도 좋아요',
            style: AppTypography.bodyMedium(subTextColor),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          TextField(
            controller: _reflectionController,
            maxLength: 200,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '예) 하나님이 항상 함께 하신다는 것을 다시 느꼈다...',
              filled: true,
              fillColor: isDark(context)
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

          // 버튼만 텍스트 변경 시 rebuild
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _reflectionController,
            builder: (context, value, _) {
              final hasText = value.text.trim().isNotEmpty;
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: hasText ? _submitReflection : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('묵상 완료', style: AppTypography.button(Colors.white)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusRound),
                        ),
                        child: Text(
                          '+10 FP',
                          style: AppTypography.label(Colors.white)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
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

  /// 완료 화면
  Widget _buildCompleted(Color textColor) {
    return FadeTransition(
      key: const ValueKey('step2'),
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
            Text('묵상을 마쳤어요', style: AppTypography.headlineLarge(textColor)),
            const SizedBox(height: AppTheme.spacingSM),
            Text(
              _todayContent.theme,
              style: AppTypography.bodyMedium(
                textColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

/// 묵상 콘텐츠 모델
class _MeditationContent {
  final String theme;
  final String verse;
  final String reference;
  final String guide;

  const _MeditationContent({
    required this.theme,
    required this.verse,
    required this.reference,
    required this.guide,
  });
}

const _meditationContents = [
  _MeditationContent(
    theme: '두려움을 이기는 믿음',
    verse: '두려워하지 말라 내가 너와 함께 함이라\n놀라지 말라 나는 네 하나님이 됨이라\n내가 너를 굳세게 하리라 참으로 너를 도와주리라\n참으로 나의 의로운 오른손으로 너를 붙들리라',
    reference: '이사야 41:10',
    guide: '오늘 당신이 두려워하는 것은 무엇인가요?\n하나님이 "두려워하지 말라"고 말씀하실 때, 그 이유가 "내가 너와 함께 함이라"인 것에 주목해보세요.\n함께하시는 하나님을 신뢰하며, 오늘의 두려움을 내려놓아 보세요.',
  ),
  _MeditationContent(
    theme: '쉼을 주시는 예수님',
    verse: '수고하고 무거운 짐 진 자들아\n다 내게로 오라\n내가 너희를 쉬게 하리라',
    reference: '마태복음 11:28',
    guide: '지금 당신이 짊어지고 있는 무거운 짐은 무엇인가요?\n예수님은 그 짐을 대신 져주겠다고 하십니다.\n오늘 하루, 그 짐을 예수님께 내려놓는 연습을 해보세요.',
  ),
  _MeditationContent(
    theme: '염려를 맡기는 삶',
    verse: '너희 염려를 다 주께 맡기라\n이는 그가 너희를 돌보심이라',
    reference: '베드로전서 5:7',
    guide: '오늘 마음에 걸리는 염려가 있나요?\n하나님은 우리의 작은 염려까지도 관심을 가지고 계십니다.\n"그가 너희를 돌보심이라"는 말씀을 마음에 새겨보세요.',
  ),
  _MeditationContent(
    theme: '합력하여 선을 이루심',
    verse: '우리가 알거니와 하나님을 사랑하는 자\n곧 그의 뜻대로 부르심을 입은 자들에게는\n모든 것이 합력하여 선을 이루느니라',
    reference: '로마서 8:28',
    guide: '지금은 이해되지 않는 상황이 있나요?\n하나님은 모든 것을 합력하여 선을 이루십니다.\n현재의 어려움도 하나님의 큰 그림 안에 있음을 기억해보세요.',
  ),
  _MeditationContent(
    theme: '새 힘을 얻는 자',
    verse: '오직 여호와를 앙망하는 자는 새 힘을 얻으리니\n독수리가 날개치며 올라감 같을 것이요\n달음박질하여도 곤비하지 아니하겠고\n걸어가도 피곤하지 아니하리로다',
    reference: '이사야 40:31',
    guide: '지치고 힘이 빠진 날이 있나요?\n하나님을 앙망(바라봄)하는 것만으로도 새 힘을 얻을 수 있습니다.\n오늘 잠시 멈추고, 하나님을 바라보는 시간을 가져보세요.',
  ),
  _MeditationContent(
    theme: '길이요 진리요 생명',
    verse: '예수께서 이르시되\n내가 곧 길이요 진리요 생명이니\n나로 말미암지 않고는\n아버지께로 올 자가 없느니라',
    reference: '요한복음 14:6',
    guide: '인생에서 길을 잃은 것 같은 느낌이 든 적이 있나요?\n예수님은 스스로를 "길"이라고 말씀하셨습니다.\n오늘 예수님이 보여주시는 길을 따라가는 것에 대해 묵상해보세요.',
  ),
  _MeditationContent(
    theme: '내게 능력 주시는 자',
    verse: '내게 능력 주시는 자 안에서\n내가 모든 것을 할 수 있느니라',
    reference: '빌립보서 4:13',
    guide: '"내 힘으로는 안 돼"라고 느끼는 일이 있나요?\n바울은 감옥에서도 이 고백을 했습니다.\n내 능력이 아닌, 능력 주시는 분을 의지하는 것이 핵심입니다.',
  ),
];
