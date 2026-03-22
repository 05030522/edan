import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/onboarding_provider.dart';

/// 온보딩 - 프로필 사진 설정 화면
class OnboardingPhotoScreen extends ConsumerStatefulWidget {
  const OnboardingPhotoScreen({super.key});

  @override
  ConsumerState<OnboardingPhotoScreen> createState() =>
      _OnboardingPhotoScreenState();
}

class _OnboardingPhotoScreenState
    extends ConsumerState<OnboardingPhotoScreen> {
  Uint8List? _imageBytes;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    setState(() => _isLoading = true);
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() => _imageBytes = bytes);
        ref.read(onboardingProvider.notifier).setAvatarBytes(bytes);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('사진을 불러올 수 없어요: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleNext() {
    context.go('/onboarding/church');
  }

  void _handleSkip() {
    context.go('/onboarding/church');
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.spacing3XL),

              // 진행 표시 (2/5)
              _buildProgressIndicator(2, 5),
              const SizedBox(height: AppTheme.spacingMD),

              // 건너뛰기 버튼
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _handleSkip,
                  child: Text(
                    '건너뛰기',
                    style: AppTypography.bodyMedium(subTextColor),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // 타이틀
              Text(
                '프로필 사진을\n설정해주세요',
                style: AppTypography.headlineLarge(textColor),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                '언제든지 변경할 수 있어요',
                style: AppTypography.bodyMedium(subTextColor),
              ),

              const Spacer(),

              // 사진 선택 영역
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _isLoading ? null : _pickImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.1),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary),
                                  )
                                : _imageBytes != null
                                    ? ClipOval(
                                        child: Image.memory(
                                          _imageBytes!,
                                          fit: BoxFit.cover,
                                          width: 130,
                                          height: 130,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 64,
                                        color: AppColors.primary,
                                      ),
                          ),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    Text(
                      '탭하여 사진 선택',
                      style: AppTypography.bodyMedium(subTextColor),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // 다음 버튼 (사진 선택 시 활성화)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _imageBytes != null ? _handleNext : null,
                  child: Text(
                    '다음',
                    style: AppTypography.button(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int current, int total) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index < current;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index < total - 1 ? 4 : 0),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
