import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../domain/academic_record.dart';
import '../providers/academic_provider.dart';

class AddGradeSheet extends ConsumerStatefulWidget {
  const AddGradeSheet({super.key});

  @override
  ConsumerState<AddGradeSheet> createState() => _AddGradeSheetState();
}

class _AddGradeSheetState extends ConsumerState<AddGradeSheet> {
  final _formKey = GlobalKey<FormState>();

  final _courseNameController = TextEditingController();
  final _percentageController = TextEditingController();

  SubjectCategory _category = SubjectCategory.english;
  GradeLevel _gradeLevel = GradeLevel.grade9;
  int _year = DateTime.now().year;
  AcademicTerm _term = AcademicTerm.semester1;
  LetterGrade _grade = LetterGrade.a;
  bool _isApHonors = false;

  @override
  void dispose() {
    _courseNameController.dispose();
    _percentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textHint,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        'Add Course Grade',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Course name
                      TextFormField(
                        controller: _courseNameController,
                        decoration: const InputDecoration(
                          labelText: 'Course Name *',
                          hintText: 'e.g., English Literature',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter course name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Category
                      DropdownButtonFormField<SubjectCategory>(
                        value: _category,
                        decoration: const InputDecoration(
                          labelText: 'Subject Category',
                          border: OutlineInputBorder(),
                        ),
                        items: SubjectCategory.values.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat.label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _category = value);
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Year and Grade Level
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _year,
                              decoration: const InputDecoration(
                                labelText: 'Year',
                                border: OutlineInputBorder(),
                              ),
                              items: List.generate(10, (i) {
                                final year = DateTime.now().year - i;
                                return DropdownMenuItem(
                                  value: year,
                                  child: Text('$year'),
                                );
                              }),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _year = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: DropdownButtonFormField<GradeLevel>(
                              value: _gradeLevel,
                              decoration: const InputDecoration(
                                labelText: 'Grade Level',
                                border: OutlineInputBorder(),
                              ),
                              items: GradeLevel.values.map((level) {
                                return DropdownMenuItem(
                                  value: level,
                                  child: Text(level.label),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _gradeLevel = value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Term and Grade
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<AcademicTerm>(
                              value: _term,
                              decoration: const InputDecoration(
                                labelText: 'Term',
                                border: OutlineInputBorder(),
                              ),
                              items: AcademicTerm.values.map((term) {
                                return DropdownMenuItem(
                                  value: term,
                                  child: Text(term.label),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _term = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: DropdownButtonFormField<LetterGrade>(
                              value: _grade,
                              decoration: const InputDecoration(
                                labelText: 'Grade',
                                border: OutlineInputBorder(),
                              ),
                              items: LetterGrade.values.map((grade) {
                                return DropdownMenuItem(
                                  value: grade,
                                  child: Text(grade.label),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _grade = value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Percentage score (optional)
                      TextField(
                        controller: _percentageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Percentage Score (optional)',
                          hintText: 'e.g., 95',
                          suffixText: '%',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // AP/Honors toggle
                      SwitchListTile(
                        title: const Text('AP / Honors Course'),
                        subtitle: const Text('Weighted for GPA calculation'),
                        value: _isApHonors,
                        onChanged: (value) {
                          setState(() => _isApHonors = value);
                        },
                        contentPadding: EdgeInsets.zero,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Save Grade'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(academicNotifierProvider.notifier).addCourseGrade(
          courseName: _courseNameController.text,
          category: _category,
          gradeLevel: _gradeLevel,
          year: _year,
          term: _term,
          grade: _grade,
          percentageScore: _percentageController.text.isNotEmpty
              ? double.tryParse(_percentageController.text)
              : null,
          isApHonors: _isApHonors,
          isWeighted: _isApHonors,
          creditHours: 1.0,
        );

    Navigator.pop(context);
  }
}
