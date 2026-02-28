import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/providers/auth_provider.dart';

/// 설정 화면
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // 플레이스홀더 설정 값
  bool _darkMode = false;
  bool _streakNotification = true;
  String _notificationTime = '08:00';

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
          // ─── 계정 ───
          _buildSectionHeader('계정', textColor),
          _buildTile(
            title: '이름 변경',
            subtitle: '에덴 사용자',
            icon: Icons.person_outline,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: () {
              // TODO: 이름 변경 다이얼로그
            },
          ),
          _buildTile(
            title: '이메일',
            subtitle: 'user@example.com',
            icon: Icons.email_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
            trailing: Text(
              '읽기 전용',
              style: AppTypography.label(subTextColor),
            ),
          ),
          Divider(color: dividerColor),

          // ─── 교회 ───
          _buildSectionHeader('교회', textColor),
          _buildTile(
            title: '교회 변경',
            subtitle: '교회를 선택하지 않았어요',
            icon: Icons.church_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: () {
              // TODO: 교회 변경 화면
            },
          ),
          Divider(color: dividerColor),

          // ─── 알림 ───
          _buildSectionHeader('알림', textColor),
          _buildTile(
            title: '알림 시간',
            subtitle: _notificationTime,
            icon: Icons.access_time,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 8, minute: 0),
              );
              if (time != null) {
                setState(() {
                  _notificationTime =
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                });
              }
            },
          ),
          _buildSwitchTile(
            title: '스트릭 알림',
            subtitle: '스트릭이 끊기기 전에 알려줘요',
            icon: Icons.local_fire_department_outlined,
            value: _streakNotification,
            textColor: textColor,
            subTextColor: subTextColor,
            onChanged: (value) {
              setState(() {
                _streakNotification = value;
              });
            },
          ),
          Divider(color: dividerColor),

          // ─── 화면 ───
          _buildSectionHeader('화면', textColor),
          _buildSwitchTile(
            title: '다크 모드',
            subtitle: '어두운 테마로 전환합니다',
            icon: Icons.dark_mode_outlined,
            value: _darkMode,
            textColor: textColor,
            subTextColor: subTextColor,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
              // TODO: 실제 테마 변경 적용
            },
          ),
          Divider(color: dividerColor),

          // ─── 정보 ───
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
            onTap: () {
              // TODO: 개인정보 처리방침 페이지
            },
          ),
          _buildTile(
            title: '이용약관',
            icon: Icons.description_outlined,
            textColor: textColor,
            subTextColor: subTextColor,
            onTap: () {
              // TODO: 이용약관 페이지
            },
          ),
          Divider(color: dividerColor),

          // ─── 로그아웃 ───
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

  /// 섹션 헤더
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

  /// 일반 설정 타일
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

  /// 스위치 설정 타일
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
