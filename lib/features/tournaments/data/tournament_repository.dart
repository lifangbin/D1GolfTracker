import '../domain/tournament.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/app_constants.dart';

class TournamentRepository {
  final SupabaseService _supabase;

  TournamentRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService.instance;

  /// Get all tournaments for a player
  Future<List<Tournament>> getTournaments(String playerId) async {
    final response = await _supabase
        .from(TableNames.tournaments)
        .select()
        .eq('player_id', playerId)
        .order('start_date', ascending: false);

    return (response as List)
        .map((row) => Tournament.fromJson(_mapTournamentFromDb(row)))
        .toList();
  }

  /// Get a single tournament by ID
  Future<Tournament?> getTournament(String id) async {
    final response = await _supabase
        .from(TableNames.tournaments)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return Tournament.fromJson(_mapTournamentFromDb(response));
  }

  /// Create a new tournament
  Future<Tournament> createTournament({
    required String playerId,
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
    final scoreToPar = (totalScore != null && coursePar != null)
        ? totalScore - coursePar
        : null;

    final data = {
      'player_id': playerId,
      'name': name,
      'tournament_type': tournamentType,
      'start_date': startDate.toIso8601String().split('T')[0],
      'end_date': endDate?.toIso8601String().split('T')[0],
      'course_name': courseName,
      'course_city': courseCity,
      'course_state': courseState,
      'course_par': coursePar,
      'course_slope': courseSlope,
      'course_rating': courseRating,
      'total_score': totalScore,
      'position': position,
      'field_size': fieldSize,
      'score_to_par': scoreToPar,
      'notes': notes,
      'weather_conditions': weatherConditions,
    };

    final response = await _supabase
        .from(TableNames.tournaments)
        .insert(data)
        .select()
        .single();

    return Tournament.fromJson(_mapTournamentFromDb(response));
  }

  /// Update a tournament
  Future<Tournament> updateTournament(Tournament tournament) async {
    final scoreToPar = (tournament.totalScore != null && tournament.coursePar != null)
        ? tournament.totalScore! - tournament.coursePar!
        : null;

    final data = {
      'name': tournament.name,
      'tournament_type': tournament.tournamentType,
      'start_date': tournament.startDate.toIso8601String().split('T')[0],
      'end_date': tournament.endDate?.toIso8601String().split('T')[0],
      'course_name': tournament.courseName,
      'course_city': tournament.courseCity,
      'course_state': tournament.courseState,
      'course_par': tournament.coursePar,
      'course_slope': tournament.courseSlope,
      'course_rating': tournament.courseRating,
      'total_score': tournament.totalScore,
      'position': tournament.position,
      'field_size': tournament.fieldSize,
      'score_to_par': scoreToPar,
      'notes': tournament.notes,
      'weather_conditions': tournament.weatherConditions,
    };

    final response = await _supabase
        .from(TableNames.tournaments)
        .update(data)
        .eq('id', tournament.id)
        .select()
        .single();

    return Tournament.fromJson(_mapTournamentFromDb(response));
  }

  /// Delete a tournament
  Future<void> deleteTournament(String id) async {
    await _supabase.from(TableNames.tournaments).delete().eq('id', id);
  }

  /// Get tournament count for a player
  Future<int> getTournamentCount(String playerId) async {
    final response = await _supabase
        .from(TableNames.tournaments)
        .select('id')
        .eq('player_id', playerId);

    return (response as List).length;
  }

  /// Get best finish for a player
  Future<int?> getBestFinish(String playerId) async {
    final response = await _supabase
        .from(TableNames.tournaments)
        .select('position')
        .eq('player_id', playerId)
        .not('position', 'is', null)
        .order('position', ascending: true)
        .limit(1)
        .maybeSingle();

    return response?['position'] as int?;
  }

  /// Get recent tournaments (limit)
  Future<List<Tournament>> getRecentTournaments(String playerId, {int limit = 5}) async {
    final response = await _supabase
        .from(TableNames.tournaments)
        .select()
        .eq('player_id', playerId)
        .order('start_date', ascending: false)
        .limit(limit);

    return (response as List)
        .map((row) => Tournament.fromJson(_mapTournamentFromDb(row)))
        .toList();
  }

  Map<String, dynamic> _mapTournamentFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'playerId': row['player_id'],
      'name': row['name'],
      'tournamentType': row['tournament_type'],
      'startDate': row['start_date'],
      'endDate': row['end_date'],
      'courseName': row['course_name'],
      'courseCity': row['course_city'],
      'courseState': row['course_state'],
      'courseCountry': row['course_country'] ?? 'Australia',
      'coursePar': row['course_par'],
      'courseSlope': row['course_slope']?.toDouble(),
      'courseRating': row['course_rating']?.toDouble(),
      'totalScore': row['total_score'],
      'position': row['position'],
      'fieldSize': row['field_size'],
      'scoreToPar': row['score_to_par'],
      'notes': row['notes'],
      'weatherConditions': row['weather_conditions'],
      'createdAt': row['created_at'],
      'updatedAt': row['updated_at'],
    };
  }

  // ============ Round Methods ============

  /// Get rounds for a tournament
  Future<List<Round>> getRoundsForTournament(String tournamentId) async {
    final response = await _supabase
        .from(TableNames.rounds)
        .select()
        .eq('tournament_id', tournamentId)
        .order('round_number', ascending: true);

    return (response as List)
        .map((row) => Round.fromJson(_mapRoundFromDb(row)))
        .toList();
  }

  /// Get all rounds for a player
  Future<List<Round>> getRoundsForPlayer(String playerId, {int? limit}) async {
    var query = _supabase
        .from(TableNames.rounds)
        .select()
        .eq('player_id', playerId)
        .order('round_date', ascending: false);

    if (limit != null) {
      query = query.limit(limit);
    }

    final response = await query;

    return (response as List)
        .map((row) => Round.fromJson(_mapRoundFromDb(row)))
        .toList();
  }

  /// Create a round
  Future<Round> createRound({
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
    int? netScore,
    int? fairwaysHit,
    int? fairwaysTotal,
    int? greensInRegulation,
    int? putts,
    int penalties = 0,
    bool isPractice = false,
    bool isCountedForHandicap = true,
    String? notes,
  }) async {
    // Calculate differential if we have the data
    double? differential;
    if (courseRating != null && courseSlope != null) {
      differential = ((grossScore - courseRating) * 113) / courseSlope;
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

    return Round.fromJson(_mapRoundFromDb(response));
  }

  /// Delete a round
  Future<void> deleteRound(String id) async {
    await _supabase.from(TableNames.rounds).delete().eq('id', id);
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
