import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/auth_provider.dart';

/// 로그인 화면
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    final authState = ref.read(authProvider);
    if (authState.status == AuthStatus.authenticated) {
      context.go('/home');
    }
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

    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppTheme.spacingXXL),

                // 타이틀
                Text(
                  '다시 만나서 반가워요!',
                  style: AppTypography.headlineLarge(textColor),
                ),
                const SizedBox(height: AppTheme.spacingSM),
                Text(
                  '에덴에 로그인하세요',
                  style: AppTypography.bodyMedium(subTextColor),
                ),
                const SizedBox(height: AppTheme.spacing3XL),

                // 이메일 입력
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: '이메일',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '이메일을 입력해주세요';
                    }
                    if (!value.contains('@')) {
                      return '올바른 이메일 형식을 입력해주세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.spacingLG),

                // 비밀번호 입력
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.spacingLG),

                // 에러 메시지
                if (authState.error != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppTheme.spacingLG,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppTheme.spacingMD),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                      child: Text(
                        authState.error!,
                        style: AppTypography.bodySmall(AppColors.error),
                      ),
                    ),
                  ),

                // 로그인 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleSignIn,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.lightTextPrimary,
                            ),
                          )
                        : Text(
                            '로그인',
                            style: AppTypography.button(
                              AppColors.lightTextPrimary,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // 회원가입 링크
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/auth/signup'),
                    child: Text(
                      '계정이 없으신가요? 회원가입',
                      style: AppTypography.bodyMedium(subTextColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
