import 'package:freezed_annotation/freezed_annotation.dart';

part 'hole_score.freezed.dart';
part 'hole_score.g.dart';

/// Represents a single hole score in a round
@freezed
class HoleScore with _$HoleScore {
  const factory HoleScore({
    required String id,
    required String roundId,
    required int holeNumber,
    required int par,
    int? strokeIndex,
    required int strokes,
    int? putts,
    bool? fairwayHit,
    bool? greenInRegulation,
    bool? sandSave,
    bool? upAndDown,
    @Default(0) int penaltyStrokes,
    String? notes,
  }) = _HoleScore;

  factory HoleScore.fromJson(Map<String, dynamic> json) =>
      _$HoleScoreFromJson(json);
}

extension HoleScoreX on HoleScore {
  /// Score relative to par
  int get scoreToPar => strokes - par;

  /// Display name for score relative to par
  String get scoreToParName {
    final diff = scoreToPar;
    if (diff <= -3) return 'Albatross';
    if (diff == -2) return 'Eagle';
    if (diff == -1) return 'Birdie';
    if (diff == 0) return 'Par';
    if (diff == 1) return 'Bogey';
    if (diff == 2) return 'Double Bogey';
    if (diff == 3) return 'Triple Bogey';
    return '+$diff';
  }

  /// Short display for score to par
  String get scoreToParDisplay {
    final diff = scoreToPar;
    if (diff == 0) return 'E';
    if (diff > 0) return '+$diff';
    return '$diff';
  }

  /// Color indicator for score
  /// Returns: -2 = eagle, -1 = birdie, 0 = par, 1 = bogey, 2+ = double+
  int get colorLevel {
    final diff = scoreToPar;
    if (diff <= -2) return -2;
    if (diff == -1) return -1;
    if (diff == 0) return 0;
    if (diff == 1) return 1;
    return 2;
  }
}

/// Represents a complete scorecard for a round
class Scorecard {
  final String roundId;
  final List<HoleScore> holes;
  final int? coursePar;

  Scorecard({
    required this.roundId,
    required this.holes,
    this.coursePar,
  });

  /// Front nine holes (1-9)
  List<HoleScore> get frontNine =>
      holes.where((h) => h.holeNumber <= 9).toList()
        ..sort((a, b) => a.holeNumber.compareTo(b.holeNumber));

  /// Back nine holes (10-18)
  List<HoleScore> get backNine =>
      holes.where((h) => h.holeNumber > 9).toList()
        ..sort((a, b) => a.holeNumber.compareTo(b.holeNumber));

  /// Total strokes
  int get totalStrokes => holes.fold(0, (sum, h) => sum + h.strokes);

  /// Front nine total
  int get frontNineTotal => frontNine.fold(0, (sum, h) => sum + h.strokes);

  /// Back nine total
  int get backNineTotal => backNine.fold(0, (sum, h) => sum + h.strokes);

  /// Front nine par
  int get frontNinePar => frontNine.fold(0, (sum, h) => sum + h.par);

  /// Back nine par
  int get backNinePar => backNine.fold(0, (sum, h) => sum + h.par);

  /// Total par
  int get totalPar => holes.fold(0, (sum, h) => sum + h.par);

  /// Total putts
  int? get totalPutts {
    if (holes.any((h) => h.putts == null)) return null;
    return holes.fold<int>(0, (sum, h) => sum + (h.putts ?? 0));
  }

  /// Fairways hit
  int get fairwaysHit =>
      holes.where((h) => h.fairwayHit == true && h.par > 3).length;

  /// Total fairways (par 4s and par 5s)
  int get totalFairways => holes.where((h) => h.par > 3).length;

  /// Greens in regulation
  int get greensInRegulation =>
      holes.where((h) => h.greenInRegulation == true).length;

  /// Birdies
  int get birdies => holes.where((h) => h.scoreToPar == -1).length;

  /// Pars
  int get pars => holes.where((h) => h.scoreToPar == 0).length;

  /// Bogeys
  int get bogeys => holes.where((h) => h.scoreToPar == 1).length;

  /// Double bogeys or worse
  int get doubleBogeyOrWorse => holes.where((h) => h.scoreToPar >= 2).length;

  /// Eagles or better
  int get eaglesOrBetter => holes.where((h) => h.scoreToPar <= -2).length;

  /// Is complete (all 18 holes)
  bool get isComplete => holes.length == 18;

  /// Score to par
  int get scoreToPar => totalStrokes - totalPar;

  /// Score to par display
  String get scoreToParDisplay {
    final diff = scoreToPar;
    if (diff == 0) return 'E';
    if (diff > 0) return '+$diff';
    return '$diff';
  }
}
