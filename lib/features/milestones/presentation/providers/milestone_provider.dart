import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/player_provider.dart';
import '../../data/milestone_repository.dart';
import '../../domain/milestone.dart';

/// Repository provider
final milestoneRepositoryProvider = Provider<MilestoneRepository>((ref) {
  return MilestoneRepository();
});

/// All milestones for a player with progress
final allMilestonesProvider =
    FutureProvider.autoDispose<List<MilestoneWithProgress>>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repo = ref.watch(milestoneRepositoryProvider);
  return repo.getAllMilestonesWithProgress(player.id);
});

/// Milestones for a specific phase with progress
final phaseMilestonesProvider = FutureProvider.autoDispose
    .family<List<MilestoneWithProgress>, int>((ref, phase) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repo = ref.watch(milestoneRepositoryProvider);
  return repo.getMilestonesForPhase(player.id, phase);
});

/// Completion stats for all phases
final milestoneStatsProvider =
    FutureProvider.autoDispose<Map<int, MilestoneStats>>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return {};

  final repo = ref.watch(milestoneRepositoryProvider);
  return repo.getCompletionStats(player.id);
});

/// State notifier for milestone actions
class MilestoneNotifier extends StateNotifier<AsyncValue<void>> {
  final MilestoneRepository _repository;
  final Ref _ref;

  MilestoneNotifier(this._repository, this._ref)
      : super(const AsyncValue.data(null));

  Future<void> toggleMilestone({
    required String milestoneId,
    String? notes,
  }) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) return;

    state = const AsyncValue.loading();
    try {
      await _repository.toggleMilestone(
        playerId: player.id,
        milestoneId: milestoneId,
        notes: notes,
      );
      state = const AsyncValue.data(null);

      // Invalidate providers to refresh data
      _ref.invalidate(allMilestonesProvider);
      _ref.invalidate(milestoneStatsProvider);
      // Also invalidate phase-specific providers
      for (var phase = 1; phase <= 4; phase++) {
        _ref.invalidate(phaseMilestonesProvider(phase));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> completeMilestone({
    required String milestoneId,
    String? notes,
    String? mediaUrl,
  }) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) return;

    state = const AsyncValue.loading();
    try {
      await _repository.completeMilestone(
        playerId: player.id,
        milestoneId: milestoneId,
        notes: notes,
        mediaUrl: mediaUrl,
      );
      state = const AsyncValue.data(null);

      // Invalidate providers to refresh data
      _ref.invalidate(allMilestonesProvider);
      _ref.invalidate(milestoneStatsProvider);
      for (var phase = 1; phase <= 4; phase++) {
        _ref.invalidate(phaseMilestonesProvider(phase));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> uncompleteMilestone(String milestoneId) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) return;

    state = const AsyncValue.loading();
    try {
      await _repository.uncompleteMilestone(
        playerId: player.id,
        milestoneId: milestoneId,
      );
      state = const AsyncValue.data(null);

      // Invalidate providers
      _ref.invalidate(allMilestonesProvider);
      _ref.invalidate(milestoneStatsProvider);
      for (var phase = 1; phase <= 4; phase++) {
        _ref.invalidate(phaseMilestonesProvider(phase));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final milestoneNotifierProvider =
    StateNotifierProvider<MilestoneNotifier, AsyncValue<void>>((ref) {
  return MilestoneNotifier(
    ref.watch(milestoneRepositoryProvider),
    ref,
  );
});

/// Selected phase for filtering (player's current phase by default)
final selectedMilestonePhaseProvider = StateProvider<int?>((ref) {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  return player?.currentPhase;
});

/// Filtered milestones based on selected phase
final filteredMilestonesProvider =
    FutureProvider.autoDispose<List<MilestoneWithProgress>>((ref) async {
  final selectedPhase = ref.watch(selectedMilestonePhaseProvider);

  if (selectedPhase == null) {
    return ref.watch(allMilestonesProvider.future);
  }

  return ref.watch(phaseMilestonesProvider(selectedPhase).future);
});
