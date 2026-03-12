import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

/// Login screen with email/password authentication
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    // Listen for errors
    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(getAuthErrorMessage(error)),
              backgroundColor: AppColors.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),

                // Logo and title
                _buildHeader(),
                const SizedBox(height: 48),

                // Email field
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  enabled: !isLoading,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),

                // Password field
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outlined,
                  enabled: !isLoading,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),

                // Confirm password field (sign up only)
                if (_isSignUp) ...[
                  AppTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    obscureText: _obscureConfirmPassword,
                    prefixIcon: Icons.lock_outlined,
                    enabled: !isLoading,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() =>
                            _obscureConfirmPassword = !_obscureConfirmPassword);
                      },
                    ),
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: 16),
                ],

                // Forgot password (sign in only)
                if (!_isSignUp)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isLoading ? null : _handleForgotPassword,
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                const SizedBox(height: 24),

                // Submit button
                AppButton(
                  onPressed: isLoading ? null : _handleSubmit,
                  isLoading: isLoading,
                  child: Text(_isSignUp ? 'Create Account' : 'Sign In'),
                ),
                const SizedBox(height: 16),

                // Toggle sign in / sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isSignUp
                          ? 'Already have an account?'
                          : "Don't have an account?",
                      style: AppTextStyles.bodyMedium,
                    ),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              setState(() {
                                _isSignUp = !_isSignUp;
                                _formKey.currentState?.reset();
                              });
                            },
                      child: Text(_isSignUp ? 'Sign In' : 'Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.golf_course,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),

        // Title
        Text(
          _isSignUp ? 'Create Account' : 'Welcome Back',
          style: AppTextStyles.displaySmall,
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          _isSignUp
              ? 'Start tracking your golf journey'
              : 'Sign in to continue your journey',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (_isSignUp && value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(authControllerProvider.notifier);

    if (_isSignUp) {
      final success = await controller.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created! Please check your email to verify.'),
            backgroundColor: AppColors.success,
          ),
        );
        setState(() => _isSignUp = false);
      }
    } else {
      await controller.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _handleForgotPassword() {
    final email = _emailController.text.trim();
    // Navigate to reset password screen, passing email if available
    context.push(AppRoutes.resetPassword, extra: email.isNotEmpty ? email : null);
  }
}
