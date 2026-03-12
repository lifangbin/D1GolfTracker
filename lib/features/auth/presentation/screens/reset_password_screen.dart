import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app/router.dart';
import '../../../../app/theme.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';

/// Reset password screen with OTP verification
class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String? email;

  const ResetPasswordScreen({super.key, this.email});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Steps: 0 = enter email, 1 = enter OTP, 2 = enter new password
  // Now using provider to persist across widget rebuilds
  int get _currentStep => ref.watch(resetPasswordStepProvider);
  set _currentStep(int value) =>
      ref.read(resetPasswordStepProvider.notifier).state = value;

  @override
  void initState() {
    super.initState();
    // Restore email from provider if available, or use widget.email
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedEmail = ref.read(resetPasswordEmailProvider);
      if (savedEmail.isNotEmpty) {
        _emailController.text = savedEmail;
      } else if (widget.email != null) {
        _emailController.text = widget.email!;
        ref.read(resetPasswordEmailProvider.notifier).state = widget.email!;
      }
      // Mark that we're in password reset flow
      ref.read(isInPasswordResetFlowProvider.notifier).state = true;
    });
  }

  @override
  void dispose() {
    // Note: We don't clear the password reset flow flag here because
    // we can't use ref after dispose. The flag is cleared in _showSuccessDialog
    // when the password is successfully changed.
    _emailController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 0) {
              _currentStep = _currentStep - 1;
            } else {
              // Clear all flow state before navigating away
              ref.read(isInPasswordResetFlowProvider.notifier).state = false;
              ref.read(resetPasswordStepProvider.notifier).state = 0;
              ref.read(resetPasswordEmailProvider.notifier).state = '';
              // Use go instead of pop because we may have been redirected here
              context.go('/login');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 32),
                _buildStepIndicator(),
                const SizedBox(height: 32),
                _buildCurrentStepContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String title;
    String subtitle;

    switch (_currentStep) {
      case 0:
        title = 'Enter Your Email';
        subtitle = 'We\'ll send you a verification code to reset your password';
        break;
      case 1:
        title = 'Enter Verification Code';
        subtitle = 'Check your email for the verification code';
        break;
      case 2:
        title = 'Create New Password';
        subtitle = 'Enter your new password below';
        break;
      default:
        title = 'Reset Password';
        subtitle = '';
    }

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            _currentStep == 2 ? Icons.lock_reset : Icons.email_outlined,
            size: 48,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: AppTextStyles.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepDot(0),
        _buildStepLine(0),
        _buildStepDot(1),
        _buildStepLine(1),
        _buildStepDot(2),
      ],
    );
  }

  Widget _buildStepDot(int step) {
    final isActive = _currentStep >= step;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : AppColors.surfaceVariant,
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.textHint,
          width: 2,
        ),
      ),
      child: isActive && _currentStep > step
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : Center(
              child: Text(
                '${step + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : AppColors.textHint,
                ),
              ),
            ),
    );
  }

  Widget _buildStepLine(int step) {
    final isActive = _currentStep > step;
    return Container(
      width: 40,
      height: 2,
      color: isActive ? AppColors.primary : AppColors.surfaceVariant,
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildEmailStep();
      case 1:
        return _buildOtpStep();
      case 2:
        return _buildPasswordStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
          enabled: !_isLoading,
          validator: _validateEmail,
        ),
        const SizedBox(height: 24),
        AppButton(
          onPressed: _isLoading ? null : _handleSendOtp,
          isLoading: _isLoading,
          child: const Text('Send Verification Code'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _isLoading
              ? null
              : () {
                  // Clear all flow state before navigating away
                  ref.read(isInPasswordResetFlowProvider.notifier).state =
                      false;
                  ref.read(resetPasswordStepProvider.notifier).state = 0;
                  ref.read(resetPasswordEmailProvider.notifier).state = '';
                  context.go('/login');
                },
          child: const Text('Back to Login'),
        ),
      ],
    );
  }

  Widget _buildOtpStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Code sent to: ${_emailController.text}',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _otpController,
          label: 'Verification Code',
          hint: 'Enter verification code',
          keyboardType: TextInputType.number,
          prefixIcon: Icons.pin_outlined,
          enabled: !_isLoading,
          validator: _validateOtp,
        ),
        const SizedBox(height: 24),
        AppButton(
          onPressed: _isLoading ? null : _handleVerifyOtp,
          isLoading: _isLoading,
          child: const Text('Verify Code'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _isLoading ? null : _handleResendOtp,
          child: const Text('Resend Code'),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: _passwordController,
          label: 'New Password',
          hint: 'Enter new password',
          obscureText: _obscurePassword,
          prefixIcon: Icons.lock_outlined,
          enabled: !_isLoading,
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
        AppTextField(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
          hint: 'Confirm new password',
          obscureText: _obscureConfirmPassword,
          prefixIcon: Icons.lock_outlined,
          enabled: !_isLoading,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword);
            },
          ),
          validator: _validateConfirmPassword,
        ),
        const SizedBox(height: 8),
        Text(
          'Password must be at least 8 characters',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        AppButton(
          onPressed: _isLoading ? null : _handleUpdatePassword,
          isLoading: _isLoading,
          child: const Text('Update Password'),
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

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the verification code';
    }
    if (value.length < 6) {
      return 'Code must be at least 6 digits';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
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

  Future<void> _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final supabase = SupabaseService.instance;
      await supabase.client.auth.resetPasswordForEmail(
        _emailController.text.trim(),
      );

      if (mounted) {
        // Save email to provider for persistence across rebuilds
        ref.read(resetPasswordEmailProvider.notifier).state =
            _emailController.text.trim();
        setState(() => _isLoading = false);
        _currentStep = 1;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification code sent! Check your email.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleResendOtp() async {
    setState(() => _isLoading = true);

    try {
      final supabase = SupabaseService.instance;
      await supabase.client.auth.resetPasswordForEmail(
        _emailController.text.trim(),
      );

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New code sent! Check your email.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleVerifyOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final supabase = SupabaseService.instance;
      await supabase.client.auth.verifyOTP(
        email: _emailController.text.trim(),
        token: _otpController.text.trim(),
        type: OtpType.recovery,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        // Set step to 2 (enter new password) - this persists via provider
        _currentStep = 2;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code verified! Enter your new password.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid code. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final supabase = SupabaseService.instance;
      await supabase.updatePassword(_passwordController.text);

      // Clear all password reset flow state BEFORE signing out
      // This ensures the state is cleared before router rebuilds
      ref.read(isInPasswordResetFlowProvider.notifier).state = false;
      ref.read(resetPasswordStepProvider.notifier).state = 0;
      ref.read(resetPasswordEmailProvider.notifier).state = '';

      // Sign out after password change
      await supabase.signOut();

      if (mounted) {
        setState(() => _isLoading = false);
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    // Flow state already cleared in _handleUpdatePassword before signOut
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success),
            SizedBox(width: 8),
            Text('Success'),
          ],
        ),
        content: const Text(
          'Your password has been reset successfully. Please sign in with your new password.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.go('/login');
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
