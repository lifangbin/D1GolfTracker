import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/player_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gaNumberController = TextEditingController();
  final _homeCourseController = TextEditingController();

  DateTime? _dateOfBirth;
  String? _selectedGender;
  bool _isLoading = false;

  final List<String> _genders = ['male', 'female', 'other'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gaNumberController.dispose();
    _homeCourseController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();
    final initialDate = _dateOfBirth ?? DateTime(now.year - 12, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 25),
      lastDate: DateTime(now.year - 5),
      helpText: 'Select Player\'s Date of Birth',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  String _getPhaseForAge(int age) {
    if (age <= 10) return 'Phase 1: Foundation (Ages 8-10)';
    if (age <= 13) return 'Phase 2: Development (Ages 11-13)';
    if (age <= 15) return 'Phase 3: Competition (Ages 14-15)';
    return 'Phase 4: Elite (Ages 16-18)';
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date of birth')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(playerNotifierProvider.notifier).createPlayer(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            dateOfBirth: _dateOfBirth!,
            gender: _selectedGender,
            gaNumber: _gaNumberController.text.trim().isEmpty
                ? null
                : _gaNumberController.text.trim(),
            homeCourse: _homeCourseController.text.trim().isEmpty
                ? null
                : _homeCourseController.text.trim(),
          );

      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create profile: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerAsync = ref.watch(playerNotifierProvider);

    // If player already exists, show different UI
    if (playerAsync.valueOrNull != null) {
      // Profile already exists, redirect to dashboard
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/dashboard');
        }
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Player Profile'),
        automaticallyImplyLeading: false,
        actions: [
          // Skip button for edge cases
          TextButton(
            onPressed: () {
              // Force reload player and go to dashboard
              ref.read(playerNotifierProvider.notifier).loadPlayer();
              context.go('/dashboard');
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome message
                Text(
                  'Welcome to HappyGolf!',
                  style: AppTextStyles.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Let\'s set up the junior golfer\'s profile',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Name fields
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                        hint: 'John',
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        hint: 'Smith',
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Date of Birth
                GestureDetector(
                  onTap: _selectDateOfBirth,
                  child: AbsorbPointer(
                    child: AppTextField(
                      controller: TextEditingController(
                        text: _dateOfBirth != null
                            ? DateFormat('dd MMM yyyy').format(_dateOfBirth!)
                            : '',
                      ),
                      label: 'Date of Birth',
                      hint: 'Select date',
                      suffixIcon: const Icon(Icons.calendar_today),
                      validator: (value) {
                        if (_dateOfBirth == null) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                // Show phase based on age
                if (_dateOfBirth != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            _getPhaseForAge(_calculateAge(_dateOfBirth!)),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.md),

                // Gender
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    filled: true,
                    fillColor: AppColors.surface,
                  ),
                  items: _genders.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(
                        gender[0].toUpperCase() + gender.substring(1),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                // Divider
                const Divider(height: AppSpacing.xl),
                Text(
                  'Golf Details (Optional)',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // GA Number
                AppTextField(
                  controller: _gaNumberController,
                  label: 'Golf Australia Number',
                  hint: 'e.g., 1234567',
                  helperText: 'Used for handicap sync with GA CONNECT',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.md),

                // Home Course
                AppTextField(
                  controller: _homeCourseController,
                  label: 'Home Course',
                  hint: 'e.g., Royal Melbourne',
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Submit Button
                AppButton(
                  onPressed: _isLoading ? null : _submitForm,
                  isLoading: _isLoading,
                  child: const Text('Create Profile'),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
