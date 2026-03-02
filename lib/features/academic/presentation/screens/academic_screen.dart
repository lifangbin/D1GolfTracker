import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../domain/academic_record.dart';
import '../providers/academic_provider.dart';
import '../widgets/add_grade_sheet.dart';
import '../widgets/gpa_card.dart';
import '../widgets/course_grade_card.dart';

class AcademicScreen extends ConsumerWidget {
  const AcademicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(academicProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAcademicInfo(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(academicProfileProvider);
          ref.invalidate(courseGradesProvider);
        },
        child: profileAsync.when(
          data: (profile) => _buildContent(context, ref, profile),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 48, color: AppColors.error),
                const SizedBox(height: AppSpacing.md),
                Text('Error loading academic records'),
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton(
                  onPressed: () => ref.invalidate(academicProfileProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGradeSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Grade'),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    AcademicProfile profile,
  ) {
    if (profile.yearSummaries.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        // GPA Summary Card
        GpaCard(profile: profile),

        const SizedBox(height: AppSpacing.lg),

        // Academic Standing Status
        _buildEligibilityCard(profile),

        const SizedBox(height: AppSpacing.lg),

        // Year by year breakdown
        for (final yearSummary in profile.yearSummaries) ...[
          _buildYearSection(context, ref, yearSummary),
          const SizedBox(height: AppSpacing.lg),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No academic records yet',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Add your course grades to track\nyour academic progress',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEligibilityCard(AcademicProfile profile) {
    final isGood = profile.cumulativeGpa >= 3.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isGood
                    ? AppColors.success.withValues(alpha: 0.1)
                    : AppColors.warning.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isGood ? Icons.check_circle : Icons.trending_up,
                color: isGood ? AppColors.success : AppColors.warning,
                size: 28,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Academic Standing',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isGood
                        ? 'Great academic performance!'
                        : 'Keep working to improve your GPA',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearSection(
    BuildContext context,
    WidgetRef ref,
    AcademicYearSummary yearSummary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '${yearSummary.year}',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    yearSummary.gradeLevel.label,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'GPA: ${yearSummary.formattedGpa}',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                if (yearSummary.weightedGpa != yearSummary.gpa)
                  Text(
                    'Weighted: ${yearSummary.formattedWeightedGpa}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Course cards
        ...yearSummary.courses.map(
          (grade) => CourseGradeCard(
            grade: grade,
            onDelete: () => _deleteGrade(context, ref, grade),
          ),
        ),
      ],
    );
  }

  void _showAddGradeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddGradeSheet(),
    );
  }

  void _deleteGrade(BuildContext context, WidgetRef ref, CourseGrade grade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Grade?'),
        content: Text(
          'Are you sure you want to delete "${grade.courseName}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(academicNotifierProvider.notifier).deleteCourseGrade(
                    grade.id,
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAcademicInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Academic Tracking'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Why Track Academics?',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('• Balance golf and education'),
              const Text('• Monitor academic progress'),
              const Text('• Track GPA over time'),
              const Text('• Stay organized with course grades'),
              const SizedBox(height: 16),
              Text(
                'GPA Goals:',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('• 3.0+ : Strong academic standing'),
              const Text('• 3.5+ : Excellent performance'),
              const Text('• 4.0  : Outstanding achievement'),
              const SizedBox(height: 8),
              const Text(
                'Tip: Maintaining good grades shows dedication and discipline.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
