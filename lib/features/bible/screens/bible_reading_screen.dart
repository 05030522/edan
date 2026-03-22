import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/point_toast.dart';
import '../../home/providers/daily_tasks_provider.dart';

/// 오늘의 말씀 읽기 데이터 (창세기부터 순서대로)
class _BibleChapter {
  final String book;
  final int chapter;
  final String keyVerse;
  final String keyVerseRef;
  final String summary;

  const _BibleChapter({
    required this.book,
    required this.chapter,
    required this.keyVerse,
    required this.keyVerseRef,
    required this.summary,
  });
}

// 매일 바뀌는 성경 읽기 목록 (60일치)
const _chapters = [
  _BibleChapter(book: '창세기', chapter: 1, keyVerse: '태초에 하나님이 천지를 창조하시니라', keyVerseRef: '창세기 1:1', summary: '하나님의 천지 창조'),
  _BibleChapter(book: '창세기', chapter: 2, keyVerse: '여호와 하나님이 땅의 흙으로 사람을 지으시고 생기를 그 코에 불어넣으시니 사람이 생령이 되니라', keyVerseRef: '창세기 2:7', summary: '에덴동산과 아담'),
  _BibleChapter(book: '창세기', chapter: 3, keyVerse: '여자가 그 나무를 본즉 먹음직도 하고 보암직도 하고 지혜롭게 할 만큼 탐스럽기도 한 나무인지라', keyVerseRef: '창세기 3:6', summary: '인간의 타락'),
  _BibleChapter(book: '창세기', chapter: 6, keyVerse: '그러나 노아는 여호와께 은혜를 입었더라', keyVerseRef: '창세기 6:8', summary: '노아와 홍수'),
  _BibleChapter(book: '창세기', chapter: 12, keyVerse: '내가 너로 큰 민족을 이루고 네게 복을 주어 네 이름을 창대하게 하리니 너는 복이 될지라', keyVerseRef: '창세기 12:2', summary: '아브라함의 부르심'),
  _BibleChapter(book: '창세기', chapter: 22, keyVerse: '아브라함이 그 곳 이름을 여호와 이레라 하였으므로', keyVerseRef: '창세기 22:14', summary: '이삭을 바치는 아브라함'),
  _BibleChapter(book: '창세기', chapter: 28, keyVerse: '볼지어다 내가 너와 함께 있어 네가 어디로 가든지 너를 지키며', keyVerseRef: '창세기 28:15', summary: '야곱의 꿈'),
  _BibleChapter(book: '창세기', chapter: 37, keyVerse: '요셉이 꿈을 꾸고 그의 형들에게 말하매 그들이 그를 더욱 미워하였더라', keyVerseRef: '창세기 37:5', summary: '요셉의 꿈'),
  _BibleChapter(book: '창세기', chapter: 45, keyVerse: '하나님이 큰 구원으로 당신들의 생명을 보존하시려고 나를 당신들보다 먼저 보내셨나이다', keyVerseRef: '창세기 45:7', summary: '요셉과 형제들의 화해'),
  _BibleChapter(book: '창세기', chapter: 50, keyVerse: '당신들은 나를 해하려 하였으나 하나님은 그것을 선으로 바꾸사', keyVerseRef: '창세기 50:20', summary: '악을 선으로 바꾸시는 하나님'),
  _BibleChapter(book: '출애굽기', chapter: 3, keyVerse: '내가 반드시 너와 함께 있으리라', keyVerseRef: '출애굽기 3:12', summary: '모세의 부르심'),
  _BibleChapter(book: '출애굽기', chapter: 14, keyVerse: '여호와께서 너희를 위하여 싸우시리니 너희는 가만히 있을지니라', keyVerseRef: '출애굽기 14:14', summary: '홍해를 가르시는 하나님'),
  _BibleChapter(book: '출애굽기', chapter: 20, keyVerse: '나는 너를 애굽 땅, 종 되었던 집에서 인도하여 낸 네 하나님 여호와니라', keyVerseRef: '출애굽기 20:2', summary: '십계명'),
  _BibleChapter(book: '여호수아', chapter: 1, keyVerse: '강하고 담대하라 두려워하지 말며 놀라지 말라 네가 어디로 가든지 네 하나님 여호와가 너와 함께 하느니라', keyVerseRef: '여호수아 1:9', summary: '여호수아의 사명'),
  _BibleChapter(book: '시편', chapter: 23, keyVerse: '여호와는 나의 목자시니 내게 부족함이 없으리로다', keyVerseRef: '시편 23:1', summary: '선한 목자'),
  _BibleChapter(book: '시편', chapter: 27, keyVerse: '여호와는 나의 빛이요 나의 구원이시니 내가 누구를 두려워하리요', keyVerseRef: '시편 27:1', summary: '두려움을 이기는 믿음'),
  _BibleChapter(book: '시편', chapter: 37, keyVerse: '네 길을 여호와께 맡기라 그를 의지하면 그가 이루시리로다', keyVerseRef: '시편 37:5', summary: '여호와를 의지하라'),
  _BibleChapter(book: '시편', chapter: 46, keyVerse: '하나님은 우리의 피난처시요 힘이시니 환난 중에 만날 큰 도움이시라', keyVerseRef: '시편 46:1', summary: '환난 중의 피난처'),
  _BibleChapter(book: '시편', chapter: 91, keyVerse: '지극히 높으신 이의 은밀한 곳에 거주하는 자는 전능하신 이의 그늘 아래에 살리로다', keyVerseRef: '시편 91:1', summary: '하나님의 보호'),
  _BibleChapter(book: '시편', chapter: 121, keyVerse: '내가 산을 향하여 눈을 들리라 나의 도움이 어디서 올까 나의 도움은 천지를 지으신 여호와에게서로다', keyVerseRef: '시편 121:1-2', summary: '도움의 근원'),
  _BibleChapter(book: '잠언', chapter: 3, keyVerse: '너는 마음을 다하여 여호와를 신뢰하고 네 명철을 의지하지 말라', keyVerseRef: '잠언 3:5', summary: '여호와를 신뢰하라'),
  _BibleChapter(book: '잠언', chapter: 4, keyVerse: '모든 지킬 만한 것 중에 더욱 네 마음을 지키라 생명의 근원이 이에서 남이니라', keyVerseRef: '잠언 4:23', summary: '마음을 지키라'),
  _BibleChapter(book: '이사야', chapter: 40, keyVerse: '오직 여호와를 앙망하는 자는 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요', keyVerseRef: '이사야 40:31', summary: '새 힘을 얻는 자'),
  _BibleChapter(book: '이사야', chapter: 41, keyVerse: '두려워하지 말라 내가 너와 함께 함이라 놀라지 말라 나는 네 하나님이 됨이라', keyVerseRef: '이사야 41:10', summary: '두려워 말라'),
  _BibleChapter(book: '예레미야', chapter: 29, keyVerse: '너희를 향한 나의 생각을 내가 아나니 평안이요 재앙이 아니니라 너희에게 미래와 희망을 주는 것이니라', keyVerseRef: '예레미야 29:11', summary: '희망의 약속'),
  _BibleChapter(book: '마태복음', chapter: 5, keyVerse: '심령이 가난한 자는 복이 있나니 천국이 그들의 것임이요', keyVerseRef: '마태복음 5:3', summary: '산상수훈 - 팔복'),
  _BibleChapter(book: '마태복음', chapter: 6, keyVerse: '그런즉 너희는 먼저 그의 나라와 그의 의를 구하라 그리하면 이 모든 것을 너희에게 더하시리라', keyVerseRef: '마태복음 6:33', summary: '먼저 그의 나라를 구하라'),
  _BibleChapter(book: '마태복음', chapter: 7, keyVerse: '구하라 그리하면 너희에게 주실 것이요 찾으라 그리하면 찾아낼 것이요', keyVerseRef: '마태복음 7:7', summary: '구하라 찾으라 두드리라'),
  _BibleChapter(book: '마태복음', chapter: 11, keyVerse: '수고하고 무거운 짐 진 자들아 다 내게로 오라 내가 너희를 쉬게 하리라', keyVerseRef: '마태복음 11:28', summary: '쉼을 주시는 예수님'),
  _BibleChapter(book: '마태복음', chapter: 28, keyVerse: '볼지어다 내가 세상 끝날까지 너희와 항상 함께 있으리라', keyVerseRef: '마태복음 28:20', summary: '대사명'),
  _BibleChapter(book: '요한복음', chapter: 1, keyVerse: '태초에 말씀이 계시니라 이 말씀이 하나님과 함께 계셨으니 이 말씀은 곧 하나님이시니라', keyVerseRef: '요한복음 1:1', summary: '말씀이 육신이 되다'),
  _BibleChapter(book: '요한복음', chapter: 3, keyVerse: '하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니 이는 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라', keyVerseRef: '요한복음 3:16', summary: '하나님의 사랑'),
  _BibleChapter(book: '요한복음', chapter: 10, keyVerse: '내가 온 것은 양으로 생명을 얻게 하고 더 풍성히 얻게 하려는 것이라', keyVerseRef: '요한복음 10:10', summary: '선한 목자 예수님'),
  _BibleChapter(book: '요한복음', chapter: 14, keyVerse: '내가 곧 길이요 진리요 생명이니 나로 말미암지 않고는 아버지께로 올 자가 없느니라', keyVerseRef: '요한복음 14:6', summary: '길이요 진리요 생명'),
  _BibleChapter(book: '요한복음', chapter: 15, keyVerse: '내 안에 거하라 나도 너희 안에 거하리라 가지가 포도나무에 붙어 있지 아니하면 스스로 열매를 맺을 수 없음 같이', keyVerseRef: '요한복음 15:4', summary: '참 포도나무'),
  _BibleChapter(book: '로마서', chapter: 5, keyVerse: '우리가 아직 죄인 되었을 때에 그리스도께서 우리를 위하여 죽으심으로 하나님께서 우리에 대한 자기의 사랑을 확증하셨느니라', keyVerseRef: '로마서 5:8', summary: '하나님의 확증된 사랑'),
  _BibleChapter(book: '로마서', chapter: 8, keyVerse: '우리가 알거니와 하나님을 사랑하는 자 곧 그의 뜻대로 부르심을 입은 자들에게는 모든 것이 합력하여 선을 이루느니라', keyVerseRef: '로마서 8:28', summary: '합력하여 선을 이루심'),
  _BibleChapter(book: '로마서', chapter: 12, keyVerse: '너희 몸을 하나님이 기뻐하시는 거룩한 산 제물로 드리라 이는 너희가 드릴 영적 예배니라', keyVerseRef: '로마서 12:1', summary: '산 제물의 삶'),
  _BibleChapter(book: '고린도전서', chapter: 13, keyVerse: '사랑은 오래 참고 사랑은 온유하며 시기하지 아니하며', keyVerseRef: '고린도전서 13:4', summary: '사랑의 장'),
  _BibleChapter(book: '갈라디아서', chapter: 5, keyVerse: '오직 성령의 열매는 사랑과 희락과 화평과 오래 참음과 자비와 양선과 충성과 온유와 절제니', keyVerseRef: '갈라디아서 5:22-23', summary: '성령의 열매'),
  _BibleChapter(book: '에베소서', chapter: 2, keyVerse: '너희는 그 은혜에 의하여 믿음으로 말미암아 구원을 받았으니 이것은 너희에게서 난 것이 아니요 하나님의 선물이라', keyVerseRef: '에베소서 2:8', summary: '은혜로 구원'),
  _BibleChapter(book: '에베소서', chapter: 6, keyVerse: '마지막으로 주 안에서와 그 힘의 능력으로 강건하여지고', keyVerseRef: '에베소서 6:10', summary: '하나님의 전신갑주'),
  _BibleChapter(book: '빌립보서', chapter: 4, keyVerse: '내게 능력 주시는 자 안에서 내가 모든 것을 할 수 있느니라', keyVerseRef: '빌립보서 4:13', summary: '능력 주시는 하나님'),
  _BibleChapter(book: '골로새서', chapter: 3, keyVerse: '위의 것을 찾으라 거기는 그리스도께서 하나님 우편에 앉아 계시느니라', keyVerseRef: '골로새서 3:1', summary: '위의 것을 구하라'),
  _BibleChapter(book: '데살로니가전서', chapter: 5, keyVerse: '항상 기뻐하라 쉬지 말고 기도하라 범사에 감사하라', keyVerseRef: '데살로니가전서 5:16-18', summary: '기쁨, 기도, 감사'),
  _BibleChapter(book: '디모데후서', chapter: 1, keyVerse: '하나님이 우리에게 주신 것은 두려워하는 마음이 아니요 능력과 사랑과 절제하는 마음이니', keyVerseRef: '디모데후서 1:7', summary: '담대함의 영'),
  _BibleChapter(book: '히브리서', chapter: 11, keyVerse: '믿음은 바라는 것들의 실상이요 보이지 않는 것들의 증거니', keyVerseRef: '히브리서 11:1', summary: '믿음의 장'),
  _BibleChapter(book: '히브리서', chapter: 12, keyVerse: '믿음의 주요 또 온전하게 하시는 이인 예수를 바라보자', keyVerseRef: '히브리서 12:2', summary: '예수를 바라보자'),
  _BibleChapter(book: '야고보서', chapter: 1, keyVerse: '너희 중에 누구든지 지혜가 부족하거든 모든 사람에게 후히 주시고 꾸짖지 아니하시는 하나님께 구하라', keyVerseRef: '야고보서 1:5', summary: '지혜를 구하라'),
  _BibleChapter(book: '베드로전서', chapter: 5, keyVerse: '너희 염려를 다 주께 맡기라 이는 그가 너희를 돌보심이라', keyVerseRef: '베드로전서 5:7', summary: '염려를 주께 맡기라'),
  _BibleChapter(book: '요한일서', chapter: 4, keyVerse: '사랑 안에 두려움이 없고 온전한 사랑이 두려움을 내쫓나니', keyVerseRef: '요한일서 4:18', summary: '온전한 사랑'),
  _BibleChapter(book: '요한계시록', chapter: 21, keyVerse: '모든 눈물을 그 눈에서 닦아 주시니 다시는 사망이 없고 애통하는 것이나 곡하는 것이나 아픈 것이 다시 있지 아니하리니', keyVerseRef: '요한계시록 21:4', summary: '새 하늘과 새 땅'),
];

/// 말씀 읽기 화면 - 오늘의 성경 본문 표시
class BibleReadingScreen extends ConsumerStatefulWidget {
  const BibleReadingScreen({super.key});

  @override
  ConsumerState<BibleReadingScreen> createState() => _BibleReadingScreenState();
}

class _BibleReadingScreenState extends ConsumerState<BibleReadingScreen> {
  bool _hasRead = false;
  late final _BibleChapter _today;

  @override
  void initState() {
    super.initState();
    // 날짜 기반으로 오늘의 본문 결정
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    _today = _chapters[dayOfYear % _chapters.length];
  }

  void _completeReading() {
    final reward = ref
        .read(dailyTasksProvider.notifier)
        .completeTask(DailyTaskType.bibleReading);

    setState(() => _hasRead = true);

    if (reward > 0) {
      final size = MediaQuery.of(context).size;
      PointToast.show(
        context,
        points: reward,
        sourceOffset: Offset(size.width / 2, size.height * 0.4),
      );
    }

    Future.delayed(const Duration(milliseconds: 1200), () {
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
        title: Text('말씀 읽기', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _hasRead
            ? _buildCompleted(textColor)
            : _buildContent(textColor, subTextColor),
      ),
    );
  }

  Widget _buildContent(Color textColor, Color subTextColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 오늘의 본문 헤더
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            decoration: BoxDecoration(
              color: const Color(0xFF7BA884).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border.all(
                color: const Color(0xFF7BA884).withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.menu_book, color: Color(0xFF7BA884), size: 36),
                const SizedBox(height: AppTheme.spacingSM),
                Text(
                  '오늘의 말씀',
                  style: AppTypography.label(subTextColor),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_today.book} ${_today.chapter}장',
                  style: AppTypography.headlineLarge(textColor),
                ),
                const SizedBox(height: 4),
                Text(
                  _today.summary,
                  style: AppTypography.bodyMedium(subTextColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing3XL),

          // 핵심 말씀
          Text(
            '핵심 말씀',
            style: AppTypography.titleLarge(textColor),
          ),
          const SizedBox(height: AppTheme.spacingMD),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Text(
                  _today.keyVerse,
                  style: AppTypography.scripture(textColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingMD),
                Text(
                  '- ${_today.keyVerseRef} -',
                  style: AppTypography.scriptureReference(
                    subTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing3XL),

          // 읽기 완료 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _completeReading,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF7BA884),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('읽기 완료',
                      style: AppTypography.button(Colors.white)),
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
                      '+5 FP',
                      style: AppTypography.label(Colors.white)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),
        ],
      ),
    );
  }

  Widget _buildCompleted(Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFF7BA884),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 50),
          ),
          const SizedBox(height: AppTheme.spacingXL),
          Text('말씀 읽기 완료!', style: AppTypography.headlineLarge(textColor)),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            _today.keyVerseRef,
            style: AppTypography.bodyMedium(
                textColor.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}
