import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../domain/training_session.dart';
import '../providers/training_provider.dart';
import '../widgets/add_training_sheet.dart';
import '../widgets/training_session_card.dart';
import '../widgets/weekly_summary_card.dart';

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(trainingSessionsProvider);
    final summaryAsync = ref.watch(weeklyTrainingSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              // TODO: Calendar view
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(trainingSessionsProvider);
          ref.invalidate(weeklyTrainingSummaryProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Weekly Summary
            summaryAsync.when(
              data: (summary) => WeeklySummaryCard(summary: summary),
              loading: () => const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SizedBox.shrink(),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Recent Sessions Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Sessions',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // TODO: View all
                  },
                  icon: const Icon(Icons.history, size: 18),
                  label: const Text('View All'),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            // Sessions List
            sessionsAsync.when(
              data: (sessions) {
                if (sessions.isEmpty) {
                  return _buildEmptyState(context);
                }

                return Column(
                  children: sessions
                      .take(10)
                      .map((session) => TrainingSessionCard(
                            session: session,
                            onDelete: () => _deleteSession(context, ref, session),
                          ))
                      .toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, _) => Center(
                child: Column(
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: AppColors.error),
                    const SizedBox(height: AppSpacing.md),
                    Text('Error loading sessions'),
                    const SizedBox(height: AppSpacing.sm),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(trainingSessionsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSessionSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Log Training'),
      ),
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
              Icons.fitness_center,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No training sessions yet',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Start logging your practice sessions\nto track your progress',
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

  void _showAddSessionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddTrainingSheet(),
    );
  }

  void _deleteSession(
    BuildContext context,
    WidgetRef ref,
    TrainingSession session,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Session?'),
        content: Text(
          'Are you sure you want to delete this ${session.type.label} session?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(trainingNotifierProvider.notifier).deleteSession(
                    session.id,
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
