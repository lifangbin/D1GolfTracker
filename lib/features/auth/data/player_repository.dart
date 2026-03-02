import '../domain/player.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/constants/app_constants.dart';

/// Repository for Player CRUD operations
class PlayerRepository {
  final SupabaseService _supabase;

  PlayerRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService.instance;

  /// Get player by user ID
  Future<Player?> getPlayerByUserId(String userId) async {
    final response = await _supabase
        .from(TableNames.players)
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return Player.fromJson(_mapFromDb(response));
  }

  /// Get current user's player profile
  Future<Player?> getCurrentPlayer() async {
    final userId = _supabase.currentUser?.id;
    if (userId == null) return null;
    return getPlayerByUserId(userId);
  }

  /// Create a new player profile
  Future<Player> createPlayer({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? gaNumber,
    String? homeCourse,
  }) async {
    final userId = _supabase.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final data = {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String().split('T')[0],
      'gender': gender,
      'ga_number': gaNumber,
      'home_course': homeCourse,
      'current_phase': _calculatePhase(dateOfBirth),
    };

    final response = await _supabase
        .from(TableNames.players)
        .insert(data)
        .select()
        .single();

    return Player.fromJson(_mapFromDb(response));
  }

  /// Update player profile
  Future<Player> updatePlayer(Player player) async {
    final data = {
      'first_name': player.firstName,
      'last_name': player.lastName,
      'date_of_birth': player.dateOfBirth.toIso8601String().split('T')[0],
      'gender': player.gender,
      'ga_number': player.gaNumber,
      'ga_connected': player.gaConnected,
      'current_handicap': player.currentHandicap,
      'current_phase': player.currentPhase,
      'home_course': player.homeCourse,
      'avatar_url': player.avatarUrl,
    };

    final response = await _supabase
        .from(TableNames.players)
        .update(data)
        .eq('id', player.id)
        .select()
        .single();

    return Player.fromJson(_mapFromDb(response));
  }

  /// Update player avatar URL
  Future<void> updateAvatarUrl(String playerId, String avatarUrl) async {
    await _supabase
        .from(TableNames.players)
        .update({'avatar_url': avatarUrl})
        .eq('id', playerId);
  }

  /// Update handicap
  Future<void> updateHandicap(String playerId, double handicap) async {
    await _supabase
        .from(TableNames.players)
        .update({'current_handicap': handicap})
        .eq('id', playerId);
  }

  /// Calculate phase based on age
  int _calculatePhase(DateTime dateOfBirth) {
    final age = DateTime.now().year - dateOfBirth.year;
    if (age <= 10) return 1;
    if (age <= 13) return 2;
    if (age <= 15) return 3;
    return 4;
  }

  /// Map database column names to Dart field names
  Map<String, dynamic> _mapFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'userId': row['user_id'],
      'firstName': row['first_name'],
      'lastName': row['last_name'],
      'dateOfBirth': row['date_of_birth'],
      'gender': row['gender'],
      'avatarUrl': row['avatar_url'],
      'gaNumber': row['ga_number'],
      'gaConnected': row['ga_connected'] ?? false,
      'gaLastSync': row['ga_last_sync'],
      'currentHandicap': row['current_handicap']?.toDouble(),
      'currentPhase': row['current_phase'] ?? 1,
      'homeCourse': row['home_course'],
      'createdAt': row['created_at'],
      'updatedAt': row['updated_at'],
    };
  }
}
