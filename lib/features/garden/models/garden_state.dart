/// 정원 상태 모델
class GardenState {
  final String userId;
  final int gardenLevel;
  final String theme;
  final List<PlacedItem> items;

  const GardenState({
    required this.userId,
    this.gardenLevel = 1,
    this.theme = 'default',
    this.items = const [],
  });

  factory GardenState.fromJson(Map<String, dynamic> json) {
    return GardenState(
      userId: json['user_id'] as String,
      gardenLevel: json['garden_level'] as int? ?? 1,
      theme: json['theme'] as String? ?? 'default',
      items: json['items'] != null
          ? (json['items'] as List)
                .map((e) => PlacedItem.fromJson(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'garden_level': gardenLevel,
    'theme': theme,
    'items': items.map((e) => e.toJson()).toList(),
  };

  /// 정원 레벨 이름
  String get levelName {
    const names = [
      '갈아엎은 땅',
      '씨앗을 품은 땅',
      '새싹이 돋는 땅',
      '자라나는 밭',
      '꽃피는 정원',
      '열매 맺는 동산',
      '좋은 땅',
      '풍성한 밭',
      '복된 동산',
      '에덴 동산',
    ];
    final index = (gardenLevel - 1).clamp(0, names.length - 1);
    return names[index];
  }

  GardenState copyWith({
    int? gardenLevel,
    String? theme,
    List<PlacedItem>? items,
  }) {
    return GardenState(
      userId: userId,
      gardenLevel: gardenLevel ?? this.gardenLevel,
      theme: theme ?? this.theme,
      items: items ?? this.items,
    );
  }
}

/// 배치된 정원 아이템
class PlacedItem {
  final String itemId;
  final String name;
  final double x;
  final double y;
  final DateTime placedAt;

  const PlacedItem({
    required this.itemId,
    required this.name,
    required this.x,
    required this.y,
    required this.placedAt,
  });

  factory PlacedItem.fromJson(Map<String, dynamic> json) {
    return PlacedItem(
      itemId: json['item_id'] as String,
      name: json['name'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      placedAt: DateTime.parse(json['placed_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'name': name,
    'x': x,
    'y': y,
    'placed_at': placedAt.toIso8601String(),
  };
}

/// 정원 아이템 카탈로그
class GardenItem {
  final String id;
  final String name;
  final String? description;
  final String? bibleReference;
  final String? bibleVerse;
  final String category;
  final String rarity;
  final String? unlockCondition;

  const GardenItem({
    required this.id,
    required this.name,
    this.description,
    this.bibleReference,
    this.bibleVerse,
    required this.category,
    this.rarity = 'common',
    this.unlockCondition,
  });

  factory GardenItem.fromJson(Map<String, dynamic> json) {
    return GardenItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      bibleReference: json['bible_reference'] as String?,
      bibleVerse: json['bible_verse'] as String?,
      category: json['category'] as String,
      rarity: json['rarity'] as String? ?? 'common',
      unlockCondition: json['unlock_condition'] as String?,
    );
  }

  String get rarityLabel {
    switch (rarity) {
      case 'common':
        return '일반';
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
