import '../domain/hole_score.dart';
import '../../tournaments/domain/tournament.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/app_constants.dart';

class ScorecardRepository {
  final SupabaseService _supabase;

  ScorecardRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService.instance;

  // ============ Hole Scores ============

  /// Get all hole scores for a round
  Future<List<HoleScore>> getHoleScores(String roundId) async {
    final response = await _supabase
        .from(TableNames.holeScores)
        .select()
        .eq('round_id', roundId)
        .order('hole_number', ascending: true);

    return (response as List)
        .map((row) => HoleScore.fromJson(_mapHoleScoreFromDb(row)))
        .toList();
  }

  /// Get scorecard for a round
  Future<Scorecard> getScorecard(String roundId, {int? coursePar}) async {
    final holes = await getHoleScores(roundId);
    return Scorecard(
      roundId: roundId,
      holes: holes,
      coursePar: coursePar,
    );
  }

  /// Create a hole score
  Future<HoleScore> createHoleScore({
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
    int penaltyStrokes = 0,
    String? notes,
  }) async {
    final data = {
      'round_id': roundId,
      'hole_number': holeNumber,
      'par': par,
      'stroke_index': strokeIndex,
      'strokes': strokes,
      'putts': putts,
      'fairway_hit': fairwayHit,
      'green_in_regulation': greenInRegulation,
      'sand_save': sandSave,
      'up_and_down': upAndDown,
      'penalty_strokes': penaltyStrokes,
      'notes': notes,
    };

    final response = await _supabase
        .from(TableNames.holeScores)
        .insert(data)
        .select()
        .single();

    return HoleScore.fromJson(_mapHoleScoreFromDb(response));
  }

  /// Create multiple hole scores at once
  Future<List<HoleScore>> createHoleScores(
    String roundId,
    List<Map<String, dynamic>> holeData,
  ) async {
    final data = holeData.map((hole) => {
      'round_id': roundId,
      'hole_number': hole['holeNumber'],
      'par': hole['par'],
      'stroke_index': hole['strokeIndex'],
      'strokes': hole['strokes'],
      'putts': hole['putts'],
      'fairway_hit': hole['fairwayHit'],
      'green_in_regulation': hole['greenInRegulation'],
      'sand_save': hole['sandSave'],
      'up_and_down': hole['upAndDown'],
      'penalty_strokes': hole['penaltyStrokes'] ?? 0,
      'notes': hole['notes'],
    }).toList();

    final response = await _supabase
        .from(TableNames.holeScores)
        .insert(data)
        .select();

    return (response as List)
        .map((row) => HoleScore.fromJson(_mapHoleScoreFromDb(row)))
        .toList();
  }

  /// Update a hole score
  Future<HoleScore> updateHoleScore(HoleScore score) async {
    final data = {
      'strokes': score.strokes,
      'putts': score.putts,
      'fairway_hit': score.fairwayHit,
      'green_in_regulation': score.greenInRegulation,
      'sand_save': score.sandSave,
      'up_and_down': score.upAndDown,
      'penalty_strokes': score.penaltyStrokes,
      'notes': score.notes,
    };

    final response = await _supabase
        .from(TableNames.holeScores)
        .update(data)
        .eq('id', score.id)
        .select()
        .single();

    return HoleScore.fromJson(_mapHoleScoreFromDb(response));
  }

  /// Delete all hole scores for a round
  Future<void> deleteHoleScores(String roundId) async {
    await _supabase
        .from(TableNames.holeScores)
        .delete()
        .eq('round_id', roundId);
  }

  // ============ Round Operations ============

  /// Create a round with hole scores
  Future<Round> createRoundWithScores({
    required String playerId,
    String? tournamentId,
    required DateTime roundDate,
    required int grossScore,
    int roundNumber = 1,
    String? courseName,
    String? teePlayed,
    int? coursePar,
    double? courseSlope,
    double? courseRating,
    double? playingHandicap,
    int? fairwaysHit,
    int? fairwaysTotal,
    int? greensInRegulation,
    int? putts,
    int penalties = 0,
    bool isPractice = false,
    bool isCountedForHandicap = true,
    String? notes,
    List<Map<String, dynamic>>? holeScores,
  }) async {
    // Calculate differential if we have the data
    double? differential;
    if (courseRating != null && courseSlope != null) {
      differential = ((grossScore - courseRating) * 113) / courseSlope;
    }

    // Calculate net score if we have the handicap
    int? netScore;
    if (playingHandicap != null) {
      netScore = grossScore - playingHandicap.round();
    }

    final data = {
      'player_id': playerId,
      'tournament_id': tournamentId,
      'round_number': roundNumber,
      'round_date': roundDate.toIso8601String().split('T')[0],
      'course_name': courseName,
      'tee_played': teePlayed,
      'course_par': coursePar,
      'course_slope': courseSlope,
      'course_rating': courseRating,
      'gross_score': grossScore,
      'net_score': netScore,
      'playing_handicap': playingHandicap,
      'differential': differential,
      'fairways_hit': fairwaysHit,
      'fairways_total': fairwaysTotal,
      'greens_in_regulation': greensInRegulation,
      'putts': putts,
      'penalties': penalties,
      'is_practice': isPractice,
      'is_counted_for_handicap': isCountedForHandicap,
      'notes': notes,
    };

    final response = await _supabase
        .from(TableNames.rounds)
        .insert(data)
        .select()
        .single();

    final round = Round.fromJson(_mapRoundFromDb(response));

    // Create hole scores if provided
    if (holeScores != null && holeScores.isNotEmpty) {
      await createHoleScores(round.id, holeScores);
    }

    return round;
  }

  /// Get round with scorecard
  Future<({Round round, Scorecard scorecard})?> getRoundWithScorecard(
    String roundId,
  ) async {
    final response = await _supabase
        .from(TableNames.rounds)
        .select()
        .eq('id', roundId)
        .maybeSingle();

    if (response == null) return null;

    final round = Round.fromJson(_mapRoundFromDb(response));
    final scorecard = await getScorecard(roundId, coursePar: round.coursePar);

    return (round: round, scorecard: scorecard);
  }

  Map<String, dynamic> _mapHoleScoreFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'roundId': row['round_id'],
      'holeNumber': row['hole_number'],
      'par': row['par'],
      'strokeIndex': row['stroke_index'],
      'strokes': row['strokes'],
      'putts': row['putts'],
      'fairwayHit': row['fairway_hit'],
      'greenInRegulation': row['green_in_regulation'],
      'sandSave': row['sand_save'],
      'upAndDown': row['up_and_down'],
      'penaltyStrokes': row['penalty_strokes'] ?? 0,
      'notes': row['notes'],
    };
  }

  Map<String, dynamic> _mapRoundFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'tournamentId': row['tournament_id'],
      'playerId': row['player_id'],
      'roundNumber': row['round_number'] ?? 1,
      'roundDate': row['round_date'],
      'courseName': row['course_name'],
      'teePlayed': row['tee_played'],
      'coursePar': row['course_par'],
      'courseSlope': row['course_slope']?.toDouble(),
      'courseRating': row['course_rating']?.toDouble(),
      'grossScore': row['gross_score'],
      'netScore': row['net_score'],
      'playingHandicap': row['playing_handicap']?.toDouble(),
      'differential': row['differential']?.toDouble(),
      'fairwaysHit': row['fairways_hit'],
      'fairwaysTotal': row['fairways_total'],
      'greensInRegulation': row['greens_in_regulation'],
      'putts': row['putts'],
      'penalties': row['penalties'] ?? 0,
      'isPractice': row['is_practice'] ?? false,
      'isCountedForHandicap': row['is_counted_for_handicap'] ?? true,
      'notes': row['notes'],
      'createdAt': row['created_at'],
      'updatedAt': row['updated_at'],
    };
  }
}
