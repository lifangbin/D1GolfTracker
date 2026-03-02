import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../data/milestone_repository.dart';

class MilestoneProgressHeader extends StatelessWidget {
  final Map<int, MilestoneStats> stats;
  final int currentPhase;

  const MilestoneProgressHeader({
    super.key,
    required this.stats,
    required this.currentPhase,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate overall stats
    int totalCompleted = 0;
    int totalMilestones = 0;
    for (final stat in stats.values) {
      totalCompleted += stat.completed;
      totalMilestones += stat.total;
    }

    final overallProgress =
        totalMilestones > 0 ? totalCompleted / totalMilestones : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.textHint,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Overall progress
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overall Progress',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalCompleted of $totalMilestones completed',
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: overallProgress,
                      backgroundColor: AppColors.textHint.withValues(alpha: 0.3),
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                    Center(
                      child: Text(
                        '${(overallProgress * 100).round()}%',
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Phase progress bars
          Row(
            children: [
              for (var phase = 1; phase <= 4; phase++) ...[
                if (phase > 1) const SizedBox(width: 8),
                Expanded(
                  child: _PhaseProgressBar(
                    phase: phase,
                    stats: stats[phase] ?? const MilestoneStats(completed: 0, total: 0),
                    isCurrentPhase: phase == currentPhase,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _PhaseProgressBar extends StatelessWidget {
  final int phase;
  final MilestoneStats stats;
  final bool isCurrentPhase;

  const _PhaseProgressBar({
    required this.phase,
    required this.stats,
    required this.isCurrentPhase,
  });

  @override
  Widget build(BuildContext context) {
    final progress = stats.total > 0 ? stats.completed / stats.total : 0.0;
    final isComplete = stats.completed == stats.total && stats.total > 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'P$phase',
              style: AppTextStyles.labelSmall.copyWith(
                color: isCurrentPhase
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontWeight: isCurrentPhase ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              stats.displayText,
              style: AppTextStyles.labelSmall.copyWith(
                color: isComplete
                    ? AppColors.success
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.textHint.withValues(alpha: 0.3),
            minHeight: 8,
            valueColor: AlwaysStoppedAnimation(
              isComplete
                  ? AppColors.success
                  : isCurrentPhase
                      ? AppColors.primary
                      : AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
