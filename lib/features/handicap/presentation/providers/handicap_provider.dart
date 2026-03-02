import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/handicap_repository.dart';
import '../../domain/handicap_entry.dart';
import '../../../auth/presentation/providers/player_provider.dart';

/// Provider for HandicapRepository
final handicapRepositoryProvider = Provider<HandicapRepository>((ref) {
  return HandicapRepository();
});

/// Provider for current handicap
final currentHandicapProvider = FutureProvider<HandicapEntry?>((ref) async {
  final player = ref.watch(currentPlayerProvider).value;
  if (player == null) return null;

  final repository = ref.watch(handicapRepositoryProvider);
  return repository.getCurrentHandicap(player.id);
});

/// Provider for handicap history
final handicapHistoryProvider = FutureProvider<List<HandicapEntry>>((ref) async {
  final player = ref.watch(currentPlayerProvider).value;
  if (player == null) return [];

  final repository = ref.watch(handicapRepositoryProvider);
  return repository.getHandicapHistory(player.id);
});

/// Provider for handicap trend (for chart)
final handicapTrendProvider = FutureProvider<List<HandicapEntry>>((ref) async {
  final player = ref.watch(currentPlayerProvider).value;
  if (player == null) return [];

  final repository = ref.watch(handicapRepositoryProvider);
  return repository.getHandicapTrend(player.id, limit: 12);
});

/// Provider for lowest handicap ever
final lowestHandicapProvider = FutureProvider<double?>((ref) async {
  final player = ref.watch(currentPlayerProvider).value;
  if (player == null) return null;

  final repository = ref.watch(handicapRepositoryProvider);
  return repository.getLowestHandicap(player.id);
});

/// Provider for handicap change (last 30 days)
final handicapChangeProvider = FutureProvider<double?>((ref) async {
  final player = ref.watch(currentPlayerProvider).value;
  if (player == null) return null;

  final repository = ref.watch(handicapRepositoryProvider);
  return repository.getHandicapChange(player.id, daysBack: 30);
});

/// State class for handicap operations
class HandicapState {
  final bool isLoading;
  final String? error;
  final HandicapEntry? currentHandicap;
  final List<HandicapEntry> history;

  const HandicapState({
    this.isLoading = false,
    this.error,
    this.currentHandicap,
    this.history = const [],
  });

  HandicapState copyWith({
    bool? isLoading,
    String? error,
    HandicapEntry? currentHandicap,
    List<HandicapEntry>? history,
  }) {
    return HandicapState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentHandicap: currentHandicap ?? this.currentHandicap,
      history: history ?? this.history,
    );
  }
}

/// Notifier for handicap operations
class HandicapNotifier extends StateNotifier<HandicapState> {
  final HandicapRepository _repository;
  final Ref _ref;

  HandicapNotifier(this._repository, this._ref) : super(const HandicapState());

  Future<void> loadHandicapData() async {
    final player = _ref.read(currentPlayerProvider).value;
    if (player == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final current = await _repository.getCurrentHandicap(player.id);
      final history = await _repository.getHandicapHistory(player.id);

      state = state.copyWith(
        isLoading: false,
        currentHandicap: current,
        history: history,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addHandicapEntry({
    required double handicapIndex,
    double? lowHandicap,
    required DateTime effectiveDate,
    String source = 'manual',
    int? roundsCounted,
  }) async {
    final player = _ref.read(currentPlayerProvider).value;
    if (player == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final entry = await _repository.addHandicapEntry(
        playerId: player.id,
        handicapIndex: handicapIndex,
        lowHandicap: lowHandicap,
        effectiveDate: effectiveDate,
        source: source,
        roundsCounted: roundsCounted,
      );

      // Refresh data
      final history = await _repository.getHandicapHistory(player.id);

      state = state.copyWith(
        isLoading: false,
        currentHandicap: entry,
        history: history,
      );

      // Invalidate related providers
      _ref.invalidate(currentHandicapProvider);
      _ref.invalidate(handicapHistoryProvider);
      _ref.invalidate(handicapTrendProvider);
      _ref.invalidate(lowestHandicapProvider);
      _ref.invalidate(handicapChangeProvider);
      _ref.invalidate(currentPlayerProvider);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> deleteHandicapEntry(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _repository.deleteHandicapEntry(id);

      // Refresh data
      await loadHandicapData();

      // Invalidate related providers
      _ref.invalidate(currentHandicapProvider);
      _ref.invalidate(handicapHistoryProvider);
      _ref.invalidate(handicapTrendProvider);
      _ref.invalidate(lowestHandicapProvider);
      _ref.invalidate(handicapChangeProvider);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
}

/// Provider for HandicapNotifier
final handicapNotifierProvider =
    StateNotifierProvider<HandicapNotifier, HandicapState>((ref) {
  final repository = ref.watch(handicapRepositoryProvider);
  return HandicapNotifier(repository, ref);
});
