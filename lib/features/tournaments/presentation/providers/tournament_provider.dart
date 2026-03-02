import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/tournament.dart';
import '../../data/tournament_repository.dart';
import '../../../auth/presentation/providers/player_provider.dart';

/// Provider for TournamentRepository
final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  return TournamentRepository();
});

/// Provider for tournaments list
final tournamentsProvider = FutureProvider<List<Tournament>>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.getTournaments(player.id);
});

/// Provider for a single tournament
final tournamentProvider = FutureProvider.family<Tournament?, String>((ref, id) async {
  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.getTournament(id);
});

/// Provider for recent tournaments
final recentTournamentsProvider = FutureProvider<List<Tournament>>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return [];

  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.getRecentTournaments(player.id, limit: 5);
});

/// Provider for tournament count
final tournamentCountProvider = FutureProvider<int>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return 0;

  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.getTournamentCount(player.id);
});

/// Provider for best finish
final bestFinishProvider = FutureProvider<int?>((ref) async {
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  if (player == null) return null;

  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.getBestFinish(player.id);
});

/// Provider for rounds of a tournament
final tournamentRoundsProvider = FutureProvider.family<List<Round>, String>((ref, tournamentId) async {
  final repository = ref.watch(tournamentRepositoryProvider);
  return repository.getRoundsForTournament(tournamentId);
});

/// StateNotifier for tournament operations
class TournamentNotifier extends StateNotifier<AsyncValue<List<Tournament>>> {
  final TournamentRepository _repository;
  final String? _playerId;

  TournamentNotifier(this._repository, this._playerId)
      : super(const AsyncValue.loading()) {
    if (_playerId != null) {
      loadTournaments();
    } else {
      state = const AsyncValue.data([]);
    }
  }

  Future<void> loadTournaments() async {
    if (_playerId == null) return;

    state = const AsyncValue.loading();
    try {
      final tournaments = await _repository.getTournaments(_playerId);
      state = AsyncValue.data(tournaments);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Tournament> createTournament({
    required String name,
    required DateTime startDate,
    required String courseName,
    String? tournamentType,
    DateTime? endDate,
    String? courseCity,
    String? courseState,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    int? totalScore,
    int? position,
    int? fieldSize,
    String? notes,
    String? weatherConditions,
  }) async {
    if (_playerId == null) {
      throw Exception('No player ID');
    }

    final tournament = await _repository.createTournament(
      playerId: _playerId,
      name: name,
      startDate: startDate,
      courseName: courseName,
      tournamentType: tournamentType,
      endDate: endDate,
      courseCity: courseCity,
      courseState: courseState,
      coursePar: coursePar,
      courseSlope: courseSlope,
      courseRating: courseRating,
      totalScore: totalScore,
      position: position,
      fieldSize: fieldSize,
      notes: notes,
      weatherConditions: weatherConditions,
    );

    // Refresh the list
    await loadTournaments();
    return tournament;
  }

  Future<void> deleteTournament(String id) async {
    await _repository.deleteTournament(id);
    await loadTournaments();
  }
}

/// Provider for TournamentNotifier
final tournamentNotifierProvider =
    StateNotifierProvider<TournamentNotifier, AsyncValue<List<Tournament>>>((ref) {
  final repository = ref.watch(tournamentRepositoryProvider);
  final player = ref.watch(playerNotifierProvider).valueOrNull;
  return TournamentNotifier(repository, player?.id);
});

/// Data class for tournament with calculated stats from rounds
class TournamentWithStats {
  final Tournament tournament;
  final List<Round> rounds;

  TournamentWithStats({required this.tournament, required this.rounds});

  /// Total score from all rounds
  int? get totalScore {
    if (rounds.isEmpty) return tournament.totalScore;
    return rounds.fold<int>(0, (sum, r) => sum + r.grossScore);
  }

  /// Total par from all rounds
  int? get totalPar {
    if (rounds.isEmpty) return tournament.coursePar;
    final pars = rounds.where((r) => r.coursePar != null).map((r) => r.coursePar!).toList();
    if (pars.isEmpty) return tournament.coursePar;
    return pars.fold<int>(0, (sum, par) => sum + par);
  }

  /// Score relative to par
  int? get scoreToPar {
    final score = totalScore;
    final par = totalPar;
    if (score == null || par == null) return tournament.scoreToPar;
    return score - par;
  }

  /// Course name from rounds (show all unique course names)
  String get courseName {
    if (rounds.isNotEmpty) {
      // Get unique course names from rounds
      final courseNames = rounds
          .map((r) => r.courseName)
          .where((n) => n != null && n.isNotEmpty)
          .toSet()
          .toList();

      if (courseNames.isEmpty) return tournament.courseName;
      if (courseNames.length == 1) return courseNames.first!;

      // Multiple courses - join them with comma
      return courseNames.join(', ');
    }
    return tournament.courseName;
  }

  /// Start date from rounds (earliest round date) or tournament's date
  DateTime get startDate {
    if (rounds.isEmpty) return tournament.startDate;
    final dates = rounds.map((r) => r.roundDate).toList()..sort();
    return dates.first;
  }

  /// End date from rounds (latest round date) or tournament's end date
  DateTime? get endDate {
    if (rounds.isEmpty) return tournament.endDate;
    if (rounds.length == 1) return null;
    final dates = rounds.map((r) => r.roundDate).toList()..sort();
    final lastDate = dates.last;
    // Only return end date if it's different from start date
    if (lastDate.year == startDate.year &&
        lastDate.month == startDate.month &&
        lastDate.day == startDate.day) {
      return null;
    }
    return lastDate;
  }

  /// Course par per round (for display)
  int? get courseParPerRound {
    if (rounds.isEmpty) return tournament.coursePar;
    final pars = rounds.where((r) => r.coursePar != null).map((r) => r.coursePar!);
    if (pars.isEmpty) return tournament.coursePar;
    return pars.first; // Assuming same course par for all rounds
  }

  /// Score display string
  String get scoreDisplay {
    final score = totalScore;
    final toPar = scoreToPar;
    if (score == null) return '-';
    if (toPar == null) return '$score';
    if (toPar == 0) return '$score (E)';
    if (toPar > 0) return '$score (+$toPar)';
    return '$score ($toPar)';
  }

  /// Whether tournament spans multiple days
  bool get isMultiDay => endDate != null;

  /// Number of rounds
  int get roundCount => rounds.length;
}

/// Provider for tournament with calculated stats from rounds
final tournamentWithStatsProvider = FutureProvider.family<TournamentWithStats?, String>((ref, id) async {
  final tournament = await ref.watch(tournamentProvider(id).future);
  if (tournament == null) return null;

  final rounds = await ref.watch(tournamentRoundsProvider(id).future);

  return TournamentWithStats(tournament: tournament, rounds: rounds);
});
