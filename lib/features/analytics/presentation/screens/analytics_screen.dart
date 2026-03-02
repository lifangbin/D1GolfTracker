import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../app/theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/app_card.dart';

/// Analytics screen showing performance stats and elite benchmarks
class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Scoring'),
            Tab(text: 'Short Game'),
            Tab(text: 'Ball Striking'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScoringTab(),
          _buildShortGameTab(),
          _buildBallStrikingTab(),
        ],
      ),
    );
  }

  Widget _buildScoringTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scoring average card
          _buildScoringAverageCard(),
          const SizedBox(height: 24),

          // Score distribution
          Text('Score Distribution', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          _buildScoreDistributionChart(),
          const SizedBox(height: 24),

          // Par performance
          Text('Scoring by Par', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          _buildParPerformance(),
          const SizedBox(height: 24),

          // Elite Benchmarks
          Text('Elite Benchmarks', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          _buildEliteBenchmarks(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildShortGameTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Putting stats
          Text('Putting', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Putts/Round',
                  value: '31.5',
                  target: EliteBenchmarks.puttsPerRound.toString(),
                  isGood: 31.5 <= EliteBenchmarks.puttsPerRound,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: '1-Putt %',
                  value: '32%',
                  target: '${EliteBenchmarks.onePuttPercent.toInt()}%',
                  isGood: 32 >= EliteBenchmarks.onePuttPercent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: '3-Putt %',
                  value: '4.5%',
                  target: '${EliteBenchmarks.threePuttPercent}%',
                  isGood: 4.5 <= EliteBenchmarks.threePuttPercent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Putts/GIR',
                  value: '1.85',
                  target: '1.80',
                  isGood: 1.85 <= 1.80,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Scrambling stats
          Text('Scrambling', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Up & Down %',
                  value: '48%',
                  target: '${EliteBenchmarks.upAndDownPercent.toInt()}%',
                  isGood: 48 >= EliteBenchmarks.upAndDownPercent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Sand Save %',
                  value: '38%',
                  target: '${EliteBenchmarks.sandSavePercent.toInt()}%',
                  isGood: 38 >= EliteBenchmarks.sandSavePercent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Trend chart
          Text('Short Game Trend', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          _buildShortGameTrendChart(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildBallStrikingTab() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FIR and GIR
          Text('Accuracy', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildRadialStat(
                  label: 'FIR',
                  value: 62,
                  target: EliteBenchmarks.firPercent.toInt(),
                  subtitle: 'Fairways in Reg',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildRadialStat(
                  label: 'GIR',
                  value: 52,
                  target: EliteBenchmarks.girPercent.toInt(),
                  subtitle: 'Greens in Reg',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Par 5 performance
          Text('Par 5 Scoring', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Birdie Rate',
                  value: '22%',
                  target: '${EliteBenchmarks.par5BirdieRate.toInt()}%',
                  isGood: 22 >= EliteBenchmarks.par5BirdieRate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Avg Score',
                  value: '5.3',
                  target: '${EliteBenchmarks.par5Average}',
                  isGood: 5.3 <= EliteBenchmarks.par5Average,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Driving stats
          Text('Driving', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          AppCard(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                _buildDrivingStat('Average Distance', '185 yds', Icons.straighten),
                const Divider(height: 24),
                _buildDrivingStat('Longest Drive', '215 yds', Icons.bolt),
                const Divider(height: 24),
                _buildDrivingStat('Fairways Hit', '9/14', Icons.golf_course),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Trend
          Text('Ball Striking Trend', style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          _buildBallStrikingTrendChart(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildScoringAverageCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.secondaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scoring Average',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '76.8',
                  style: AppTextStyles.handicap.copyWith(
                    color: Colors.white,
                    fontSize: 42,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '+4.8 to par average',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _miniStat('Best', '72'),
              const SizedBox(height: 8),
              _miniStat('Worst', '84'),
              const SizedBox(height: 8),
              _miniStat('Rounds', '12'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(width: 8),
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

  Widget _buildScoreDistributionChart() {
    return AppCard(
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 180,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 10,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final labels = ['Eagle', 'Birdie', 'Par', 'Bogey', '2+'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        labels[value.toInt()],
                        style: AppTextStyles.labelSmall,
                      ),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            barGroups: [
              _makeBarGroup(0, 0.5, AppColors.eagle),
              _makeBarGroup(1, 2.5, AppColors.birdie),
              _makeBarGroup(2, 8, AppColors.par),
              _makeBarGroup(3, 5, AppColors.bogey),
              _makeBarGroup(4, 2, AppColors.doubleBogey),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 32,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildParPerformance() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Par 3 Avg',
            value: '3.4',
            target: '${EliteBenchmarks.par3Average}',
            isGood: 3.4 <= EliteBenchmarks.par3Average,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Par 4 Avg',
            value: '4.5',
            target: '${EliteBenchmarks.par4Average}',
            isGood: 4.5 <= EliteBenchmarks.par4Average,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Par 5 Avg',
            value: '5.3',
            target: '${EliteBenchmarks.par5Average}',
            isGood: 5.3 <= EliteBenchmarks.par5Average,
          ),
        ),
      ],
    );
  }

  Widget _buildEliteBenchmarks() {
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          _buildBenchmarkRow(
            'Scoring Average',
            '76.8',
            '${EliteBenchmarks.scoringAverage}',
            76.8 <= EliteBenchmarks.scoringAverage,
          ),
          const Divider(height: 16),
          _buildBenchmarkRow(
            'Putts per Round',
            '31.5',
            '${EliteBenchmarks.puttsPerRound}',
            31.5 <= EliteBenchmarks.puttsPerRound,
          ),
          const Divider(height: 16),
          _buildBenchmarkRow(
            'GIR %',
            '52%',
            '${EliteBenchmarks.girPercent.toInt()}%',
            52 >= EliteBenchmarks.girPercent,
          ),
          const Divider(height: 16),
          _buildBenchmarkRow(
            'FIR %',
            '62%',
            '${EliteBenchmarks.firPercent.toInt()}%',
            62 >= EliteBenchmarks.firPercent,
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkRow(
    String label,
    String current,
    String target,
    bool isGood,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: AppTextStyles.bodyMedium),
        ),
        Expanded(
          child: Text(
            current,
            style: AppTextStyles.titleMedium.copyWith(
              color: isGood ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isGood ? Icons.check_circle : Icons.cancel,
                color: isGood ? AppColors.success : AppColors.error,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                target,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadialStat({
    required String label,
    required int value,
    required int target,
    required String subtitle,
  }) {
    final isGood = value >= target;
    final progress = value / 100;

    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: AppColors.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation(
                        isGood ? AppColors.success : AppColors.warning,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '$value%',
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.titleMedium),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            'Target: $target%',
            style: AppTextStyles.labelSmall.copyWith(
              color: isGood ? AppColors.success : AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrivingStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildShortGameTrendChart() {
    return AppCard(
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 180,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 42),
                  FlSpot(1, 45),
                  FlSpot(2, 44),
                  FlSpot(3, 48),
                  FlSpot(4, 46),
                  FlSpot(5, 48),
                ],
                isCurved: true,
                color: AppColors.primary,
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBallStrikingTrendChart() {
    return AppCard(
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 180,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              // FIR line
              LineChartBarData(
                spots: const [
                  FlSpot(0, 58),
                  FlSpot(1, 55),
                  FlSpot(2, 60),
                  FlSpot(3, 62),
                  FlSpot(4, 58),
                  FlSpot(5, 62),
                ],
                isCurved: true,
                color: AppColors.primary,
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
              // GIR line
              LineChartBarData(
                spots: const [
                  FlSpot(0, 48),
                  FlSpot(1, 50),
                  FlSpot(2, 52),
                  FlSpot(3, 50),
                  FlSpot(4, 54),
                  FlSpot(5, 52),
                ],
                isCurved: true,
                color: AppColors.accent,
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String target;
  final bool isGood;

  const _StatCard({
    required this.label,
    required this.value,
    required this.target,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              color: isGood ? AppColors.success : AppColors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isGood ? Icons.check_circle : Icons.warning,
                size: 14,
                color: isGood ? AppColors.success : AppColors.warning,
              ),
              const SizedBox(width: 4),
              Text(
                'Target: $target',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
