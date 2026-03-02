import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../domain/training_session.dart';

class TrainingRepository {
  final _supabase = Supabase.instance.client;

  /// Get all training sessions for a player
  Future<List<TrainingSession>> getTrainingSessions(String playerId) async {
    final response = await _supabase
        .from(TableNames.trainingSessions)
        .select()
        .eq('player_id', playerId)
        .order('date', ascending: false);

    return (response as List).map((json) {
      return TrainingSession(
        id: json['id'] as String,
        playerId: json['player_id'] as String,
        date: DateTime.parse(json['date'] as String),
        type: TrainingType.fromValue(json['type'] as String),
        durationMinutes: json['duration_minutes'] as int,
        location: json['location'] as String?,
        intensity: json['intensity'] != null
            ? TrainingIntensity.values.firstWhere(
                (i) => i.name == json['intensity'],
                orElse: () => TrainingIntensity.moderate,
              )
            : null,
        focusAreas: (json['focus_areas'] as List?)
                ?.map((f) => TrainingFocus.values.firstWhere(
                      (tf) => tf.name == f,
                      orElse: () => TrainingFocus.technique,
                    ))
                .toList() ??
            [],
        notes: json['notes'] as String?,
        coachName: json['coach_name'] as String?,
        ballsHit: json['balls_hit'] as int?,
        puttsMade: json['putts_made'] as int?,
        puttsAttempted: json['putts_attempted'] as int?,
        rating: (json['rating'] as num?)?.toDouble(),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
      );
    }).toList();
  }

  /// Get training sessions for a date range
  Future<List<TrainingSession>> getSessionsInRange(
    String playerId,
    DateTime start,
    DateTime end,
  ) async {
    final response = await _supabase
        .from(TableNames.trainingSessions)
        .select()
        .eq('player_id', playerId)
        .gte('date', start.toIso8601String())
        .lte('date', end.toIso8601String())
        .order('date', ascending: false);

    return (response as List).map((json) {
      return TrainingSession(
        id: json['id'] as String,
        playerId: json['player_id'] as String,
        date: DateTime.parse(json['date'] as String),
        type: TrainingType.fromValue(json['type'] as String),
        durationMinutes: json['duration_minutes'] as int,
        location: json['location'] as String?,
        intensity: json['intensity'] != null
            ? TrainingIntensity.values.firstWhere(
                (i) => i.name == json['intensity'],
                orElse: () => TrainingIntensity.moderate,
              )
            : null,
        focusAreas: (json['focus_areas'] as List?)
                ?.map((f) => TrainingFocus.values.firstWhere(
                      (tf) => tf.name == f,
                      orElse: () => TrainingFocus.technique,
                    ))
                .toList() ??
            [],
        notes: json['notes'] as String?,
        coachName: json['coach_name'] as String?,
        ballsHit: json['balls_hit'] as int?,
        puttsMade: json['putts_made'] as int?,
        puttsAttempted: json['putts_attempted'] as int?,
        rating: (json['rating'] as num?)?.toDouble(),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
      );
    }).toList();
  }

  /// Add a new training session
  Future<TrainingSession> addSession({
    required String playerId,
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
    final data = {
      'player_id': playerId,
      'date': date.toIso8601String(),
      'type': type.value,
      'duration_minutes': durationMinutes,
      if (location != null) 'location': location,
      if (intensity != null) 'intensity': intensity.name,
      if (focusAreas != null && focusAreas.isNotEmpty)
        'focus_areas': focusAreas.map((f) => f.name).toList(),
      if (notes != null) 'notes': notes,
      if (coachName != null) 'coach_name': coachName,
      if (ballsHit != null) 'balls_hit': ballsHit,
      if (puttsMade != null) 'putts_made': puttsMade,
      if (puttsAttempted != null) 'putts_attempted': puttsAttempted,
      if (rating != null) 'rating': rating,
    };

    final response = await _supabase
        .from(TableNames.trainingSessions)
        .insert(data)
        .select()
        .single();

    return TrainingSession(
      id: response['id'] as String,
      playerId: response['player_id'] as String,
      date: DateTime.parse(response['date'] as String),
      type: TrainingType.fromValue(response['type'] as String),
      durationMinutes: response['duration_minutes'] as int,
      location: response['location'] as String?,
      intensity: response['intensity'] != null
          ? TrainingIntensity.values.firstWhere(
              (i) => i.name == response['intensity'],
              orElse: () => TrainingIntensity.moderate,
            )
          : null,
      focusAreas: (response['focus_areas'] as List?)
              ?.map((f) => TrainingFocus.values.firstWhere(
                    (tf) => tf.name == f,
                    orElse: () => TrainingFocus.technique,
                  ))
              .toList() ??
          [],
      notes: response['notes'] as String?,
      coachName: response['coach_name'] as String?,
      ballsHit: response['balls_hit'] as int?,
      puttsMade: response['putts_made'] as int?,
      puttsAttempted: response['putts_attempted'] as int?,
      rating: (response['rating'] as num?)?.toDouble(),
      createdAt: response['created_at'] != null
          ? DateTime.parse(response['created_at'] as String)
          : null,
    );
  }

  /// Delete a training session
  Future<void> deleteSession(String sessionId) async {
    await _supabase
        .from(TableNames.trainingSessions)
        .delete()
        .eq('id', sessionId);
  }

  /// Get weekly summary
  Future<TrainingSummary> getWeeklySummary(
    String playerId,
    DateTime weekStart,
  ) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final sessions = await getSessionsInRange(playerId, weekStart, weekEnd);

    final sessionsByType = <TrainingType, int>{};
    final minutesByType = <TrainingType, int>{};
    int totalMinutes = 0;
    int totalBallsHit = 0;
    double totalRating = 0;
    int ratingCount = 0;

    for (final session in sessions) {
      sessionsByType[session.type] =
          (sessionsByType[session.type] ?? 0) + 1;
      minutesByType[session.type] =
          (minutesByType[session.type] ?? 0) + session.durationMinutes;
      totalMinutes += session.durationMinutes;
      if (session.ballsHit != null) {
        totalBallsHit += session.ballsHit!;
      }
      if (session.rating != null) {
        totalRating += session.rating!;
        ratingCount++;
      }
    }

    return TrainingSummary(
      totalSessions: sessions.length,
      totalMinutes: totalMinutes,
      sessionsByType: sessionsByType,
      minutesByType: minutesByType,
      averageRating: ratingCount > 0 ? totalRating / ratingCount : 0,
      totalBallsHit: totalBallsHit,
    );
  }
}
