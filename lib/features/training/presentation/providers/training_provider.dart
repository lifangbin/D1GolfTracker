import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/player_provider.dart';
import '../../data/training_repository.dart';
import '../../domain/training_session.dart';

/// Repository provider
final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  return TrainingRepository();
});

/// All training sessions provider
final trainingSessionsProvider =
    FutureProvider.autoDispose<List<TrainingSession>>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getTrainingSessions(player.id);
});

/// Training sessions for a specific date range
final trainingSessionsInRangeProvider = FutureProvider.autoDispose
    .family<List<TrainingSession>, ({DateTime start, DateTime end})>(
        (ref, range) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getSessionsInRange(player.id, range.start, range.end);
});

/// This week's training summary
final weeklyTrainingSummaryProvider =
    FutureProvider.autoDispose<TrainingSummary>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) {
    return const TrainingSummary(
      totalSessions: 0,
      totalMinutes: 0,
      sessionsByType: {},
      minutesByType: {},
      averageRating: 0,
      totalBallsHit: 0,
    );
  }

  final now = DateTime.now();
  final weekStart = now.subtract(Duration(days: now.weekday - 1));
  final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

  final repository = ref.watch(trainingRepositoryProvider);
  return repository.getWeeklySummary(player.id, startOfWeek);
});

/// Training notifier for mutations
final trainingNotifierProvider =
    StateNotifierProvider<TrainingNotifier, AsyncValue<void>>((ref) {
  return TrainingNotifier(ref);
});

class TrainingNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  TrainingNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> addSession({
    required DateTime date,
    required TrainingType type,
    required int durationMinutes,
    String? location,
    TrainingIntensity? intensity,
    List<TrainingFocus>? focusAreas,
    String? notes,
    String? coachName,
    int? ballsHit,
    int? puttsMade,
    int? puttsAttempted,
    double? rating,
  }) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) return;

    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(trainingRepositoryProvider);
      await repository.addSession(
        playerId: player.id,
        date: date,
        type: type,
        durationMinutes: durationMinutes,
        location: location,
        intensity: intensity,
        focusAreas: focusAreas,
        notes: notes,
        coachName: coachName,
        ballsHit: ballsHit,
        puttsMade: puttsMade,
        puttsAttempted: puttsAttempted,
        rating: rating,
      );

      // Invalidate providers
      _ref.invalidate(trainingSessionsProvider);
      _ref.invalidate(weeklyTrainingSummaryProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSession(String sessionId) async {
    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(trainingRepositoryProvider);
      await repository.deleteSession(sessionId);

      // Invalidate providers
      _ref.invalidate(trainingSessionsProvider);
      _ref.invalidate(weeklyTrainingSummaryProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
