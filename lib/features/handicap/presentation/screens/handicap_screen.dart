import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/presentation/providers/player_provider.dart';
import '../../../tournaments/data/tournament_repository.dart';
import '../../../tournaments/domain/tournament.dart';
import '../../domain/handicap_entry.dart';
import '../providers/handicap_provider.dart';
import '../widgets/add_handicap_dialog.dart';
import '../widgets/ga_connect_dialog.dart';

/// Handicap tracking screen with GA CONNECT sync
class HandicapScreen extends ConsumerStatefulWidget {
  const HandicapScreen({super.key});

  @override
  ConsumerState<HandicapScreen> createState() => _HandicapScreenState();
}

class _HandicapScreenState extends ConsumerState<HandicapScreen> {
  @override
  void initState() {
    super.initState();
    // Load handicap data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(handicapNotifierProvider.notifier).loadHandicapData();
    });
  }

  void _showAddHandicapDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddHandicapDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(currentPlayerProvider).value;
    final currentHandicap = ref.watch(currentHandicapProvider);
    final handicapTrend = ref.watch(handicapTrendProvider);
    final lowestHandicap = ref.watch(lowestHandicapProvider);
    final handicapChange = ref.watch(handicapChangeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Handicap'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddHandicapDialog,
            tooltip: 'Add Handicap Entry',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(currentHandicapProvider);
              ref.invalidate(handicapHistoryProvider);
              ref.invalidate(handicapTrendProvider);
              _showSyncDialog(context);
            },
            tooltip: 'Sync with GA CONNECT',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentHandicapProvider);
          ref.invalidate(handicapHistoryProvider);
          ref.invalidate(handicapTrendProvider);
          ref.invalidate(lowestHandicapProvider);
          ref.invalidate(handicapChangeProvider);
        },
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current handicap card
              _buildCurrentHandicap(
                context,
                player?.currentHandicap,
                currentHandicap.value,
                lowestHandicap.value,
                handicapChange.value,
              ),
              const SizedBox(height: 24),

              // Handicap trend chart
              Text('Handicap Trend', style: AppTextStyles.titleLarge),
              const SizedBox(height: 12),
              _buildTrendChart(context, handicapTrend.value ?? []),
              const SizedBox(height: 24),

              // Target progress
              Text('Target Progress', style: AppTextStyles.titleLarge),
              const SizedBox(height: 12),
              _buildTargetProgress(context, player?.currentHandicap, player?.currentPhase ?? 1),
              const SizedBox(height: 24),

              // Recent scores
              Text('Recent Scores', style: AppTextStyles.titleLarge),
              const SizedBox(height: 12),
              _buildRecentScores(context),
              const SizedBox(height: 24),

              // Handicap history
              Text('Handicap History', style: AppTextStyles.titleLarge),
              const SizedBox(height: 12),
              _buildHandicapHistory(context),
              const SizedBox(height: 24),

              // GA CONNECT status
              _buildGAConnectStatus(context, player?.gaConnected ?? false, player?.gaLastSync),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentHandicap(
    BuildContext context,
    double? currentHandicapValue,
    HandicapEntry? latestEntry,
    double? lowestHandicap,
    double? monthlyChange,
  ) {
    final displayHandicap = currentHandicapValue ?? latestEntry?.handicapIndex;
    final roundsCounted = latestEntry?.roundsCounted;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current GA Handicap',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayHandicap?.toStringAsFixed(1) ?? 'N/A',
                    style: AppTextStyles.handicap.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (monthlyChange != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        monthlyChange <= 0 ? Icons.trending_down : Icons.trending_up,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        monthlyChange <= 0
                            ? monthlyChange.toStringAsFixed(1)
                            : '+${monthlyChange.toStringAsFixed(1)}',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'This month',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HandicapStat(
                label: 'Low Index',
                value: lowestHandicap?.toStringAsFixed(1) ?? '-',
              ),
              _HandicapStat(
                label: 'Rounds Used',
                value: roundsCounted != null ? '$roundsCounted/20' : '-',
              ),
              _HandicapStat(
                label: 'Last Updated',
                value: latestEntry != null
                    ? _formatDate(latestEntry.effectiveDate)
                    : '-',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMM').format(date);
    }
  }

  Widget _buildTrendChart(BuildContext context, List<HandicapEntry> trendData) {
    if (trendData.isEmpty) {
      return AppCard(
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart, size: 48, color: AppColors.textHint),
                const SizedBox(height: 8),
                Text(
                  'No handicap history yet',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Add your first handicap entry to see trends',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Prepare chart data
    final spots = <FlSpot>[];
    final dates = <String>[];
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var i = 0; i < trendData.length; i++) {
      final entry = trendData[i];
      spots.add(FlSpot(i.toDouble(), entry.handicapIndex));
      dates.add(DateFormat('MMM').format(entry.effectiveDate));
      if (entry.handicapIndex < minY) minY = entry.handicapIndex;
      if (entry.handicapIndex > maxY) maxY = entry.handicapIndex;
    }

    // Add padding to Y range
    final yPadding = (maxY - minY) * 0.2;
    minY = (minY - yPadding).clamp(0, double.infinity);
    maxY = maxY + yPadding;

    // Calculate target line based on current phase
    final player = ref.watch(currentPlayerProvider).value;
    final targetHandicap = D1Benchmarks.handicapByPhase[player?.currentPhase ?? 1] ?? 18.0;

    return AppCard(
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 5,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: AppColors.textHint.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < dates.length) {
                      // Only show every other label if there are many entries
                      if (trendData.length > 6 && index % 2 != 0) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          dates[index],
                          style: AppTextStyles.labelSmall,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: AppTextStyles.labelSmall,
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: (spots.length - 1).toDouble().clamp(0, double.infinity),
            minY: minY,
            maxY: maxY,
            lineBarsData: [
              // Actual handicap line
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: AppColors.primary,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: AppColors.primary,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.primary.withOpacity(0.1),
                ),
              ),
              // Target line
              if (targetHandicap >= minY && targetHandicap <= maxY)
                LineChartBarData(
                  spots: [
                    FlSpot(0, targetHandicap),
                    FlSpot((spots.length - 1).toDouble().clamp(0, double.infinity), targetHandicap),
                  ],
                  isCurved: false,
                  color: AppColors.accent,
                  barWidth: 2,
                  dashArray: [5, 5],
                  dotData: const FlDotData(show: false),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTargetProgress(BuildContext context, double? currentHandicap, int currentPhase) {
    final targetHandicap = D1Benchmarks.handicapByPhase[currentPhase] ?? 18.0;
    final phaseName = DevelopmentPhase.getPhase(currentPhase).name;

    if (currentHandicap == null) {
      return AppCard(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text('Phase $currentPhase: $phaseName', style: AppTextStyles.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Add a handicap to track progress toward ${targetHandicap.toStringAsFixed(1)}',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      );
    }

    // Calculate progress (inverse because lower is better)
    final previousTarget = currentPhase > 1
        ? D1Benchmarks.handicapByPhase[currentPhase - 1] ?? 36.0
        : 54.0;
    final totalRange = previousTarget - targetHandicap;
    final progress = ((previousTarget - currentHandicap) / totalRange).clamp(0.0, 1.0);
    final remaining = currentHandicap - targetHandicap;
    final reachedTarget = remaining <= 0;

    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Phase $currentPhase: $phaseName Target', style: AppTextStyles.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Reach handicap ${targetHandicap.toStringAsFixed(1)}',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current: ${currentHandicap.toStringAsFixed(1)}',
                          style: AppTextStyles.labelMedium,
                        ),
                        Text(
                          'Target: ${targetHandicap.toStringAsFixed(1)}',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: reachedTarget
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  children: [
                    Text(
                      reachedTarget ? '0' : remaining.toStringAsFixed(1),
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: reachedTarget ? AppColors.success : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      reachedTarget ? 'Done!' : 'to go',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: reachedTarget ? AppColors.success : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentScores(BuildContext context) {
    final player = ref.watch(currentPlayerProvider).value;
    if (player == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<List<Round>>(
      future: TournamentRepository().getRoundsForPlayer(player.id, limit: 5),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final rounds = snapshot.data ?? [];
        if (rounds.isEmpty) {
          return AppCard(
            margin: EdgeInsets.zero,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    Icon(Icons.golf_course, size: 48, color: AppColors.textHint),
                    const SizedBox(height: 8),
                    Text(
                      'No rounds recorded yet',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Column(
          children: rounds.map((round) {
            final isUsed = round.isCountedForHandicap;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                margin: EdgeInsets.zero,
                backgroundColor: isUsed ? null : AppColors.surfaceVariant,
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isUsed
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.textHint.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Center(
                        child: Text(
                          round.grossScore.toString(),
                          style: AppTextStyles.titleLarge.copyWith(
                            color: isUsed ? AppColors.primary : AppColors.textSecondary,
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
                            round.courseName ?? 'Unknown Course',
                            style: AppTextStyles.titleSmall,
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(round.roundDate),
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (round.differential != null)
                          Text(
                            'Diff: ${round.differential!.toStringAsFixed(1)}',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isUsed ? AppColors.primary : AppColors.textSecondary,
                            ),
                          ),
                        if (isUsed)
                          Text(
                            'Used',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildHandicapHistory(BuildContext context) {
    final historyAsync = ref.watch(handicapHistoryProvider);

    return historyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => AppCard(
        margin: EdgeInsets.zero,
        child: Text('Error loading history: $e'),
      ),
      data: (history) {
        if (history.isEmpty) {
          return AppCard(
            margin: EdgeInsets.zero,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    Icon(Icons.history, size: 48, color: AppColors.textHint),
                    const SizedBox(height: 8),
                    Text(
                      'No history yet',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextButton.icon(
                      onPressed: _showAddHandicapDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Add First Entry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Show only last 5 entries
        final recentHistory = history.take(5).toList();

        return Column(
          children: recentHistory.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Center(
                        child: Text(
                          entry.handicapIndex.toStringAsFixed(1),
                          style: AppTextStyles.titleMedium.copyWith(
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
                            DateFormat('dd MMM yyyy').format(entry.effectiveDate),
                            style: AppTextStyles.titleSmall,
                          ),
                          Text(
                            entry.sourceDisplay,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (entry.roundsCounted != null)
                      Text(
                        '${entry.roundsCounted} rounds',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildGAConnectStatus(BuildContext context, bool isConnected, DateTime? lastSync) {
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isConnected
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  isConnected ? Icons.cloud_done : Icons.cloud_off,
                  color: isConnected ? AppColors.success : AppColors.warning,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isConnected ? 'GA CONNECT Linked' : 'GA CONNECT Not Linked',
                      style: AppTextStyles.titleMedium,
                    ),
                    Text(
                      isConnected && lastSync != null
                          ? 'Last synced: ${DateFormat('dd MMM, h:mm a').format(lastSync)}'
                          : 'Sync your official GA handicap',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => _showSyncDialog(context),
                child: Text(isConnected ? 'Sync Now' : 'Connect'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSyncDialog(BuildContext context) {
    final player = ref.read(currentPlayerProvider).value;
    final isConnected = player?.gaConnected ?? false;

    if (!isConnected) {
      // Show connect dialog if not connected
      showDialog(
        context: context,
        builder: (context) => const GAConnectDialog(),
      );
    } else {
      // Show sync confirmation if already connected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sync with GA CONNECT'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('GA Number: ${player?.gaNumber ?? "N/A"}'),
              const SizedBox(height: 8),
              const Text(
                'Update your handicap from Golf Australia?',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Auto-sync from golf.com.au coming soon!',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Open GA Connect dialog to manually update
                showDialog(
                  context: context,
                  builder: (context) => const GAConnectDialog(),
                );
              },
              child: const Text('Update Manually'),
            ),
          ],
        ),
      );
    }
  }
}

class _HandicapStat extends StatelessWidget {
  final String label;
  final String value;

  const _HandicapStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
