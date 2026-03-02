import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router.dart';
import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/tournament.dart';
import '../providers/tournament_provider.dart';
import '../../../media/presentation/providers/media_provider.dart';
import '../../../media/presentation/widgets/media_grid.dart';
import '../../../media/presentation/screens/media_gallery_screen.dart';

class TournamentDetailScreen extends ConsumerWidget {
  final String tournamentId;

  const TournamentDetailScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentWithStatsAsync = ref.watch(tournamentWithStatsProvider(tournamentId));

    return tournamentWithStatsAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Tournament Details')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Tournament Details')),
        body: Center(child: Text('Error: $error')),
      ),
      data: (tournamentWithStats) {
        if (tournamentWithStats == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Tournament Details')),
            body: const Center(child: Text('Tournament not found')),
          );
        }

        final tournament = tournamentWithStats.tournament;
        final rounds = tournamentWithStats.rounds;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tournament Details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  // TODO: Edit tournament
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showOptionsMenu(context, ref, tournament),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, tournamentWithStats),
                const SizedBox(height: 24),
                _buildResultSummary(context, tournamentWithStats),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rounds (${rounds.length})', style: AppTextStyles.titleLarge),
                    TextButton.icon(
                      onPressed: () => _navigateToAddRound(context, ref, tournament, rounds.length),
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Add Round'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildRoundsList(context, ref, tournament, rounds),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Media', style: AppTextStyles.titleLarge),
                    TextButton.icon(
                      onPressed: () => _openMediaGallery(context, tournament),
                      icon: const Icon(Icons.photo_library_outlined, size: 20),
                      label: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMediaSection(context, ref, tournament),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, TournamentWithStats stats) {
    final tournament = stats.tournament;
    // Use calculated values from rounds if available
    final courseName = stats.courseName;
    final startDate = stats.startDate;
    final endDate = stats.endDate;
    final isMultiDay = stats.isMultiDay;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                tournament.name,
                style: AppTextStyles.headlineMedium,
              ),
            ),
            if (tournament.tournamentType != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.golf_course_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                courseName,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        if (tournament.courseCity != null || tournament.courseState != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                [tournament.courseCity, tournament.courseState]
                    .where((e) => e != null)
                    .join(', '),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              isMultiDay
                  ? '${DateFormat('MMM d').format(startDate)} - ${DateFormat('MMM d, yyyy').format(endDate!)}'
                  : DateFormat('MMMM d, yyyy').format(startDate),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (tournament.notes != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.notes, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tournament.notes!,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
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

  Widget _buildResultSummary(BuildContext context, TournamentWithStats stats) {
    final tournament = stats.tournament;
    // Use calculated values from rounds
    final totalScore = stats.totalScore;
    final scoreToPar = stats.scoreToPar;
    final totalPar = stats.totalPar;
    final roundCount = stats.roundCount;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ResultStat(
              label: 'Position',
              value: tournament.position != null ? '${tournament.position}${_ordinalSuffix(tournament.position!)}' : '-',
              subtitle: tournament.fieldSize != null ? 'of ${tournament.fieldSize} players' : '',
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: AppColors.primaryLight.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _ResultStat(
              label: 'Score',
              value: totalScore?.toString() ?? '-',
              subtitle: scoreToPar != null
                  ? (scoreToPar == 0
                      ? 'Even'
                      : scoreToPar > 0
                          ? '+$scoreToPar'
                          : '$scoreToPar')
                  : '',
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: AppColors.primaryLight.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _ResultStat(
              label: roundCount > 1 ? 'Total Par' : 'Course Par',
              value: totalPar?.toString() ?? '-',
              subtitle: roundCount > 1 ? '($roundCount rounds)' : '',
            ),
          ),
        ],
      ),
    );
  }

  String _ordinalSuffix(int n) {
    if (n >= 11 && n <= 13) return 'th';
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Widget _buildRoundsList(BuildContext context, WidgetRef ref, Tournament tournament, List<Round> rounds) {
    if (rounds.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.sports_golf, size: 40, color: AppColors.textHint),
              const SizedBox(height: 8),
              Text(
                'No rounds recorded',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => _navigateToAddRound(context, ref, tournament, 0),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Round 1'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: rounds.map((round) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _RoundCard(
          round: round,
          onTap: () => context.push('/scorecard/${round.id}'),
        ),
      )).toList(),
    );
  }

  void _navigateToAddRound(BuildContext context, WidgetRef ref, Tournament tournament, int existingRoundsCount) {
    context.push<bool>(
      AppRoutes.addRound,
      extra: {
        'tournamentId': tournament.id,
        'tournamentName': tournament.name,
        'courseName': tournament.courseName,
        'coursePar': tournament.coursePar,
        'courseSlope': tournament.courseSlope,
        'courseRating': tournament.courseRating,
        'roundNumber': existingRoundsCount + 1,
      },
    ).then((result) {
      if (result == true) {
        // Refresh the tournament with stats (which includes rounds)
        ref.invalidate(tournamentWithStatsProvider(tournament.id));
        ref.invalidate(tournamentRoundsProvider(tournament.id));
      }
    });
  }

  Widget _buildMediaSection(BuildContext context, WidgetRef ref, Tournament tournament) {
    final mediaAsync = ref.watch(tournamentMediaProvider(tournament.id));

    return mediaAsync.when(
      loading: () => Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error),
              const SizedBox(height: 8),
              Text('Error loading media', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ),
      data: (mediaItems) {
        if (mediaItems.isEmpty) {
          return GestureDetector(
            onTap: () => _openMediaGallery(context, tournament),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.textHint,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32,
                      color: AppColors.textHint,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No photos or videos yet',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to add media',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Show first 6 items as a preview grid
        final previewItems = mediaItems.take(6).toList();

        return Column(
          children: [
            GestureDetector(
              onTap: () => _openMediaGallery(context, tournament),
              child: MediaGrid(
                items: previewItems,
                crossAxisCount: 3,
                spacing: 4,
                onTap: (item) => _openMediaGallery(context, tournament),
              ),
            ),
            if (mediaItems.length > 6) ...[
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () => _openMediaGallery(context, tournament),
                  child: Text(
                    'View all ${mediaItems.length} items',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _openMediaGallery(BuildContext context, Tournament tournament) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaGalleryScreen(
          tournamentId: tournament.id,
          title: '${tournament.name} Media',
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, WidgetRef ref, Tournament tournament) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Share tournament
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text('Delete', style: TextStyle(color: AppColors.error)),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Tournament?'),
                    content: Text('Are you sure you want to delete "${tournament.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(foregroundColor: AppColors.error),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  await ref.read(tournamentNotifierProvider.notifier).deleteTournament(tournament.id);
                  if (context.mounted) {
                    context.pop();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;

  const _ResultStat({
    required this.label,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.labelSmall,
          ),
        ],
      ],
    );
  }
}

class _RoundCard extends StatelessWidget {
  final Round round;
  final VoidCallback? onTap;

  const _RoundCard({required this.round, this.onTap});

  @override
  Widget build(BuildContext context) {
    final toPar = round.coursePar != null
        ? round.grossScore - round.coursePar!
        : null;

    String toParStr = '-';
    if (toPar != null) {
      if (toPar == 0) {
        toParStr = 'E';
      } else if (toPar > 0) {
        toParStr = '+$toPar';
      } else {
        toParStr = '$toPar';
      }
    }

    // Calculate net score display
    final netScore = round.calculatedNetScore;
    final netToPar = netScore != null && round.coursePar != null
        ? netScore - round.coursePar!
        : null;

    return AppCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Center(
                  child: Text(
                    'R${round.roundNumber}',
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Round ${round.roundNumber} · ${DateFormat('MMM d').format(round.roundDate)}',
                      style: AppTextStyles.titleMedium,
                    ),
                    if (round.courseName != null)
                      Text(
                        round.courseName!,
                        style: AppTextStyles.bodySmall,
                      ),
                    if (round.playingHandicap != null)
                      Text(
                        'HCP ${round.handicapDisplay}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
              ),
              // Scores column - show Gross and Net
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Gross Score
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Gross',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            round.grossScore.toString(),
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            toParStr,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: _getToParColor(toPar),
                            ),
                          ),
                        ],
                      ),
                      // Net Score (if handicap recorded)
                      if (netScore != null) ...[
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.textHint.withValues(alpha: 0.3),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Net',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              netScore.toString(),
                              style: AppTextStyles.titleLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                              ),
                            ),
                            Text(
                              _toParString(netToPar),
                              style: AppTextStyles.labelSmall.copyWith(
                                color: _getToParColor(netToPar),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (round.fairwaysHit != null || round.greensInRegulation != null || round.putts != null) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (round.firPercentage != null)
                  _StatColumn(label: 'FIR', value: '${round.firPercentage!.toStringAsFixed(0)}%'),
                if (round.girPercentage != null)
                  _StatColumn(label: 'GIR', value: '${round.girPercentage!.toStringAsFixed(0)}%'),
                if (round.putts != null)
                  _StatColumn(label: 'Putts', value: '${round.putts}'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _toParString(int? toPar) {
    if (toPar == null) return '-';
    if (toPar == 0) return 'E';
    if (toPar > 0) return '+$toPar';
    return '$toPar';
  }

  Color _getToParColor(int? toPar) {
    if (toPar == null) return AppColors.textSecondary;
    if (toPar < 0) return AppColors.birdie;
    if (toPar == 0) return AppColors.par;
    return AppColors.bogey;
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.titleSmall,
        ),
      ],
    );
  }
}
