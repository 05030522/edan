import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../models/app_error.dart';

/// AppError를 일관된 디자인의 SnackBar로 표시하는 헬퍼.
///
/// 에러 종류별로 아이콘과 색상을 구분해 사용자에게 직관적인 피드백.
///
/// 사용 예:
/// ```dart
/// ErrorSnackbar.show(context, AppError.from(e));
/// ```
class ErrorSnackbar {
  ErrorSnackbar._();

  static void show(
    BuildContext context,
    AppError error, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    if (!context.mounted) return;

    final (icon, bgColor) = switch (error) {
      NetworkError() => (Icons.wifi_off, AppColors.warning),
      AuthError() => (Icons.lock_outline, AppColors.error),
      ValidationError() => (Icons.info_outline, AppColors.warning),
      ServerError() => (Icons.cloud_off, AppColors.error),
      UnknownError() => (Icons.error_outline, AppColors.error),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                error.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: action,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
