import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router.dart';
import '../../../../app/theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/player_provider.dart';
import '../../../auth/domain/player.dart';
import '../../../tournaments/presentation/providers/tournament_provider.dart';
import '../../../tournaments/domain/tournament.dart';

/// Main dashboard screen showing overview of player's progress
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(playerNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('D1 Golf Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => _showProfileMenu(context, ref),
          ),
        ],
      ),
      body: playerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (player) {
          if (player == null) {
            return const Center(child: Text('No player profile found'));
          }
          return _buildDashboardContent(context, ref, player);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOptions(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Round'),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, WidgetRef ref, Player player) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(playerNotifierProvider);
        ref.invalidate(tournamentCountProvider);
        ref.invalidate(bestFinishProvider);
        ref.invalidate(recentTournamentsProvider);
      },
      child: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Player header
            _buildPlayerHeader(context, player),
            const SizedBox(height: 24),

            // Current phase card
            _buildPhaseCard(context, player),
            const SizedBox(height: 24),

            // Quick stats row
            _buildQuickStats(context, ref, player),
            const SizedBox(height: 24),

            // Recent activity section
            _buildSectionHeader(context, 'Recent Activity', onSeeAll: () {
              context.go(AppRoutes.tournaments);
            }),
            const SizedBox(height: 12),
            _buildRecentActivity(context, ref),
            const SizedBox(height: 24),

            // Upcoming milestones section
            _buildSectionHeader(context, 'Upcoming Milestones'),
            const SizedBox(height: 12),
            _buildUpcomingMilestones(context, player),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerHeader(BuildContext context, Player player) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 32,
          backgroundColor: AppColors.primary,
          backgroundImage: player.avatarUrl != null
              ? NetworkImage(player.avatarUrl!)
              : null,
          child: player.avatarUrl == null
              ? Text(
                  '${player.firstName[0]}${player.lastName[0]}',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 16),
        // Player info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.fullName,
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getPhaseColor(player.currentPhase).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      'Phase ${player.currentPhase}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: _getPhaseColor(player.currentPhase),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${player.phaseName} · Age ${player.age}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPhaseColor(int phase) {
    switch (phase) {
      case 1:
        return AppColors.phase1;
      case 2:
        return AppColors.phase2;
      case 3:
        return AppColors.phase3;
      case 4:
        return AppColors.phase4;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildPhaseCard(BuildContext context, Player player) {
    final phase = DevelopmentPhase.getPhase(player.currentPhase);
    final progress = _calculatePhaseProgress(player);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_getPhaseColor(player.currentPhase), _getPhaseColor(player.currentPhase).withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppRadius.round),
                ),
                child: Text(
                  'PHASE ${phase.number}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Age ${phase.ageRange}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            phase.name,
            style: AppTextStyles.headlineLarge.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            phase.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          // Progress bar
          if (player.currentPhase < 4) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress to Phase ${phase.number + 1}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Final phase - D1 ready!',
                    style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  double _calculatePhaseProgress(Player player) {
    if (player.currentHandicap == null) return 0.0;

    final currentPhase = DevelopmentPhase.getPhase(player.currentPhase);
    final nextPhase = player.currentPhase < 4
        ? DevelopmentPhase.getPhase(player.currentPhase + 1)
        : null;

    if (nextPhase == null) return 1.0;

    final startHandicap = currentPhase.targetHandicap;
    final targetHandicap = nextPhase.targetHandicap;
    final currentHandicap = player.currentHandicap!;

    if (currentHandicap >= startHandicap) return 0.0;
    if (currentHandicap <= targetHandicap) return 1.0;

    return (startHandicap - currentHandicap) / (startHandicap - targetHandicap);
  }

  Widget _buildQuickStats(BuildContext context, WidgetRef ref, Player player) {
    final tournamentCountAsync = ref.watch(tournamentCountProvider);
    final bestFinishAsync = ref.watch(bestFinishProvider);

    return Row(
      children: [
        Expanded(
          child: _StatTile(
            label: 'Handicap',
            value: player.handicapDisplay,
            icon: Icons.golf_course,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            label: 'Tournaments',
            value: tournamentCountAsync.when(
              loading: () => '-',
              error: (_, __) => '-',
              data: (count) => count.toString(),
            ),
            icon: Icons.emoji_events,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            label: 'Best Finish',
            value: bestFinishAsync.when(
              loading: () => '-',
              error: (_, __) => '-',
              data: (finish) => finish != null ? _ordinalSuffix(finish) : '-',
            ),
            icon: Icons.military_tech,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  String _ordinalSuffix(int n) {
    if (n >= 11 && n <= 13) return '${n}th';
    switch (n % 10) {
      case 1:
        return '${n}st';
      case 2:
        return '${n}nd';
      case 3:
        return '${n}rd';
      default:
        return '${n}th';
    }
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleLarge),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: const Text('See All'),
          ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context, WidgetRef ref) {
    final recentTournamentsAsync = ref.watch(recentTournamentsProvider);

    return recentTournamentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => AppCard(
        margin: EdgeInsets.zero,
        child: Text('Error loading tournaments: $e'),
      ),
      data: (tournaments) {
        if (tournaments.isEmpty) {
          return AppCard(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.textSecondary, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No tournaments recorded yet. Tap "Add Round" to log your first tournament!',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return Column(
          children: tournaments.map((tournament) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _RecentTournamentCard(tournament: tournament),
          )).toList(),
        );
      },
    );
  }

  Widget _buildUpcomingMilestones(BuildContext context, Player player) {
    final phase = DevelopmentPhase.getPhase(player.currentPhase);
    final targetHandicap = phase.targetHandicap;

    return Column(
      children: [
        _MilestoneTile(
          title: 'Reach handicap ${targetHandicap.toStringAsFixed(0)}',
          progress: player.currentHandicap != null
              ? (36 - player.currentHandicap!) / (36 - targetHandicap)
              : 0,
          target: player.currentHandicap != null
              ? 'Current: ${player.handicapDisplay}'
              : 'No handicap recorded',
        ),
        const SizedBox(height: 8),
        _MilestoneTile(
          title: 'Complete ${player.currentPhase < 4 ? "Phase ${player.currentPhase}" : "D1 Journey"}',
          progress: _calculatePhaseProgress(player),
          target: 'Age range: ${phase.ageRange}',
        ),
      ],
    );
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text('Sign Out', style: TextStyle(color: AppColors.error)),
              onTap: () async {
                Navigator.pop(context);
                await ref.read(authControllerProvider.notifier).signOut();
                ref.read(playerNotifierProvider.notifier).clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.emoji_events_outlined, color: AppColors.primary),
              title: const Text('Tournament Round'),
              subtitle: const Text('Add a round for an existing tournament'),
              onTap: () {
                Navigator.pop(context);
                context.push('/tournaments');
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_golf_outlined, color: AppColors.primary),
              title: const Text('Practice Round'),
              subtitle: const Text('Log a casual or practice round'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.addRound);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline, color: AppColors.secondary),
              title: const Text('New Tournament'),
              subtitle: const Text('Create a new tournament'),
              onTap: () {
                Navigator.pop(context);
                context.push('/tournaments/add');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headlineSmall.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  final String title;
  final double progress;
  final String target;

  const _MilestoneTile({
    required this.title,
    required this.progress,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag_outlined, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: AppTextStyles.titleMedium)),
              Text(
                '${(clampedProgress * 100).toInt()}%',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: clampedProgress,
            backgroundColor: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 4),
          Text(target, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _RecentTournamentCard extends StatelessWidget {
  final Tournament tournament;

  const _RecentTournamentCard({required this.tournament});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.zero,
      onTap: () => context.push('/tournaments/${tournament.id}'),
      child: Row(
        children: [
          // Tournament icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.emoji_events_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Tournament details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tournament.name,
                  style: AppTextStyles.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${tournament.courseName} · ${DateFormat('dd MMM').format(tournament.startDate)}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Score and position
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (tournament.totalScore != null)
                Text(
                  tournament.scoreDisplay,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: _getScoreColor(tournament.scoreToPar),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (tournament.position != null)
                Text(
                  tournament.positionDisplay,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int? scoreToPar) {
    if (scoreToPar == null) return AppColors.textPrimary;
    if (scoreToPar < -2) return AppColors.eagle;
    if (scoreToPar < 0) return AppColors.birdie;
    if (scoreToPar == 0) return AppColors.par;
    if (scoreToPar <= 5) return AppColors.bogey;
    return AppColors.doubleBogey;
  }
}
