import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../auth/providers/auth_provider.dart';

/// 상점 아이템 모델
class StoreItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final IconData icon;
  final Color color;
  final String category; // 'profile' or 'garden'
  final String rarity; // 'common', 'rare', 'epic', 'legendary'
  final bool isPurchased;

  const StoreItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
    required this.category,
    this.rarity = 'common',
    this.isPurchased = false,
  });

  Color get rarityColor {
    switch (rarity) {
      case 'rare':
        return Colors.blue;
      case 'epic':
        return Colors.purple;
      case 'legendary':
        return AppColors.gold;
      default:
        return Colors.grey;
    }
  }

  String get rarityLabel {
    switch (rarity) {
      case 'rare':
        return '희귀';
      case 'epic':
        return '에픽';
      case 'legendary':
        return '전설';
      default:
        return '일반';
    }
  }
}

// 상점 아이템 목록
const _profileItems = [
  StoreItem(
    id: 'frame_gold', name: '금빛 프레임', description: '프로필에 금색 테두리',
    price: 200, icon: Icons.filter_frames, color: AppColors.gold,
    category: 'profile', rarity: 'rare',
  ),
  StoreItem(
    id: 'frame_rainbow', name: '무지개 프레임', description: '알록달록 무지개 테두리',
    price: 500, icon: Icons.filter_frames, color: Colors.purple,
    category: 'profile', rarity: 'epic',
  ),
  StoreItem(
    id: 'title_prayer', name: '칭호: 기도의 용사', description: '프로필에 칭호 표시',
    price: 150, icon: Icons.military_tech, color: Colors.orange,
    category: 'profile',
  ),
  StoreItem(
    id: 'title_faithful', name: '칭호: 충성된 종', description: '프로필에 칭호 표시',
    price: 300, icon: Icons.military_tech, color: Colors.teal,
    category: 'profile', rarity: 'rare',
  ),
  StoreItem(
    id: 'title_eden', name: '칭호: 에덴의 수호자', description: '전설급 칭호',
    price: 2000, icon: Icons.military_tech, color: AppColors.gold,
    category: 'profile', rarity: 'legendary',
  ),
  StoreItem(
    id: 'bg_sunset', name: '석양 배경', description: '프로필 카드 배경 변경',
    price: 250, icon: Icons.wallpaper, color: Colors.deepOrange,
    category: 'profile', rarity: 'rare',
  ),
];

const _gardenItems = [
  StoreItem(
    id: 'tree_olive', name: '올리브 나무', description: '평화의 상징',
    price: 100, icon: Icons.park, color: Colors.green,
    category: 'garden',
  ),
  StoreItem(
    id: 'flower_lily', name: '백합꽃', description: '들의 백합화를 생각하라',
    price: 80, icon: Icons.local_florist, color: Colors.white,
    category: 'garden',
  ),
  StoreItem(
    id: 'flower_rose', name: '샤론의 장미', description: '아름다운 장미 한 송이',
    price: 120, icon: Icons.local_florist, color: Colors.pink,
    category: 'garden', rarity: 'rare',
  ),
  StoreItem(
    id: 'animal_dove', name: '비둘기', description: '평화의 비둘기',
    price: 300, icon: Icons.flutter_dash, color: Colors.white,
    category: 'garden', rarity: 'rare',
  ),
  StoreItem(
    id: 'animal_lamb', name: '어린 양', description: '순한 어린 양',
    price: 200, icon: Icons.pets, color: Colors.brown,
    category: 'garden',
  ),
  StoreItem(
    id: 'tree_fig', name: '무화과나무', description: '열매가 풍성한 나무',
    price: 150, icon: Icons.nature, color: Colors.green,
    category: 'garden',
  ),
  StoreItem(
    id: 'fountain', name: '생명수 샘', description: '정원 중앙의 샘물',
    price: 500, icon: Icons.water_drop, color: Colors.lightBlue,
    category: 'garden', rarity: 'epic',
  ),
  StoreItem(
    id: 'tree_life', name: '생명나무', description: '에덴동산의 생명나무',
    price: 3000, icon: Icons.eco, color: AppColors.gardenParadise,
    category: 'garden', rarity: 'legendary',
  ),
];

/// 상점 화면
class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen>
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

  /// 구매 실행 — FP 차감 + 서버 저장
  Future<void> _executePurchase(StoreItem item) async {
    final profile = ref.read(authProvider).profile;
    if (profile == null) return;

    final newFp = profile.faithPoints - item.price;
    if (newFp < 0) return;

    // 프로필 FP 차감 (로컬 즉시)
    final updated = profile.copyWith(faithPoints: newFp);
    await ref.read(authProvider.notifier).updateProfile(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name}을(를) 구매했어요! (-${item.price} FP)'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _purchaseItem(StoreItem item) {
    final profile = ref.read(authProvider).profile;
    final currentFp = profile?.faithPoints ?? 0;

    if (currentFp < item.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('FP가 부족해요! (보유: $currentFp / 필요: ${item.price})'),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${item.name} 구매'),
        content: Text(
            '${item.price} FP를 사용하여\n${item.name}을(를) 구매할까요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // FP 차감
              _executePurchase(item);
            },
            child: const Text('구매'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    final profile = ref.watch(authProvider).profile;
    final faithPoints = profile?.faithPoints ?? 0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('상점', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
        actions: [
          // FP 잔액 표시
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.gold, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$faithPoints FP',
                      style: AppTypography.label(AppColors.goldDark)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryDark,
          labelColor: AppColors.primaryDark,
          unselectedLabelColor:
              isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          tabs: const [
            Tab(text: '프로필 꾸미기', icon: Icon(Icons.person, size: 18)),
            Tab(text: '정원 아이템', icon: Icon(Icons.eco, size: 18)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildItemGrid(_profileItems, textColor),
          _buildItemGrid(_gardenItems, textColor),
        ],
      ),
    );
  }

  Widget _buildItemGrid(List<StoreItem> items, Color textColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GridView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => _purchaseItem(item),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border.all(
                color: item.rarity != 'common'
                    ? item.rarityColor.withValues(alpha: 0.3)
                    : (isDark ? Colors.white12 : Colors.grey.shade200),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 레어도 뱃지
                if (item.rarity != 'common')
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: item.rarityColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.rarityLabel,
                        style: TextStyle(
                          color: item.rarityColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                const Spacer(),

                // 아이콘
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.color, size: 28),
                ),
                const SizedBox(height: 10),

                // 이름
                Text(
                  item.name,
                  style: AppTypography.titleMedium(textColor),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // 설명
                Text(
                  item.description,
                  style: AppTypography.bodySmall(subTextColor),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer(),

                // 가격
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.gold, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${item.price}',
                        style: AppTypography.label(AppColors.goldDark)
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
