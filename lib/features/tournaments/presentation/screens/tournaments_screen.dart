import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/tournament.dart';
import '../providers/tournament_provider.dart';

class TournamentsScreen extends ConsumerWidget {
  const TournamentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentsAsync = ref.watch(tournamentNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tournaments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Add filtering
            },
          ),
        ],
      ),
      body: tournamentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Error loading tournaments'),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(tournamentNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (tournaments) {
          if (tournaments.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildTournamentsList(context, ref, tournaments);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/tournaments/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Tournament'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 24),
            Text(
              'No Tournaments Yet',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Start tracking your competitive journey by adding your first tournament.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.push('/tournaments/add'),
              icon: const Icon(Icons.add),
              label: const Text('Add First Tournament'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentsList(
    BuildContext context,
    WidgetRef ref,
    List<Tournament> tournaments,
  ) {
    // Group tournaments by year
    final grouped = <int, List<Tournament>>{};
    for (final t in tournaments) {
      final year = t.startDate.year;
      grouped[year] ??= [];
      grouped[year]!.add(t);
    }

    final years = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(tournamentNotifierProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 100,
        ),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final yearTournaments = grouped[year]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      '$year',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${yearTournaments.length}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...yearTournaments.map((t) => _TournamentCard(tournament: t)),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class _TournamentCard extends StatelessWidget {
  final Tournament tournament;

  const _TournamentCard({required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        margin: EdgeInsets.zero,
        onTap: () => context.push('/tournaments/${tournament.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournament.name,
                        style: AppTextStyles.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              tournament.courseName,
                              style: AppTextStyles.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Type badge
                if (tournament.tournamentType != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(tournament.tournamentType!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tournament.typeDisplay,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            // Stats row
            Row(
              children: [
                // Date
                _StatItem(
                  icon: Icons.calendar_today_outlined,
                  value: DateFormat('dd MMM').format(tournament.startDate),
                ),
                const SizedBox(width: 16),
                // Score
                if (tournament.totalScore != null)
                  _StatItem(
                    icon: Icons.golf_course_outlined,
                    value: tournament.scoreDisplay,
                    valueColor: _getScoreColor(tournament.scoreToPar),
                  ),
                const Spacer(),
                // Add Round button
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
                  tooltip: 'Add Round',
                  onPressed: () => _navigateToAddRound(context, tournament),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                // Position
                if (tournament.position != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getPositionColor(tournament.position!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tournament.positionDisplay,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'local':
        return AppColors.textSecondary;
      case 'regional':
        return AppColors.info;
      case 'state':
        return AppColors.primary;
      case 'national':
        return AppColors.secondary;
      case 'international':
        return AppColors.accent;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getScoreColor(int? scoreToPar) {
    if (scoreToPar == null) return AppColors.textPrimary;
    if (scoreToPar < -2) return AppColors.eagle;
    if (scoreToPar < 0) return AppColors.birdie;
    if (scoreToPar == 0) return AppColors.par;
    if (scoreToPar <= 5) return AppColors.bogey;
    return AppColors.doubleBogey;
  }

  Color _getPositionColor(int position) {
    if (position == 1) return AppColors.accent;
    if (position <= 3) return AppColors.primary;
    if (position <= 10) return AppColors.secondary;
    return AppColors.textSecondary;
  }

  void _navigateToAddRound(BuildContext context, Tournament tournament) {
    context.push(
      AppRoutes.addRound,
      extra: {
        'tournamentId': tournament.id,
        'tournamentName': tournament.name,
        'courseName': tournament.courseName,
        'coursePar': tournament.coursePar,
        'courseSlope': tournament.courseSlope,
        'courseRating': tournament.courseRating,
        'roundNumber': 1, // This should ideally fetch existing rounds count
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? valueColor;

  const _StatItem({
    required this.icon,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyles.labelMedium.copyWith(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
