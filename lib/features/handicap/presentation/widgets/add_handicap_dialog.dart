import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/handicap_provider.dart';

class AddHandicapDialog extends ConsumerStatefulWidget {
  const AddHandicapDialog({super.key});

  @override
  ConsumerState<AddHandicapDialog> createState() => _AddHandicapDialogState();
}

class _AddHandicapDialogState extends ConsumerState<AddHandicapDialog> {
  final _formKey = GlobalKey<FormState>();
  final _handicapController = TextEditingController();
  final _roundsCountedController = TextEditingController();

  DateTime _effectiveDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _handicapController.dispose();
    _roundsCountedController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _effectiveDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      helpText: 'Select Effective Date',
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
        _effectiveDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final handicapIndex = double.parse(_handicapController.text.trim());
      final roundsCounted = _roundsCountedController.text.isNotEmpty
          ? int.parse(_roundsCountedController.text.trim())
          : null;

      await ref.read(handicapNotifierProvider.notifier).addHandicapEntry(
            handicapIndex: handicapIndex,
            effectiveDate: _effectiveDate,
            source: 'manual',
            roundsCounted: roundsCounted,
          );

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Handicap entry added successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add handicap: ${e.toString()}'),
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Icon(
                      Icons.add_chart,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Add Handicap Entry',
                    style: AppTextStyles.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Handicap Index
              AppTextField(
                controller: _handicapController,
                label: 'Handicap Index',
                hint: 'e.g., 18.4',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Handicap index is required';
                  }
                  final handicap = double.tryParse(value.trim());
                  if (handicap == null) {
                    return 'Please enter a valid number';
                  }
                  if (handicap < -10 || handicap > 54) {
                    return 'Handicap must be between -10 and 54';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Effective Date
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: AppTextField(
                    controller: TextEditingController(
                      text: DateFormat('dd MMM yyyy').format(_effectiveDate),
                    ),
                    label: 'Effective Date',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Rounds Counted (Optional)
              AppTextField(
                controller: _roundsCountedController,
                label: 'Rounds Counted (Optional)',
                hint: 'e.g., 8',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Info box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'For official handicaps, sync with GA CONNECT',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppButton(
                      onPressed: _isLoading ? null : _submit,
                      isLoading: _isLoading,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
