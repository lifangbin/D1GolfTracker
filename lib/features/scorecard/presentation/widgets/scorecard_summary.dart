import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../providers/scorecard_provider.dart';

class ScorecardSummary extends StatelessWidget {
  final ScorecardEntryState state;

  const ScorecardSummary({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Round Summary', style: AppTextStyles.titleLarge),
        const SizedBox(height: AppSpacing.md),

        // Course info card
        _buildInfoCard(),
        const SizedBox(height: AppSpacing.md),

        // Score breakdown card
        _buildScoreCard(),
        const SizedBox(height: AppSpacing.md),

        // Stats card
        _buildStatsCard(),
        const SizedBox(height: AppSpacing.md),

        // Scorecard grid
        _buildScorecardGrid(),
      ],
    );
  }

  Widget _buildInfoCard() {
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
            children: [
              const Icon(Icons.golf_course, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  state.courseName ?? 'Unknown Course',
                  style: AppTextStyles.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildInfoChip('Par ${state.coursePar}'),
              const SizedBox(width: 8),
              if (state.courseSlope != null)
                _buildInfoChip('Slope ${state.courseSlope!.toInt()}'),
              const SizedBox(width: 8),
              if (state.courseRating != null)
                _buildInfoChip('CR ${state.courseRating!.toStringAsFixed(1)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    final scoreToPar = state.scoreToPar;
    final scoreColor = _getScoreColor(scoreToPar);
    final netScore = state.netScore;
    final netScoreToPar = state.netScoreToPar;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          // Main scores (Gross and Net side by side)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Gross Score
              Column(
                children: [
                  Text(
                    'Gross',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${state.totalStrokes}',
                    style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: scoreColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      _getScoreToParDisplay(scoreToPar),
                      style: AppTextStyles.titleMedium.copyWith(
                        color: scoreColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Net Score (if handicap provided)
              if (netScore != null) ...[
                Container(
                  width: 1,
                  height: 80,
                  color: AppColors.textHint.withOpacity(0.3),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Net',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'HCP ${state.playingHandicap!.toStringAsFixed(1)}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$netScore',
                      style: AppTextStyles.displayLarge.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getScoreColor(netScoreToPar!).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Text(
                        _getScoreToParDisplay(netScoreToPar),
                        style: AppTextStyles.titleMedium.copyWith(
                          color: _getScoreColor(netScoreToPar),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),

          const SizedBox(height: AppSpacing.md),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),

          // Front 9 / Back 9 breakdown
          Row(
            children: [
              Expanded(
                child: _buildNineHoleScore(
                  'Front 9',
                  state.frontNineStrokes,
                  _getFrontNinePar(),
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.textHint.withOpacity(0.3),
              ),
              Expanded(
                child: _buildNineHoleScore(
                  'Back 9',
                  state.backNineStrokes,
                  _getBackNinePar(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getFrontNinePar() {
    return state.holes
        .where((h) => h.holeNumber <= 9)
        .fold(0, (sum, h) => sum + h.par);
  }

  int _getBackNinePar() {
    return state.holes
        .where((h) => h.holeNumber > 9)
        .fold(0, (sum, h) => sum + h.par);
  }

  Widget _buildNineHoleScore(String label, int strokes, int par) {
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

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistics',
            style: AppTextStyles.titleSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Putts',
                  '${state.totalPutts}',
                  Icons.sports_golf,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Fairways',
                  '${state.fairwaysHit}/${state.totalFairways}',
                  Icons.straighten,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'GIR',
                  '${state.greensInRegulation}/18',
                  Icons.flag,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildScoreDistribution(),
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

  Widget _buildScoreDistribution() {
    final distribution = _getScoreDistribution();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDistributionItem('Eagles', distribution['eagle'] ?? 0, AppColors.eagle),
        _buildDistributionItem('Birdies', distribution['birdie'] ?? 0, AppColors.birdie),
        _buildDistributionItem('Pars', distribution['par'] ?? 0, AppColors.par),
        _buildDistributionItem('Bogeys', distribution['bogey'] ?? 0, AppColors.bogey),
        _buildDistributionItem('Double+', distribution['double'] ?? 0, AppColors.doubleBogey),
      ],
    );
  }

  Map<String, int> _getScoreDistribution() {
    final dist = <String, int>{
      'eagle': 0,
      'birdie': 0,
      'par': 0,
      'bogey': 0,
      'double': 0,
    };

    for (final hole in state.holes) {
      if (hole.strokes == null) continue;
      final diff = hole.strokes! - hole.par;
      if (diff <= -2) {
        dist['eagle'] = dist['eagle']! + 1;
      } else if (diff == -1) {
        dist['birdie'] = dist['birdie']! + 1;
      } else if (diff == 0) {
        dist['par'] = dist['par']! + 1;
      } else if (diff == 1) {
        dist['bogey'] = dist['bogey']! + 1;
      } else {
        dist['double'] = dist['double']! + 1;
      }
    }

    return dist;
  }

  Widget _buildDistributionItem(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$count',
              style: AppTextStyles.labelMedium.copyWith(
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

  Widget _buildScorecardGrid() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scorecard',
            style: AppTextStyles.titleSmall,
          ),
          const SizedBox(height: AppSpacing.md),

          // Front 9
          _buildNineGrid(state.holes.where((h) => h.holeNumber <= 9).toList()),
          const SizedBox(height: AppSpacing.md),

          // Back 9
          _buildNineGrid(state.holes.where((h) => h.holeNumber > 9).toList()),
        ],
      ),
    );
  }

  Widget _buildNineGrid(List<HoleEntryData> holes) {
    return Column(
      children: [
        // Hole numbers row
        Row(
          children: [
            const SizedBox(width: 40),
            ...holes.map((h) => Expanded(
              child: Center(
                child: Text(
                  '${h.holeNumber}',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
          ],
        ),
        const SizedBox(height: 4),

        // Par row
        Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                'Par',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...holes.map((h) => Expanded(
              child: Center(
                child: Text(
                  '${h.par}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )),
          ],
        ),
        const SizedBox(height: 4),

        // Score row
        Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                'Score',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...holes.map((h) => Expanded(
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: h.strokes != null
                        ? _getScoreColor(h.strokes! - h.par).withOpacity(0.15)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      h.strokes?.toString() ?? '-',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: h.strokes != null
                            ? _getScoreColor(h.strokes! - h.par)
                            : AppColors.textHint,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
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

  String _getScoreToParDisplay(int scoreToPar) {
    if (scoreToPar == 0) return 'Even';
    if (scoreToPar > 0) return '+$scoreToPar';
    return '$scoreToPar';
  }
}
