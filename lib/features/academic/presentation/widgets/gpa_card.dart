import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../domain/academic_record.dart';

class GpaCard extends StatelessWidget {
  final AcademicProfile profile;

  const GpaCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildGpaStat(
                    'Cumulative GPA',
                    profile.formattedCumulativeGpa,
                    _getGpaColor(profile.cumulativeGpa),
                    isMain: true,
                  ),
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: AppColors.textHint.withValues(alpha: 0.3),
                ),
                Expanded(
                  child: _buildGpaStat(
                    'Weighted GPA',
                    profile.formattedWeightedGpa,
                    _getGpaColor(profile.weightedGpa),
                    isMain: false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),
            const Divider(),
            const SizedBox(height: AppSpacing.md),

            // Additional stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSmallStat(
                  '${profile.totalCredits}',
                  'Credits',
                  Icons.school,
                ),
                _buildSmallStat(
                  '${profile.yearSummaries.length}',
                  'Years',
                  Icons.calendar_today,
                ),
                _buildSmallStat(
                  '${_totalCourses()}',
                  'Courses',
                  Icons.book,
                ),
              ],
            ),

            // Test scores if available
            if (profile.satScore != null || profile.actScore != null) ...[
              const SizedBox(height: AppSpacing.md),
              const Divider(),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (profile.satScore != null)
                    _buildTestScore('SAT', profile.satScore!),
                  if (profile.actScore != null)
                    _buildTestScore('ACT', profile.actScore!),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGpaStat(
    String label,
    String value,
    Color color, {
    required bool isMain,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: (isMain ? AppTextStyles.headlineLarge : AppTextStyles.headlineMedium)
              .copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTestScore(String test, String score) {
    return Column(
      children: [
        Text(
          test,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          score,
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.7) return AppColors.success;
    if (gpa >= 3.0) return AppColors.primary;
    if (gpa >= 2.3) return AppColors.warning;
    return AppColors.error;
  }

  int _totalCourses() {
    return profile.yearSummaries.fold(
      0,
      (sum, year) => sum + year.totalCourses,
    );
  }
}
