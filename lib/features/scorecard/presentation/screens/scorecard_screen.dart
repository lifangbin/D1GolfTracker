import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../domain/hole_score.dart';
import '../providers/scorecard_provider.dart';

class ScorecardScreen extends ConsumerWidget {
  final String roundId;

  const ScorecardScreen({
    super.key,
    required this.roundId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scorecardAsync = ref.watch(scorecardProvider(roundId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Scorecard'),
      ),
      body: scorecardAsync.when(
        data: (scorecard) => _buildScorecard(context, scorecard),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Error loading scorecard', style: AppTextStyles.titleMedium),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScorecard(BuildContext context, Scorecard scorecard) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score summary card
          _buildScoreSummary(scorecard),
          const SizedBox(height: AppSpacing.md),

          // Stats card
          _buildStatsCard(scorecard),
          const SizedBox(height: AppSpacing.md),

          // Score distribution
          _buildScoreDistribution(scorecard),
          const SizedBox(height: AppSpacing.md),

          // Front 9 grid
          _buildNineHolesSection('Front Nine', scorecard.frontNine, scorecard.frontNineTotal, scorecard.frontNinePar),
          const SizedBox(height: AppSpacing.md),

          // Back 9 grid
          _buildNineHolesSection('Back Nine', scorecard.backNine, scorecard.backNineTotal, scorecard.backNinePar),
        ],
      ),
    );
  }

  Widget _buildScoreSummary(Scorecard scorecard) {
    final scoreToPar = scorecard.scoreToPar;
    final scoreColor = _getScoreColor(scoreToPar);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${scorecard.totalStrokes}',
                    style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 56,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: scoreColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      scorecard.scoreToParDisplay,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: scoreColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _buildNineSummary(
                  'Out',
                  scorecard.frontNineTotal,
                  scorecard.frontNinePar,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.textHint.withOpacity(0.3),
              ),
              Expanded(
                child: _buildNineSummary(
                  'In',
                  scorecard.backNineTotal,
                  scorecard.backNinePar,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNineSummary(String label, int strokes, int par) {
    final diff = strokes - par;
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$strokes',
              style: AppTextStyles.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              diff == 0 ? 'E' : (diff > 0 ? '+$diff' : '$diff'),
              style: AppTextStyles.labelMedium.copyWith(
                color: _getScoreColor(diff),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard(Scorecard scorecard) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Statistics', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Putts',
                  scorecard.totalPutts?.toString() ?? '-',
                  Icons.sports_golf,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Fairways',
                  '${scorecard.fairwaysHit}/${scorecard.totalFairways}',
                  Icons.straighten,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'GIR',
                  '${scorecard.greensInRegulation}/18',
                  Icons.flag,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreDistribution(Scorecard scorecard) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Score Distribution', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDistItem('Eagles', scorecard.eaglesOrBetter, AppColors.eagle),
              _buildDistItem('Birdies', scorecard.birdies, AppColors.birdie),
              _buildDistItem('Pars', scorecard.pars, AppColors.par),
              _buildDistItem('Bogeys', scorecard.bogeys, AppColors.bogey),
              _buildDistItem('Double+', scorecard.doubleBogeyOrWorse, AppColors.doubleBogey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistItem(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$count',
              style: AppTextStyles.titleMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildNineHolesSection(
    String title,
    List<HoleScore> holes,
    int total,
    int par,
  ) {
    final diff = total - par;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.titleSmall),
              Row(
                children: [
                  Text(
                    'Par $par',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getScoreColor(diff).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      '$total (${diff == 0 ? "E" : (diff > 0 ? "+$diff" : "$diff")})',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: _getScoreColor(diff),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Holes grid
          _buildHolesGrid(holes),
        ],
      ),
    );
  }

  Widget _buildHolesGrid(List<HoleScore> holes) {
    return Column(
      children: [
        // Hole numbers
        Row(
          children: holes.map((h) => Expanded(
            child: Center(
              child: Text(
                '${h.holeNumber}',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 4),

        // Par values
        Row(
          children: holes.map((h) => Expanded(
            child: Center(
              child: Text(
                '${h.par}',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 4),

        // Scores
        Row(
          children: holes.map((h) => Expanded(
            child: Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _getScoreColor(h.scoreToPar).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${h.strokes}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: _getScoreColor(h.scoreToPar),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )).toList(),
        ),

        // Putts (if available)
        if (holes.any((h) => h.putts != null)) ...[
          const SizedBox(height: 4),
          Row(
            children: holes.map((h) => Expanded(
              child: Center(
                child: Text(
                  h.putts?.toString() ?? '-',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )).toList(),
          ),
        ],
      ],
    );
  }

  Color _getScoreColor(int scoreToPar) {
    if (scoreToPar <= -2) return AppColors.eagle;
    if (scoreToPar == -1) return AppColors.birdie;
    if (scoreToPar == 0) return AppColors.par;
    if (scoreToPar == 1) return AppColors.bogey;
    return AppColors.doubleBogey;
  }
}
