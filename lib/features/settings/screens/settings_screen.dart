import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/providers/auth_provider.dart';
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
            child: const Text(
              '로그아웃',
              style: TextStyle(color: AppColors.error),
            ),
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

  /// 이름 변경 다이얼로그
  Future<void> _showNameChangeDialog() async {
    final authState = ref.read(authProvider);
    final currentName = authState.profile?.displayName ?? '';
    final controller = TextEditingController(text: currentName);

    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        String? errorText;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('이름 변경'),
              content: TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '새 이름을 입력하세요',
                  errorText: errorText,
                ),
                onSubmitted: (value) {
                  final name = value.trim();
                  if (name.isEmpty) {
                    setDialogState(() => errorText = '이름을 입력해주세요');
                    return;
                  }
                  Navigator.of(context).pop(name);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    final name = controller.text.trim();
                    if (name.isEmpty) {
                      setDialogState(() => errorText = '이름을 입력해주세요');
                      return;
                    }
                    Navigator.of(context).pop(name);
                  },
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이름 변경에 실패했어요: $e')),
          );
        }
      }
    }
  }

  /// 교회 변경 다이얼로그
  Future<void> _showChurchChangeDialog() async {
    String? currentChurch;
    try {
      final prefs = await SharedPreferences.getInstance();
      currentChurch = prefs.getString('church_name');
    } catch (e) {
      debugPrint('교회 정보 로드 실패: $e');
    }

    if (!mounted) return;

    const churches = [
      '사랑의교회',
      '온누리교회',
      '여의도순복음교회',
      '소망교회',
      '분당우리교회',
      '새문안교회',
      '영락교회',
      '광림교회',
    ];

    String? selected = currentChurch;

    final result = await showDialog<String?>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('교회 변경'),
              content: SizedBox(
                width: double.maxFinite,
                height: 340,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: churches.length,
                        itemBuilder: (context, index) {
                          final church = churches[index];
                          final isSelected = selected == church;
                          return ListTile(
                            leading: Icon(
                              Icons.church_outlined,
                              color: isSelected
                                  ? AppColors.primaryDark
                                  : Colors.grey,
                              size: 20,
                            ),
                            title: Text(church),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primaryDark,
                                    size: 20,
                                  )
                                : null,
                            onTap: () {
                              setDialogState(() => selected = church);
                            },
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setDialogState(() => selected = null);
                      },
                      child: Text(
                        '교회를 다니고 있지 않아요',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(currentChurch),
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(selected),
                  child: const Text('저장'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != currentChurch && mounted) {
      try {
        final prefs = await SharedPreferences.getInstance();
        if (result != null) {
          await prefs.setString('church_name', result);
        } else {
          await prefs.remove('church_name');
        }

        // Auth 프로필 업데이트
        final profile = ref.read(authProvider).profile;
        if (profile != null) {
          await ref
              .read(authProvider.notifier)
              .updateProfile(profile.copyWith(churchName: result));
        }

        ref.invalidate(localChurchNameProvider);
        setState(() {});
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('교회 변경에 실패했어요: $e')),
          );
        }
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('알림 시간 변경에 실패했어요: $e')),
          );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('설정 변경에 실패했어요: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
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
        title: Text(
          '설정',
          style: AppTypography.titleLarge(textColor),
        ),
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
            trailing: Text(
              '읽기 전용',
              style: AppTypography.label(subTextColor),
            ),
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
            title: '스트릭 알림',
            subtitle: '스트릭이 끊기기 전에 알려줘요',
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingXL,
            ),
            child: TextButton(
              onPressed: _handleSignOut,
              child: Text(
                '로그아웃',
                style: AppTypography.button(AppColors.error),
              ),
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
      child: Text(
        title,
        style: AppTypography.label(AppColors.primaryDark),
      ),
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
      title: Text(
        title,
        style: AppTypography.bodyLarge(textColor),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.bodySmall(subTextColor),
            )
          : null,
      trailing: trailing ??
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
      title: Text(
        title,
        style: AppTypography.bodyLarge(textColor),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall(subTextColor),
      ),
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
