import '../domain/handicap_entry.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/app_constants.dart';

class HandicapRepository {
  final SupabaseService _supabase;

  HandicapRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService.instance;

  /// Get all handicap history for a player
  Future<List<HandicapEntry>> getHandicapHistory(String playerId) async {
    final response = await _supabase
        .from(TableNames.handicapHistory)
        .select()
        .eq('player_id', playerId)
        .order('effective_date', ascending: false);

    return (response as List)
        .map((row) => HandicapEntry.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Get the current (most recent) handicap entry
  Future<HandicapEntry?> getCurrentHandicap(String playerId) async {
    final response = await _supabase
        .from(TableNames.handicapHistory)
        .select()
        .eq('player_id', playerId)
        .order('effective_date', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return HandicapEntry.fromJson(_mapFromDb(response));
  }

  /// Get handicap history for a specific date range
  Future<List<HandicapEntry>> getHandicapHistoryRange(
    String playerId, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _supabase
        .from(TableNames.handicapHistory)
        .select()
        .eq('player_id', playerId)
        .gte('effective_date', startDate.toIso8601String().split('T')[0])
        .lte('effective_date', endDate.toIso8601String().split('T')[0])
        .order('effective_date', ascending: true);

    return (response as List)
        .map((row) => HandicapEntry.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Add a new handicap entry
  Future<HandicapEntry> addHandicapEntry({
    required String playerId,
    required double handicapIndex,
    double? lowHandicap,
    required DateTime effectiveDate,
    required String source,
    int? roundsCounted,
  }) async {
    final data = {
      'player_id': playerId,
      'handicap_index': handicapIndex,
      'low_handicap': lowHandicap,
      'effective_date': effectiveDate.toIso8601String().split('T')[0],
      'source': source,
      'rounds_counted': roundsCounted,
    };

    final response = await _supabase
        .from(TableNames.handicapHistory)
        .insert(data)
        .select()
        .single();

    // Also update the player's current handicap
    await _updatePlayerCurrentHandicap(playerId, handicapIndex);

    return HandicapEntry.fromJson(_mapFromDb(response));
  }

  /// Update an existing handicap entry
  Future<HandicapEntry> updateHandicapEntry(HandicapEntry entry) async {
    final data = {
      'handicap_index': entry.handicapIndex,
      'low_handicap': entry.lowHandicap,
      'effective_date': entry.effectiveDate.toIso8601String().split('T')[0],
      'source': entry.source,
      'rounds_counted': entry.roundsCounted,
    };

    final response = await _supabase
        .from(TableNames.handicapHistory)
        .update(data)
        .eq('id', entry.id)
        .select()
        .single();

    return HandicapEntry.fromJson(_mapFromDb(response));
  }

  /// Delete a handicap entry
  Future<void> deleteHandicapEntry(String id) async {
    await _supabase.from(TableNames.handicapHistory).delete().eq('id', id);
  }

  /// Get the lowest handicap ever recorded for a player
  Future<double?> getLowestHandicap(String playerId) async {
    final response = await _supabase
        .from(TableNames.handicapHistory)
        .select('handicap_index')
        .eq('player_id', playerId)
        .order('handicap_index', ascending: true)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return (response['handicap_index'] as num).toDouble();
  }

  /// Get handicap trend (last N entries)
  Future<List<HandicapEntry>> getHandicapTrend(String playerId, {int limit = 12}) async {
    final response = await _supabase
        .from(TableNames.handicapHistory)
        .select()
        .eq('player_id', playerId)
        .order('effective_date', ascending: false)
        .limit(limit);

    // Return in chronological order for charting
    final entries = (response as List)
        .map((row) => HandicapEntry.fromJson(_mapFromDb(row)))
        .toList();

    return entries.reversed.toList();
  }

  /// Calculate handicap change over a period
  Future<double?> getHandicapChange(String playerId, {int daysBack = 30}) async {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: daysBack));

    final history = await getHandicapHistoryRange(
      playerId,
      startDate: startDate,
      endDate: now,
    );

    if (history.length < 2) return null;

    final oldest = history.first.handicapIndex;
    final newest = history.last.handicapIndex;

    return newest - oldest;
  }

  /// Update player's current handicap in the players table
  Future<void> _updatePlayerCurrentHandicap(String playerId, double handicap) async {
    await _supabase
        .from(TableNames.players)
        .update({'current_handicap': handicap})
        .eq('id', playerId);
  }

  Map<String, dynamic> _mapFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'playerId': row['player_id'],
      'handicapIndex': (row['handicap_index'] as num).toDouble(),
      'lowHandicap': row['low_handicap'] != null
          ? (row['low_handicap'] as num).toDouble()
          : null,
      'effectiveDate': row['effective_date'],
      'source': row['source'] ?? 'manual',
      'roundsCounted': row['rounds_counted'],
      'createdAt': row['created_at'],
    };
  }
}
