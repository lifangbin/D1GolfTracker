import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../providers/player_provider.dart';
import '../providers/auth_provider.dart';
import '../../domain/player.dart';
import '../../../handicap/presentation/widgets/ga_connect_dialog.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(playerNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/profile/edit');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: playerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
        data: (player) {
          if (player == null) {
            return const Center(child: Text('No profile found'));
          }
          return _buildProfileContent(context, player);
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, Player player) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        children: [
          // Avatar and Name
          _buildHeader(player),
          const SizedBox(height: AppSpacing.lg),

          // Stats Cards
          _buildStatsRow(player),
          const SizedBox(height: AppSpacing.lg),

          // Details Card
          _buildDetailsCard(player),
          const SizedBox(height: AppSpacing.md),

          // Golf Australia Card
          _buildGACard(context, player),
          const SizedBox(height: AppSpacing.md),

          // Quick Actions
          _buildQuickActions(context),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          _ActionButton(
            icon: Icons.fitness_center,
            label: 'Training Log',
            subtitle: 'Track practice sessions',
            color: AppColors.primary,
            onTap: () => context.push('/training'),
          ),
          const Divider(height: 1),
          _ActionButton(
            icon: Icons.school,
            label: 'Academic Records',
            subtitle: 'Track GPA & NCAA eligibility',
            color: AppColors.secondary,
            onTap: () => context.push('/academic'),
          ),
          const Divider(height: 1),
          _ActionButton(
            icon: Icons.flag,
            label: 'Milestones',
            subtitle: 'Track development goals',
            color: AppColors.accent,
            onTap: () => context.go('/milestones'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(Player player) {
    return Column(
      children: [
        // Avatar
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          backgroundImage:
              player.avatarUrl != null ? NetworkImage(player.avatarUrl!) : null,
          child: player.avatarUrl == null
              ? Text(
                  '${player.firstName[0]}${player.lastName[0]}',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        const SizedBox(height: AppSpacing.md),

        // Name
        Text(
          player.fullName,
          style: AppTextStyles.headlineLarge,
        ),

        // Phase
        Container(
          margin: const EdgeInsets.only(top: AppSpacing.sm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: _getPhaseColor(player.currentPhase),
            borderRadius: BorderRadius.circular(AppRadius.round),
          ),
          child: Text(
            player.phaseName,
            style: AppTextStyles.labelMedium.copyWith(
              color: Colors.white,
            ),
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

  Widget _buildStatsRow(Player player) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Handicap',
            value: player.handicapDisplay,
            icon: Icons.golf_course,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            label: 'Age',
            value: '${player.age}',
            icon: Icons.cake,
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            label: 'Phase',
            value: '${player.currentPhase}',
            icon: Icons.flag,
            color: _getPhaseColor(player.currentPhase),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(Player player) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Player Details',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          _DetailRow(
            icon: Icons.calendar_today,
            label: 'Date of Birth',
            value: DateFormat('dd MMM yyyy').format(player.dateOfBirth),
          ),
          if (player.gender != null)
            _DetailRow(
              icon: Icons.person,
              label: 'Gender',
              value: player.gender![0].toUpperCase() + player.gender!.substring(1),
            ),
          if (player.homeCourse != null)
            _DetailRow(
              icon: Icons.location_on,
              label: 'Home Course',
              value: player.homeCourse!,
            ),
        ],
      ),
    );
  }

  Widget _buildGACard(BuildContext context, Player player) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.sports_golf, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Golf Australia',
                style: AppTextStyles.titleLarge,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: player.gaConnected
                      ? AppColors.success.withOpacity(0.2)
                      : AppColors.textHint.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  player.gaConnected ? 'Connected' : 'Not Connected',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: player.gaConnected
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (player.gaNumber != null)
            _DetailRow(
              icon: Icons.badge,
              label: 'GA Number',
              value: player.gaNumber!,
            ),
          if (player.gaLastSync != null)
            _DetailRow(
              icon: Icons.sync,
              label: 'Last Sync',
              value: DateFormat('dd MMM yyyy HH:mm').format(player.gaLastSync!),
            ),
          if (!player.gaConnected) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                isOutlined: true,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const GAConnectDialog(),
                  );
                },
                child: const Text('Connect GA Account'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
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
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(color: color),
          ),
          Text(
            label,
            style: AppTextStyles.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$label:',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}
