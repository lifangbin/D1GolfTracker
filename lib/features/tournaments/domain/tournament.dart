import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament.freezed.dart';
part 'tournament.g.dart';

@freezed
class Tournament with _$Tournament {
  const factory Tournament({
    required String id,
    required String playerId,

    // Basic Info
    required String name,
    String? tournamentType, // local, regional, state, national, international
    required DateTime startDate,
    DateTime? endDate,

    // Location
    required String courseName,
    String? courseCity,
    String? courseState,
    @Default('Australia') String courseCountry,
    int? coursePar,
    double? courseSlope,
    double? courseRating,

    // Results
    int? totalScore,
    int? position,
    int? fieldSize,
    int? scoreToPar,

    // Notes
    String? notes,
    String? weatherConditions,

    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Tournament;

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);
}

extension TournamentX on Tournament {
  String get typeDisplay {
    switch (tournamentType) {
      case 'local':
        return 'Local';
      case 'regional':
        return 'Regional';
      case 'state':
        return 'State';
      case 'national':
        return 'National';
      case 'international':
        return 'International';
      default:
        return 'Other';
    }
  }

  String get scoreDisplay {
    if (totalScore == null) return '-';
    if (scoreToPar == null) return '$totalScore';
    if (scoreToPar == 0) return '$totalScore (E)';
    if (scoreToPar! > 0) return '$totalScore (+$scoreToPar)';
    return '$totalScore ($scoreToPar)';
  }

  String get positionDisplay {
    if (position == null) return '-';
    if (fieldSize != null) return '${_ordinal(position!)} of $fieldSize';
    return _ordinal(position!);
  }

  String _ordinal(int n) {
    if (n >= 11 && n <= 13) return '${n}th';
    switch (n % 10) {
      case 1:
        return '${n}st';
      case 2:
        return '${n}nd';
      case 3:
        return '${n}rd';
      default:
        return '${n}th';
    }
  }

  bool get isMultiDay => endDate != null && endDate != startDate;
}

@freezed
class Round with _$Round {
  const factory Round({
    required String id,
    String? tournamentId,
    required String playerId,

    @Default(1) int roundNumber,
    required DateTime roundDate,

    // Course Info
    String? courseName,
    String? teePlayed,
    int? coursePar,
    double? courseSlope,
    double? courseRating,

    // Scores
    required int grossScore,
    int? netScore,
    double? playingHandicap, // The handicap used for this round
    double? differential,

    // Stats
    int? fairwaysHit,
    int? fairwaysTotal,
    int? greensInRegulation,
    int? putts,

    // Penalties
    @Default(0) int penalties,

    // Flags
    @Default(false) bool isPractice,
    @Default(true) bool isCountedForHandicap,

    String? notes,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Round;

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);
}

extension RoundX on Round {
  String get scoreDisplay {
    if (coursePar == null) return '$grossScore';
    final toPar = grossScore - coursePar!;
    if (toPar == 0) return '$grossScore (E)';
    if (toPar > 0) return '$grossScore (+$toPar)';
    return '$grossScore ($toPar)';
  }

  /// Calculate net score from gross score and playing handicap
  int? get calculatedNetScore {
    if (playingHandicap == null) return netScore;
    return grossScore - playingHandicap!.round();
  }

  /// Display string for net score
  String get netScoreDisplay {
    final net = calculatedNetScore;
    if (net == null) return '-';
    if (coursePar == null) return '$net';
    final toPar = net - coursePar!;
    if (toPar == 0) return '$net (E)';
    if (toPar > 0) return '$net (+$toPar)';
    return '$net ($toPar)';
  }

  /// Display handicap used for the round
  String get handicapDisplay {
    if (playingHandicap == null) return '-';
    return playingHandicap!.toStringAsFixed(1);
  }

  double? get firPercentage {
    if (fairwaysHit == null || fairwaysTotal == null || fairwaysTotal == 0) {
      return null;
    }
    return (fairwaysHit! / fairwaysTotal!) * 100;
  }

  double? get girPercentage {
    if (greensInRegulation == null) return null;
    return (greensInRegulation! / 18) * 100;
  }
}
