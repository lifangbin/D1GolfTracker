import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../auth/presentation/providers/player_provider.dart';
import '../../domain/milestone.dart';
import '../providers/milestone_provider.dart';
import '../widgets/milestone_card.dart';
import '../widgets/milestone_progress_header.dart';

class MilestonesScreen extends ConsumerStatefulWidget {
  const MilestonesScreen({super.key});

  @override
  ConsumerState<MilestonesScreen> createState() => _MilestonesScreenState();
}

class _MilestonesScreenState extends ConsumerState<MilestonesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Set initial tab to player's current phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final player = ref.read(playerNotifierProvider).valueOrNull;
      if (player != null && player.currentPhase >= 1 && player.currentPhase <= 4) {
        _tabController.animateTo(player.currentPhase - 1);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(milestoneStatsProvider);
    final player = ref.watch(playerNotifierProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Milestones'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Phase 1'),
            Tab(text: 'Phase 2'),
            Tab(text: 'Phase 3'),
            Tab(text: 'Phase 4'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Progress overview
          statsAsync.when(
            data: (stats) => MilestoneProgressHeader(
              stats: stats,
              currentPhase: player?.currentPhase ?? 1,
            ),
            loading: () => const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Phase tabs content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PhaseTab(phase: 1),
                _PhaseTab(phase: 2),
                _PhaseTab(phase: 3),
                _PhaseTab(phase: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseTab extends ConsumerWidget {
  final int phase;

  const _PhaseTab({required this.phase});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestonesAsync = ref.watch(phaseMilestonesProvider(phase));

    return milestonesAsync.when(
      data: (milestones) {
        if (milestones.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  size: 64,
                  color: AppColors.textHint,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'No milestones for this phase',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        // Group by category
        final groupedMilestones = <MilestoneCategory, List<MilestoneWithProgress>>{};
        for (final m in milestones) {
          groupedMilestones
              .putIfAbsent(m.definition.category, () => [])
              .add(m);
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(phaseMilestonesProvider(phase));
            ref.invalidate(milestoneStatsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // Phase header
              _buildPhaseHeader(context, phase),
              const SizedBox(height: AppSpacing.md),

              // Milestones by category
              for (final category in MilestoneCategory.values)
                if (groupedMilestones.containsKey(category))
                  _buildCategorySection(
                    context,
                    ref,
                    category,
                    groupedMilestones[category]!,
                  ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text('Error loading milestones'),
            const SizedBox(height: AppSpacing.sm),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(phaseMilestonesProvider(phase));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseHeader(BuildContext context, int phase) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Center(
              child: Text(
                '$phase',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PhaseMilestones.phaseName(phase),
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  PhaseMilestones.phaseAgeRange(phase),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    WidgetRef ref,
    MilestoneCategory category,
    List<MilestoneWithProgress> milestones,
  ) {
    final completedCount = milestones.where((m) => m.isCompleted).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Icon(category.icon, color: category.color, size: 20),
            const SizedBox(width: 8),
            Text(
              category.label,
              style: AppTextStyles.titleMedium.copyWith(
                color: category.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$completedCount/${milestones.length}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: category.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...milestones.map(
          (m) => MilestoneCard(
            milestone: m,
            onToggle: () => _toggleMilestone(ref, m),
            onTap: () => _showMilestoneDetails(context, ref, m),
          ),
        ),
      ],
    );
  }

  void _toggleMilestone(WidgetRef ref, MilestoneWithProgress milestone) {
    ref.read(milestoneNotifierProvider.notifier).toggleMilestone(
          milestoneId: milestone.definition.id,
        );
  }

  void _showMilestoneDetails(
    BuildContext context,
    WidgetRef ref,
    MilestoneWithProgress milestone,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _MilestoneDetailSheet(milestone: milestone),
    );
  }
}

class _MilestoneDetailSheet extends ConsumerStatefulWidget {
  final MilestoneWithProgress milestone;

  const _MilestoneDetailSheet({required this.milestone});

  @override
  ConsumerState<_MilestoneDetailSheet> createState() =>
      _MilestoneDetailSheetState();
}

class _MilestoneDetailSheetState extends ConsumerState<_MilestoneDetailSheet> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(
      text: widget.milestone.notes ?? '',
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final definition = widget.milestone.definition;
    final isCompleted = widget.milestone.isCompleted;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textHint,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: definition.category.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            definition.category.icon,
                            size: 16,
                            color: definition.category.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            definition.category.label,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: definition.category.color,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Title
                    Text(
                      definition.title,
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    // Description
                    Text(
                      definition.description,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    // Target value if exists
                    if (definition.targetValue != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.flag, color: AppColors.primary),
                            const SizedBox(width: 12),
                            Text(
                              'Target: ${definition.targetValue}${definition.unit ?? ''}',
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Completion status
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                          color: isCompleted
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCompleted
                                ? Icons.check_circle
                                : Icons.pending_outlined,
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isCompleted ? 'Completed' : 'In Progress',
                                  style: AppTextStyles.titleMedium.copyWith(
                                    color: isCompleted
                                        ? AppColors.success
                                        : AppColors.warning,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (widget.milestone.completedAt != null)
                                  Text(
                                    'Completed on ${_formatDate(widget.milestone.completedAt!)}',
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

                    // Notes field
                    const SizedBox(height: AppSpacing.lg),
                    Text('Notes', style: AppTextStyles.labelMedium),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        hintText: 'Add notes about this milestone...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),

                    // Action buttons
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _markMilestone(context),
                            icon: Icon(
                              isCompleted
                                  ? Icons.undo
                                  : Icons.check_circle_outline,
                            ),
                            label: Text(
                              isCompleted
                                  ? 'Mark Incomplete'
                                  : 'Mark Complete',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isCompleted
                                  ? AppColors.warning
                                  : AppColors.success,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _markMilestone(BuildContext context) {
    if (widget.milestone.isCompleted) {
      ref.read(milestoneNotifierProvider.notifier).uncompleteMilestone(
            widget.milestone.definition.id,
          );
    } else {
      ref.read(milestoneNotifierProvider.notifier).completeMilestone(
            milestoneId: widget.milestone.definition.id,
            notes: _notesController.text.isNotEmpty
                ? _notesController.text
                : null,
          );
    }
    Navigator.pop(context);
  }
}
