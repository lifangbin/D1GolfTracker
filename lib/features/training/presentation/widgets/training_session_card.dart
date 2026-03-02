import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../domain/training_session.dart';

class TrainingSessionCard extends StatelessWidget {
  final TrainingSession session;
  final VoidCallback? onDelete;

  const TrainingSessionCard({
    super.key,
    required this.session,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTypeColor(session.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getTypeIcon(session.type),
                    color: _getTypeColor(session.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.type.label,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, d MMM yyyy').format(session.date),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: AppColors.textHint,
                    onPressed: onDelete,
                  ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Stats row
            Row(
              children: [
                _buildStat(
                  Icons.timer_outlined,
                  session.formattedDuration,
                  'Duration',
                ),
                if (session.location != null) ...[
                  const SizedBox(width: AppSpacing.lg),
                  _buildStat(
                    Icons.location_on_outlined,
                    session.location!,
                    'Location',
                  ),
                ],
                if (session.ballsHit != null) ...[
                  const SizedBox(width: AppSpacing.lg),
                  _buildStat(
                    Icons.sports_golf,
                    '${session.ballsHit}',
                    'Balls Hit',
                  ),
                ],
              ],
            ),

            // Focus areas
            if (session.focusAreas.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: session.focusAreas.map((focus) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.textHint),
                    ),
                    child: Text(
                      focus.label,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // Rating
            if (session.rating != null) ...[
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Text(
                    'Quality: ',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < session.rating! ? Icons.star : Icons.star_border,
                      size: 16,
                      color: AppColors.accent,
                    );
                  }),
                ],
              ),
            ],

            // Notes
            if (session.notes != null && session.notes!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                session.notes!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  IconData _getTypeIcon(TrainingType type) {
    switch (type) {
      case TrainingType.driving:
        return Icons.sports_golf;
      case TrainingType.putting:
        return Icons.flag;
      case TrainingType.chipping:
        return Icons.golf_course;
      case TrainingType.bunker:
        return Icons.beach_access;
      case TrainingType.fullSwing:
        return Icons.sports_golf;
      case TrainingType.course:
        return Icons.landscape;
      case TrainingType.fitness:
        return Icons.fitness_center;
      case TrainingType.mentalGame:
        return Icons.psychology;
      case TrainingType.lesson:
        return Icons.school;
      case TrainingType.simulator:
        return Icons.computer;
    }
  }

  Color _getTypeColor(TrainingType type) {
    switch (type) {
      case TrainingType.driving:
        return AppColors.primary;
      case TrainingType.putting:
        return Colors.green;
      case TrainingType.chipping:
        return Colors.teal;
      case TrainingType.bunker:
        return Colors.amber;
      case TrainingType.fullSwing:
        return AppColors.primary;
      case TrainingType.course:
        return Colors.indigo;
      case TrainingType.fitness:
        return Colors.red;
      case TrainingType.mentalGame:
        return Colors.purple;
      case TrainingType.lesson:
        return Colors.blue;
      case TrainingType.simulator:
        return Colors.grey;
    }
  }
}
