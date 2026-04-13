import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/kakao_place_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/providers/auth_provider.dart';
import '../../community/providers/community_provider.dart';
import '../../onboarding/providers/onboarding_provider.dart';

/// 설정 화면
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Future<void> _handleSignOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('로그아웃', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(authProvider.notifier).signOut();
      if (mounted) {
        context.go('/welcome');
      }
    }
  }

  /// 닉네임 유효성 검사 (한글, 영어, 숫자만 허용)
  static final _validNameRegex = RegExp(r'^[가-힣a-zA-Z0-9]+$');
  static const int _minNameLength = 2;
  static const int _maxNameLength = 12;

  /// Supabase에서 닉네임 중복 검사 (대소문자 무시, 본인 제외)
  Future<bool> _isNameTaken(String name, String currentUserId) async {
    try {
      final result = await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .select('id')
          .ilike('display_name', name)
          .neq('id', currentUserId)
          .limit(1);
      return (result as List).isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 이름 변경 다이얼로그
  Future<void> _showNameChangeDialog() async {
    final authState = ref.read(authProvider);
    final currentName = authState.profile?.displayName ?? '';
    final currentUserId = authState.profile?.id ?? '';
    final controller = TextEditingController(text: currentName);

    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        String? errorText;
        bool isChecking = false;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> handleSave() async {
              final name = controller.text.trim();
              if (name.isEmpty || name.length < _minNameLength) {
                setDialogState(
                  () => errorText = '이름은 $_minNameLength자 이상이어야 해요',
                );
                return;
              }
              if (!_validNameRegex.hasMatch(name)) {
                setDialogState(() => errorText = '한글, 영어, 숫자만 사용할 수 있어요');
                return;
              }

              setDialogState(() {
                isChecking = true;
                errorText = null;
              });

              final taken = await _isNameTaken(name, currentUserId);

              if (taken) {
                setDialogState(() {
                  isChecking = false;
                  errorText = '이미 사용 중인 이름이에요';
                });
                return;
              }

              setDialogState(() => isChecking = false);
              if (context.mounted) Navigator.of(context).pop(name);
            }

            return AlertDialog(
              title: const Text('이름 변경'),
              content: TextField(
                controller: controller,
                autofocus: true,
                maxLength: _maxNameLength,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[가-힣a-zA-Z0-9]')),
                ],
                decoration: InputDecoration(
                  hintText: '새 이름을 입력하세요',
                  errorText: errorText,
                  suffixIcon: isChecking
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                onSubmitted: (_) => handleSave(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: isChecking ? null : handleSave,
                  child: const Text('저장'),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();

    if (newName != null && newName.isNotEmpty && mounted) {
      try {
        // SharedPreferences 업데이트
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', newName);

        // Auth 프로필 업데이트
        final profile = ref.read(authProvider).profile;
        if (profile != null) {
          await ref
              .read(authProvider.notifier)
              .updateProfile(profile.copyWith(displayName: newName));
        }

        // 로컬 이름 프로바이더 갱신
        ref.invalidate(localUserNameProvider);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('이름 변경에 실패했어요: $e')));
        }
      }
    }
  }

  /// 교회 변경 다이얼로그 (카카오 지도 검색)
  Future<void> _showChurchChangeDialog() async {
    String? currentChurch;
    try {
      final prefs = await SharedPreferences.getInstance();
      currentChurch = prefs.getString('church_name');
    } catch (e) {
      debugPrint('교회 정보 로드 실패: $e');
    }

    if (!mounted) return;

    final result = await showDialog<String?>(
      context: context,
      builder: (context) {
        return _ChurchSearchDialog(currentChurch: currentChurch);
      },
    );

    // null = 취소, '' = 교회 삭제 (안 다님)
    if (result == null || !mounted) return;

    final newChurch = result.isEmpty ? null : result;
    if (newChurch == currentChurch) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      if (newChurch != null) {
        await prefs.setString('church_name', newChurch);
      } else {
        await prefs.remove('church_name');
      }

      // Auth 프로필 업데이트
      final profile = ref.read(authProvider).profile;
      if (profile != null) {
        final updatedProfile = newChurch != null
            ? profile.copyWith(churchName: newChurch)
            : profile.copyWith(clearChurchName: true);
        await ref.read(authProvider.notifier).updateProfile(updatedProfile);
        debugPrint('교회 변경 완료: $newChurch');
      } else {
        debugPrint('프로필이 null - DB 저장 건너뜀');
      }

      ref.invalidate(localChurchNameProvider);
      // 커뮤니티 프로바이더 즉시 새로고침
      ref.read(communityProvider.notifier).refresh();
      // 설정 화면 닫고 커뮤니티 탭으로 이동
      if (mounted) {
        context.go('/community');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('교회 변경에 실패했어요: $e')));
      }
    }
  }

  /// 알림 시간 변경
  Future<void> _showNotificationTimePicker() async {
    int currentHour = 8;
    int currentMinute = 0;
    try {
      final prefs = await SharedPreferences.getInstance();
      currentHour = prefs.getInt('notification_hour') ?? 8;
      currentMinute = prefs.getInt('notification_minute') ?? 0;
    } catch (e) {
      debugPrint('알림 시간 로드 실패: $e');
    }

    if (!mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: currentHour, minute: currentMinute),
    );

    if (time != null && mounted) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('notification_hour', time.hour);
        await prefs.setInt('notification_minute', time.minute);
        final timeStr =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        await prefs.setString('notification_time', timeStr);

        final profile = ref.read(authProvider).profile;
        if (profile != null) {
          await ref
              .read(authProvider.notifier)
              .updateProfile(profile.copyWith(notificationTime: timeStr));
        }

        setState(() {});
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('알림 시간 변경에 실패했어요: $e')));
        }
      }
    }
  }

  /// 다크 모드 토글
  Future<void> _toggleDarkMode(bool value) async {
    try {
      final profile = ref.read(authProvider).profile;
      if (profile != null) {
        await ref
            .read(authProvider.notifier)
            .updateProfile(profile.copyWith(darkMode: value));
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('dark_mode', value);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('설정 변경에 실패했어요: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final dividerColor = isDark
        ? AppColors.darkBackgroundSecondary
        : AppColors.lightBackgroundSecondary;

    final authState = ref.watch(authProvider);
    final profile = authState.profile;
    final displayName = profile?.displayName ?? '에덴 사용자';
    final churchName = profile?.churchName ?? '교회를 선택하지 않았어요';
    final notificationTime = profile?.notificationTime ?? '08:00';
    final darkModeEnabled = profile?.darkMode ?? false;
    final streakNotification = profile?.notificationEnabled ?? true;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text('설정', style: AppTypography.titleLarge(textColor)),
      ),
      body: ListView(
        children: [
          // --- 계정 ---
          _buildSectionHeader('계정', textColor),
          _buildTile(
            title: '이름 변경',
            subtitle: displayName,
            icon: Icons.person_outline,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: _showNameChangeDialog,
          ),
          _buildTile(
            title: '이메일',
            subtitle: authState.user?.email ?? '로그인 정보 없음',
            icon: Icons.email_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          Divider(color: dividerColor),

          // --- 교회 ---
          _buildSectionHeader('교회', textColor),
          _buildTile(
            title: '교회 변경',
            subtitle: churchName,
            icon: Icons.church_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: _showChurchChangeDialog,
          ),
          Divider(color: dividerColor),

          // --- 알림 ---
          _buildSectionHeader('알림', textColor),
          _buildTile(
            title: '알림 시간',
            subtitle: notificationTime,
            icon: Icons.access_time,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: _showNotificationTimePicker,
          ),
          _buildSwitchTile(
            title: '연속 묵상 알림',
            subtitle: '연속 묵상이 끊기기 전에 알려줘요',
            icon: Icons.local_fire_department_outlined,
            value: streakNotification,
            textColor: textColor,
            subTextColor: subTextColor,
            onChanged: (value) async {
              final p = ref.read(authProvider).profile;
              if (p != null) {
                await ref
                    .read(authProvider.notifier)
                    .updateProfile(p.copyWith(notificationEnabled: value));
              }
            },
          ),
          Divider(color: dividerColor),

          // --- 화면 ---
          _buildSectionHeader('화면', textColor),
          _buildSwitchTile(
            title: '다크 모드',
            subtitle: '어두운 테마로 전환합니다',
            icon: Icons.dark_mode_outlined,
            value: darkModeEnabled,
            textColor: textColor,
            subTextColor: subTextColor,
            onChanged: _toggleDarkMode,
          ),
          Divider(color: dividerColor),

          // --- 정보 ---
          _buildSectionHeader('정보', textColor),
          _buildTile(
            title: '앱 버전',
            subtitle: AppConstants.appVersion,
            icon: Icons.info_outline,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          _buildTile(
            title: '개인정보 처리방침',
            icon: Icons.privacy_tip_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: () => context.push('/profile/settings/privacy'),
          ),
          _buildTile(
            title: '이용약관',
            icon: Icons.description_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: () => context.push('/profile/settings/terms'),
          ),
          Divider(color: dividerColor),

          // --- 로그아웃 ---
          const SizedBox(height: AppTheme.spacingSM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXL),
            child: TextButton(
              onPressed: _handleSignOut,
              child: Text('로그아웃', style: AppTypography.button(AppColors.error)),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXXL),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacingXL,
        AppTheme.spacingLG,
        AppTheme.spacingXL,
        AppTheme.spacingSM,
      ),
      child: Text(title, style: AppTypography.label(AppColors.primaryDark)),
    );
  }

  Widget _buildTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required Color textColor,
    required Color subTextColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: subTextColor, size: 22),
      title: Text(title, style: AppTypography.bodyLarge(textColor)),
      subtitle: subtitle != null
          ? Text(subtitle, style: AppTypography.bodySmall(subTextColor))
          : null,
      trailing:
          trailing ??
          (onTap != null
              ? Icon(Icons.chevron_right, color: subTextColor, size: 20)
              : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXL,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Color textColor,
    required Color subTextColor,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: subTextColor, size: 22),
      title: Text(title, style: AppTypography.bodyLarge(textColor)),
      subtitle: Text(subtitle, style: AppTypography.bodySmall(subTextColor)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXL,
      ),
    );
  }
}

/// 카카오 지도 교회 검색 다이얼로그
class _ChurchSearchDialog extends StatefulWidget {
  final String? currentChurch;
  const _ChurchSearchDialog({this.currentChurch});

  @override
  State<_ChurchSearchDialog> createState() => _ChurchSearchDialogState();
}

class _ChurchSearchDialogState extends State<_ChurchSearchDialog> {
  final _controller = TextEditingController();
  List<KakaoChurchResult> _results = [];
  KakaoChurchResult? _selected;
  bool _isSearching = false;
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _results = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final results = await KakaoPlaceService.searchChurch(query);
      if (mounted) {
        setState(() {
          _results = results;
          _isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('교회 변경'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            // 검색 입력
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '교회 이름 검색',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _isSearching
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 12),

            // 선택된 교회
            if (_selected != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primaryDark,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${_selected!.name} (${_selected!.shortAddress})',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 검색 결과
            Expanded(
              child: _results.isEmpty
                  ? Center(
                      child: Text(
                        _controller.text.isEmpty
                            ? '교회 이름을 입력하세요'
                            : (_isSearching ? '검색 중...' : '결과가 없어요'),
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final church = _results[index];
                        final isSelected = _selected?.id == church.id;
                        return ListTile(
                          dense: true,
                          leading: Icon(
                            Icons.church_outlined,
                            color: isSelected
                                ? AppColors.primaryDark
                                : Colors.grey,
                            size: 18,
                          ),
                          title: Text(
                            church.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? AppColors.primaryDark : null,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            church.roadAddress ?? church.address,
                            style: const TextStyle(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColors.primaryDark,
                                  size: 18,
                                )
                              : null,
                          onTap: () {
                            setState(() => _selected = church);
                          },
                        );
                      },
                    ),
            ),

            // 교회 안 다님
            TextButton(
              onPressed: () => Navigator.of(context).pop(''),
              child: Text(
                '교회를 다니고 있지 않아요',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            if (_selected != null) {
              Navigator.of(context).pop(_selected!.name);
            } else {
              Navigator.of(context).pop(null);
            }
          },
          child: const Text('저장'),
        ),
      ],
    );
  }
}
