import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/scorecard_repository.dart';
import '../../domain/hole_score.dart';
import '../../../tournaments/domain/tournament.dart';
import '../../../auth/presentation/providers/player_provider.dart';

/// Provider for ScorecardRepository
final scorecardRepositoryProvider = Provider<ScorecardRepository>((ref) {
  return ScorecardRepository();
});

/// Provider for hole scores of a specific round
final holeScoresProvider =
    FutureProvider.family<List<HoleScore>, String>((ref, roundId) async {
  final repository = ref.watch(scorecardRepositoryProvider);
  return repository.getHoleScores(roundId);
});

/// Provider for a complete scorecard
final scorecardProvider =
    FutureProvider.family<Scorecard, String>((ref, roundId) async {
  final repository = ref.watch(scorecardRepositoryProvider);
  return repository.getScorecard(roundId);
});

/// State for scorecard entry
class ScorecardEntryState {
  final String? tournamentId;
  final String? courseName;
  final int coursePar;
  final double? courseSlope;
  final double? courseRating;
  final DateTime roundDate;
  final int roundNumber;
  final double? playingHandicap; // Handicap used for this round
  final List<HoleEntryData> holes;
  final bool isLoading;
  final String? error;

  ScorecardEntryState({
    this.tournamentId,
    this.courseName,
    this.coursePar = 72,
    this.courseSlope,
    this.courseRating,
    DateTime? roundDate,
    this.roundNumber = 1,
    this.playingHandicap,
    List<HoleEntryData>? holes,
    this.isLoading = false,
    this.error,
  })  : roundDate = roundDate ?? DateTime.now(),
        holes = holes ?? _createDefaultHoles();

  static List<HoleEntryData> _createDefaultHoles() {
    return List.generate(
      18,
      (i) => HoleEntryData(
        holeNumber: i + 1,
        par: 4, // Default to par 4
      ),
    );
  }

  int get totalStrokes => holes.fold(0, (sum, h) => sum + (h.strokes ?? 0));
  int get frontNineStrokes => holes
      .where((h) => h.holeNumber <= 9)
      .fold(0, (sum, h) => sum + (h.strokes ?? 0));
  int get backNineStrokes => holes
      .where((h) => h.holeNumber > 9)
      .fold(0, (sum, h) => sum + (h.strokes ?? 0));

  int get totalPutts =>
      holes.fold(0, (sum, h) => sum + (h.putts ?? 0));
  int get fairwaysHit => holes
      .where((h) => h.fairwayHit == true && h.par > 3)
      .length;
  int get totalFairways => holes.where((h) => h.par > 3).length;
  int get greensInRegulation =>
      holes.where((h) => h.greenInRegulation == true).length;

  int get scoreToPar => totalStrokes - coursePar;

  /// Calculate net score (gross - handicap)
  int? get netScore {
    if (playingHandicap == null) return null;
    return totalStrokes - playingHandicap!.round();
  }

  /// Net score to par
  int? get netScoreToPar {
    final net = netScore;
    if (net == null) return null;
    return net - coursePar;
  }

  bool get isComplete => holes.every((h) => h.strokes != null && h.strokes! > 0);

  ScorecardEntryState copyWith({
    String? tournamentId,
    String? courseName,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    DateTime? roundDate,
    int? roundNumber,
    double? playingHandicap,
    bool clearHandicap = false,
    List<HoleEntryData>? holes,
    bool? isLoading,
    String? error,
  }) {
    return ScorecardEntryState(
      tournamentId: tournamentId ?? this.tournamentId,
      courseName: courseName ?? this.courseName,
      coursePar: coursePar ?? this.coursePar,
      courseSlope: courseSlope ?? this.courseSlope,
      courseRating: courseRating ?? this.courseRating,
      roundDate: roundDate ?? this.roundDate,
      roundNumber: roundNumber ?? this.roundNumber,
      playingHandicap: clearHandicap ? null : (playingHandicap ?? this.playingHandicap),
      holes: holes ?? this.holes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Data for a single hole entry
class HoleEntryData {
  final int holeNumber;
  final int par;
  final int? strokeIndex;
  final int? strokes;
  final int? putts;
  final bool? fairwayHit;
  final bool? greenInRegulation;
  final int penaltyStrokes;

  HoleEntryData({
    required this.holeNumber,
    this.par = 4,
    this.strokeIndex,
    this.strokes,
    this.putts,
    this.fairwayHit,
    this.greenInRegulation,
    this.penaltyStrokes = 0,
  });

  HoleEntryData copyWith({
    int? holeNumber,
    int? par,
    int? strokeIndex,
    int? strokes,
    int? putts,
    bool? fairwayHit,
    bool? greenInRegulation,
    int? penaltyStrokes,
  }) {
    return HoleEntryData(
      holeNumber: holeNumber ?? this.holeNumber,
      par: par ?? this.par,
      strokeIndex: strokeIndex ?? this.strokeIndex,
      strokes: strokes ?? this.strokes,
      putts: putts ?? this.putts,
      fairwayHit: fairwayHit ?? this.fairwayHit,
      greenInRegulation: greenInRegulation ?? this.greenInRegulation,
      penaltyStrokes: penaltyStrokes ?? this.penaltyStrokes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'holeNumber': holeNumber,
      'par': par,
      'strokeIndex': strokeIndex,
      'strokes': strokes,
      'putts': putts,
      'fairwayHit': fairwayHit,
      'greenInRegulation': greenInRegulation,
      'penaltyStrokes': penaltyStrokes,
    };
  }

  int? get scoreToPar {
    if (strokes == null) return null;
    return strokes! - par;
  }
}

/// Notifier for scorecard entry
class ScorecardEntryNotifier extends StateNotifier<ScorecardEntryState> {
  final ScorecardRepository _repository;
  final Ref _ref;

  ScorecardEntryNotifier(this._repository, this._ref)
      : super(ScorecardEntryState());

  /// Initialize for a tournament
  void initForTournament({
    required String tournamentId,
    required String courseName,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    int roundNumber = 1,
  }) {
    state = ScorecardEntryState(
      tournamentId: tournamentId,
      courseName: courseName,
      coursePar: coursePar ?? 72,
      courseSlope: courseSlope,
      courseRating: courseRating,
      roundNumber: roundNumber,
    );
  }

  /// Initialize for practice round
  void initForPractice({
    String? courseName,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
  }) {
    state = ScorecardEntryState(
      courseName: courseName,
      coursePar: coursePar ?? 72,
      courseSlope: courseSlope,
      courseRating: courseRating,
    );
  }

  /// Set course info
  void setCourseInfo({
    String? courseName,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
  }) {
    state = state.copyWith(
      courseName: courseName ?? state.courseName,
      coursePar: coursePar ?? state.coursePar,
      courseSlope: courseSlope ?? state.courseSlope,
      courseRating: courseRating ?? state.courseRating,
    );
  }

  /// Set round date
  void setRoundDate(DateTime date) {
    state = state.copyWith(roundDate: date);
  }

  /// Update a hole's par
  void setHolePar(int holeNumber, int par) {
    final newHoles = List<HoleEntryData>.from(state.holes);
    final index = holeNumber - 1;
    newHoles[index] = newHoles[index].copyWith(par: par);
    state = state.copyWith(holes: newHoles);
  }

  /// Update a hole's score
  void setHoleScore(int holeNumber, int strokes) {
    final newHoles = List<HoleEntryData>.from(state.holes);
    final index = holeNumber - 1;
    newHoles[index] = newHoles[index].copyWith(strokes: strokes);
    state = state.copyWith(holes: newHoles);
  }

  /// Update hole putts
  void setHolePutts(int holeNumber, int putts) {
    final newHoles = List<HoleEntryData>.from(state.holes);
    final index = holeNumber - 1;
    newHoles[index] = newHoles[index].copyWith(putts: putts);
    state = state.copyWith(holes: newHoles);
  }

  /// Update hole fairway hit
  void setHoleFairway(int holeNumber, bool? hit) {
    final newHoles = List<HoleEntryData>.from(state.holes);
    final index = holeNumber - 1;
    newHoles[index] = newHoles[index].copyWith(fairwayHit: hit);
    state = state.copyWith(holes: newHoles);
  }

  /// Update hole GIR
  void setHoleGIR(int holeNumber, bool? gir) {
    final newHoles = List<HoleEntryData>.from(state.holes);
    final index = holeNumber - 1;
    newHoles[index] = newHoles[index].copyWith(greenInRegulation: gir);
    state = state.copyWith(holes: newHoles);
  }

  /// Update full hole data
  void updateHole(int holeNumber, HoleEntryData data) {
    final newHoles = List<HoleEntryData>.from(state.holes);
    final index = holeNumber - 1;
    newHoles[index] = data;
    state = state.copyWith(holes: newHoles);
  }

  /// Set default pars (standard course)
  void setStandardPars() {
    // Standard par layout: 4,4,3,5,4,4,3,4,5 (out), 4,4,3,5,4,4,3,4,5 (in)
    final standardPars = [4, 4, 3, 5, 4, 4, 3, 4, 5, 4, 4, 3, 5, 4, 4, 3, 4, 5];
    final newHoles = state.holes.asMap().entries.map((e) {
      return e.value.copyWith(par: standardPars[e.key]);
    }).toList();
    state = state.copyWith(holes: newHoles, coursePar: 72);
  }

  /// Set playing handicap
  void setPlayingHandicap(double? handicap) {
    if (handicap == null) {
      state = state.copyWith(clearHandicap: true);
    } else {
      state = state.copyWith(playingHandicap: handicap);
    }
  }

  /// Save the round
  Future<Round?> saveRound() async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) {
      state = state.copyWith(error: 'No player profile found');
      return null;
    }

    if (!state.isComplete) {
      state = state.copyWith(error: 'Please enter scores for all holes');
      return null;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final round = await _repository.createRoundWithScores(
        playerId: player.id,
        tournamentId: state.tournamentId,
        roundDate: state.roundDate,
        grossScore: state.totalStrokes,
        roundNumber: state.roundNumber,
        courseName: state.courseName,
        coursePar: state.coursePar,
        courseSlope: state.courseSlope,
        courseRating: state.courseRating,
        playingHandicap: state.playingHandicap,
        fairwaysHit: state.fairwaysHit,
        fairwaysTotal: state.totalFairways,
        greensInRegulation: state.greensInRegulation,
        putts: state.totalPutts,
        isPractice: state.tournamentId == null,
        holeScores: state.holes.map((h) => h.toMap()).toList(),
      );

      state = state.copyWith(isLoading: false);
      return round;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  /// Reset state
  void reset() {
    state = ScorecardEntryState();
  }
}

/// Provider for ScorecardEntryNotifier
final scorecardEntryProvider =
    StateNotifierProvider<ScorecardEntryNotifier, ScorecardEntryState>((ref) {
  final repository = ref.watch(scorecardRepositoryProvider);
  return ScorecardEntryNotifier(repository, ref);
});
