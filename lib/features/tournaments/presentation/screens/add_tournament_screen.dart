import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../course_search/presentation/widgets/course_search_field.dart';
import '../providers/tournament_provider.dart';

class AddTournamentScreen extends ConsumerStatefulWidget {
  const AddTournamentScreen({super.key});

  @override
  ConsumerState<AddTournamentScreen> createState() => _AddTournamentScreenState();
}

class _AddTournamentScreenState extends ConsumerState<AddTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _courseNameController = TextEditingController();
  final _courseCityController = TextEditingController();
  final _courseStateController = TextEditingController();
  final _courseParController = TextEditingController();
  final _totalScoreController = TextEditingController();
  final _positionController = TextEditingController();
  final _fieldSizeController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _startDate = DateTime.now();
  String? _tournamentType;
  bool _isLoading = false;
  Map<String, dynamic>? _selectedCourse;

  final List<Map<String, String>> _tournamentTypes = [
    {'value': 'local', 'label': 'Local Club Event'},
    {'value': 'regional', 'label': 'Regional'},
    {'value': 'state', 'label': 'State Championship'},
    {'value': 'national', 'label': 'National'},
    {'value': 'international', 'label': 'International'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _courseNameController.dispose();
    _courseCityController.dispose();
    _courseStateController.dispose();
    _courseParController.dispose();
    _totalScoreController.dispose();
    _positionController.dispose();
    _fieldSizeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onCourseSelected(Map<String, dynamic> course) {
    setState(() {
      _selectedCourse = course;
      _courseNameController.text = course['name'] as String;
      _courseCityController.text = course['city'] as String;
      _courseStateController.text = course['state'] as String;
      _courseParController.text = (course['par'] as int).toString();
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      helpText: 'Select Tournament Date',
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
        _startDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    // Validate course name - check both selected course and manual entry
    final courseName = (_selectedCourse?['name'] as String?) ?? _courseNameController.text.trim();
    if (courseName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select or enter a course name'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(tournamentNotifierProvider.notifier).createTournament(
            name: _nameController.text.trim(),
            startDate: _startDate,
            courseName: courseName,
            tournamentType: _tournamentType,
            courseCity: _courseCityController.text.trim().isEmpty
                ? null
                : _courseCityController.text.trim(),
            courseState: _courseStateController.text.trim().isEmpty
                ? null
                : _courseStateController.text.trim(),
            coursePar: _courseParController.text.isEmpty
                ? null
                : int.tryParse(_courseParController.text),
            totalScore: _totalScoreController.text.isEmpty
                ? null
                : int.tryParse(_totalScoreController.text),
            position: _positionController.text.isEmpty
                ? null
                : int.tryParse(_positionController.text),
            fieldSize: _fieldSizeController.text.isEmpty
                ? null
                : int.tryParse(_fieldSizeController.text),
            notes: _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament added successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add tournament: ${e.toString()}'),
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add Tournament'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tournament Info Section
                _buildSectionHeader('Tournament Info'),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  controller: _nameController,
                  label: 'Tournament Name',
                  hint: 'e.g., JNJG Tour Event',
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tournament name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                DropdownButtonFormField<String>(
                  value: _tournamentType,
                  decoration: const InputDecoration(
                    labelText: 'Tournament Type',
                    filled: true,
                    fillColor: AppColors.surface,
                  ),
                  items: _tournamentTypes.map((type) {
                    return DropdownMenuItem(
                      value: type['value'],
                      child: Text(type['label']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _tournamentType = value;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                GestureDetector(
                  onTap: _selectDate,
                  child: AbsorbPointer(
                    child: AppTextField(
                      controller: TextEditingController(
                        text: DateFormat('dd MMM yyyy').format(_startDate),
                      ),
                      label: 'Date',
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Course Info Section
                _buildSectionHeader('Course Info'),
                const SizedBox(height: AppSpacing.md),

                // Course Search Field
                CourseSearchField(
                  onCourseSelected: _onCourseSelected,
                  initialValue: _courseNameController.text.isNotEmpty
                      ? _courseNameController.text
                      : null,
                  label: 'Course Name',
                  hint: 'Search for a golf course...',
                ),
                const SizedBox(height: AppSpacing.md),

                // Show selected course info if available
                if (_selectedCourse != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: AppColors.primaryLight.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedCourse!['name'] as String,
                                style: AppTextStyles.titleSmall,
                              ),
                              Text(
                                '${_selectedCourse!['city']}, ${_selectedCourse!['state']} · Par ${_selectedCourse!['par']}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                'Slope ${_selectedCourse!['slope']} · CR ${(_selectedCourse!['rating'] as double).toStringAsFixed(1)}',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            setState(() {
                              _selectedCourse = null;
                              _courseNameController.clear();
                              _courseCityController.clear();
                              _courseStateController.clear();
                              _courseParController.clear();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _courseCityController,
                        label: 'City',
                        hint: 'Sydney',
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        controller: _courseStateController,
                        label: 'State',
                        hint: 'NSW',
                        textCapitalization: TextCapitalization.characters,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  controller: _courseParController,
                  label: 'Course Par',
                  hint: '72',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Results Section
                _buildSectionHeader('Results'),
                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _totalScoreController,
                        label: 'Total Score',
                        hint: '76',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _buildScoreToPar(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _positionController,
                        label: 'Position',
                        hint: '5',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        controller: _fieldSizeController,
                        label: 'Field Size',
                        hint: '24',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Notes Section
                _buildSectionHeader('Notes (Optional)'),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  controller: _notesController,
                  label: 'Notes',
                  hint: 'Any additional notes about the tournament...',
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Submit Button
                AppButton(
                  onPressed: _isLoading ? null : _submitForm,
                  isLoading: _isLoading,
                  child: const Text('Save Tournament'),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.titleLarge.copyWith(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildScoreToPar() {
    final score = int.tryParse(_totalScoreController.text);
    final par = int.tryParse(_courseParController.text);

    String display = '-';
    Color color = AppColors.textSecondary;

    if (score != null && par != null) {
      final toPar = score - par;
      if (toPar == 0) {
        display = 'E';
        color = AppColors.par;
      } else if (toPar > 0) {
        display = '+$toPar';
        color = toPar > 5 ? AppColors.doubleBogey : AppColors.bogey;
      } else {
        display = '$toPar';
        color = toPar < -2 ? AppColors.eagle : AppColors.birdie;
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.textHint),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To Par',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            display,
            style: AppTextStyles.headlineSmall.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
