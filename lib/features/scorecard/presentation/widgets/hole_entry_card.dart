import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../providers/scorecard_provider.dart';

class HoleEntryCard extends StatelessWidget {
  final HoleEntryData holeData;
  final ValueChanged<int> onStrokesChanged;
  final ValueChanged<int> onPuttsChanged;
  final ValueChanged<int> onParChanged;
  final ValueChanged<bool?> onFairwayChanged;
  final ValueChanged<bool?> onGIRChanged;

  const HoleEntryCard({
    super.key,
    required this.holeData,
    required this.onStrokesChanged,
    required this.onPuttsChanged,
    required this.onParChanged,
    required this.onFairwayChanged,
    required this.onGIRChanged,
  });

  Color _getScoreColor(int? strokes, int par) {
    if (strokes == null) return AppColors.textSecondary;
    final diff = strokes - par;
    if (diff <= -2) return AppColors.eagle;
    if (diff == -1) return AppColors.birdie;
    if (diff == 0) return AppColors.par;
    if (diff == 1) return AppColors.bogey;
    return AppColors.doubleBogey;
  }

  String _getScoreLabel(int? strokes, int par) {
    if (strokes == null) return '';
    final diff = strokes - par;
    if (diff <= -2) return 'Eagle';
    if (diff == -1) return 'Birdie';
    if (diff == 0) return 'Par';
    if (diff == 1) return 'Bogey';
    if (diff == 2) return 'Double';
    return '+$diff';
  }

  @override
  Widget build(BuildContext context) {
    final scoreColor = _getScoreColor(holeData.strokes, holeData.par);
    final scoreLabel = _getScoreLabel(holeData.strokes, holeData.par);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: holeData.strokes != null
              ? scoreColor.withOpacity(0.3)
              : AppColors.textHint.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: Hole number, Par selector, Score indicator
          Row(
            children: [
              // Hole number
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Center(
                  child: Text(
                    '${holeData.holeNumber}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Par selector
              _ParSelector(
                par: holeData.par,
                onChanged: onParChanged,
              ),

              const Spacer(),

              // Score indicator
              if (holeData.strokes != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scoreColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    scoreLabel,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Strokes entry
          Row(
            children: [
              Text(
                'Strokes',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              _NumberStepper(
                value: holeData.strokes,
                min: 1,
                max: 15,
                accentColor: scoreColor,
                onChanged: onStrokesChanged,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Putts entry
          Row(
            children: [
              Text(
                'Putts',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              _NumberStepper(
                value: holeData.putts,
                min: 0,
                max: 10,
                onChanged: onPuttsChanged,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Stats toggles (Fairway, GIR)
          Row(
            children: [
              // Fairway (only for par 4 and 5)
              if (holeData.par > 3) ...[
                Expanded(
                  child: _ToggleButton(
                    label: 'Fairway',
                    value: holeData.fairwayHit,
                    onChanged: onFairwayChanged,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],

              // GIR
              Expanded(
                child: _ToggleButton(
                  label: 'GIR',
                  value: holeData.greenInRegulation,
                  onChanged: onGIRChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParSelector extends StatelessWidget {
  final int par;
  final ValueChanged<int> onChanged;

  const _ParSelector({
    required this.par,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Par',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(3, (index) {
          final parValue = 3 + index;
          final isSelected = par == parValue;
          return GestureDetector(
            onTap: () => onChanged(parValue),
            child: Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Center(
                child: Text(
                  '$parValue',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _NumberStepper extends StatelessWidget {
  final int? value;
  final int min;
  final int max;
  final Color? accentColor;
  final ValueChanged<int> onChanged;

  const _NumberStepper({
    required this.value,
    required this.min,
    required this.max,
    this.accentColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrement button
        _StepperButton(
          icon: Icons.remove,
          onTap: value != null && value! > min
              ? () => onChanged(value! - 1)
              : null,
        ),

        // Value display
        Container(
          width: 48,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: value != null ? color.withOpacity(0.1) : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: value != null ? color.withOpacity(0.3) : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              value?.toString() ?? '-',
              style: AppTextStyles.titleMedium.copyWith(
                color: value != null ? color : AppColors.textHint,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Increment button
        _StepperButton(
          icon: Icons.add,
          onTap: value == null || value! < max
              ? () => onChanged((value ?? min - 1) + 1)
              : null,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isEnabled ? Colors.white : AppColors.textHint,
        ),
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const _ToggleButton({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        _TriStateToggle(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _TriStateToggle extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const _TriStateToggle({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // No button
        GestureDetector(
          onTap: () => onChanged(value == false ? null : false),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: value == false ? AppColors.error : AppColors.surfaceVariant,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(AppRadius.md),
              ),
            ),
            child: Icon(
              Icons.close,
              size: 16,
              color: value == false ? Colors.white : AppColors.textHint,
            ),
          ),
        ),

        // Yes button
        GestureDetector(
          onTap: () => onChanged(value == true ? null : true),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: value == true ? AppColors.success : AppColors.surfaceVariant,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(AppRadius.md),
              ),
            ),
            child: Icon(
              Icons.check,
              size: 16,
              color: value == true ? Colors.white : AppColors.textHint,
            ),
          ),
        ),
      ],
    );
  }
}
