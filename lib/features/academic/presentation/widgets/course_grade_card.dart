import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../domain/academic_record.dart';

class CourseGradeCard extends StatelessWidget {
  final CourseGrade grade;
  final VoidCallback? onDelete;

  const CourseGradeCard({
    super.key,
    required this.grade,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            // Grade badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getGradeColor(grade.grade).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  grade.grade.label,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getGradeColor(grade.grade),
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // Course info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          grade.courseName,
                          style: AppTextStyles.titleSmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (grade.isApHonors == true)
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'AP',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        grade.category.label,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (grade.term != AcademicTerm.fullYear) ...[
                        const Text(' • '),
                        Text(
                          grade.term.label,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (grade.percentageScore != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${grade.percentageScore!.toStringAsFixed(1)}%',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Delete button
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: AppColors.textHint,
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(LetterGrade grade) {
    if (grade.gpaValue >= 3.7) return AppColors.success;
    if (grade.gpaValue >= 3.0) return AppColors.primary;
    if (grade.gpaValue >= 2.0) return AppColors.warning;
    return AppColors.error;
  }
}
