import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../domain/training_session.dart';
import '../providers/training_provider.dart';

class AddTrainingSheet extends ConsumerStatefulWidget {
  const AddTrainingSheet({super.key});

  @override
  ConsumerState<AddTrainingSheet> createState() => _AddTrainingSheetState();
}

class _AddTrainingSheetState extends ConsumerState<AddTrainingSheet> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  TrainingType _type = TrainingType.driving;
  int _durationMinutes = 60;
  TrainingIntensity _intensity = TrainingIntensity.moderate;
  final Set<TrainingFocus> _focusAreas = {};
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final _coachController = TextEditingController();
  final _ballsHitController = TextEditingController();
  double _rating = 3;

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    _coachController.dispose();
    _ballsHitController.dispose();
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
                        'Log Training Session',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Date picker
                      _buildDatePicker(),
                      const SizedBox(height: AppSpacing.md),

                      // Training type
                      Text('Training Type', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      _buildTypeDropdown(),
                      const SizedBox(height: AppSpacing.md),

                      // Duration
                      Text('Duration', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      _buildDurationSlider(),
                      const SizedBox(height: AppSpacing.md),

                      // Intensity
                      Text('Intensity', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      _buildIntensityChips(),
                      const SizedBox(height: AppSpacing.md),

                      // Focus areas
                      Text('Focus Areas', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      _buildFocusAreaChips(),
                      const SizedBox(height: AppSpacing.md),

                      // Location
                      TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location (optional)',
                          prefixIcon: Icon(Icons.location_on_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Balls hit
                      if (_type == TrainingType.driving ||
                          _type == TrainingType.fullSwing) ...[
                        TextField(
                          controller: _ballsHitController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Balls Hit (optional)',
                            prefixIcon: Icon(Icons.sports_golf),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],

                      // Coach
                      TextField(
                        controller: _coachController,
                        decoration: const InputDecoration(
                          labelText: 'Coach Name (optional)',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Rating
                      Text('Session Quality', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      _buildRatingSlider(),
                      const SizedBox(height: AppSpacing.md),

                      // Notes
                      TextField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes (optional)',
                          prefixIcon: Icon(Icons.notes),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Save Session'),
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

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() => _date = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textHint),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 12),
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(_date),
              style: AppTextStyles.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<TrainingType>(
      value: _type,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      items: TrainingType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.label),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _type = value);
        }
      },
    );
  }

  Widget _buildDurationSlider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('30 min'),
            Text(
              '${_durationMinutes} min',
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Text('180 min'),
          ],
        ),
        Slider(
          value: _durationMinutes.toDouble(),
          min: 30,
          max: 180,
          divisions: 10,
          onChanged: (value) {
            setState(() => _durationMinutes = value.round());
          },
        ),
      ],
    );
  }

  Widget _buildIntensityChips() {
    return Row(
      children: TrainingIntensity.values.map((intensity) {
        final isSelected = intensity == _intensity;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(intensity.label),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _intensity = intensity);
                }
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFocusAreaChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: TrainingFocus.values.map((focus) {
        final isSelected = _focusAreas.contains(focus);
        return FilterChip(
          label: Text(focus.label),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _focusAreas.add(focus);
              } else {
                _focusAreas.remove(focus);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRatingSlider() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final starValue = index + 1;
          return IconButton(
            onPressed: () {
              setState(() => _rating = starValue.toDouble());
            },
            icon: Icon(
              starValue <= _rating ? Icons.star : Icons.star_border,
              color: AppColors.accent,
              size: 32,
            ),
          );
        }),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(trainingNotifierProvider.notifier).addSession(
          date: _date,
          type: _type,
          durationMinutes: _durationMinutes,
          location: _locationController.text.isNotEmpty
              ? _locationController.text
              : null,
          intensity: _intensity,
          focusAreas: _focusAreas.toList(),
          notes:
              _notesController.text.isNotEmpty ? _notesController.text : null,
          coachName:
              _coachController.text.isNotEmpty ? _coachController.text : null,
          ballsHit: _ballsHitController.text.isNotEmpty
              ? int.tryParse(_ballsHitController.text)
              : null,
          rating: _rating,
        );

    Navigator.pop(context);
  }
}
