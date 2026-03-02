import '../../../core/constants/app_constants.dart';
import '../../../core/services/supabase_service.dart';
import '../domain/milestone.dart';

class MilestoneRepository {
  final SupabaseService _supabase;

  MilestoneRepository({SupabaseService? supabase})
      : _supabase = supabase ?? SupabaseService.instance;

  // ============ Player Milestone Progress ============

  /// Get all milestone progress for a player
  Future<List<PlayerMilestone>> getPlayerMilestones(String playerId) async {
    try {
      final response = await _supabase
          .from(TableNames.playerMilestones)
          .select()
          .eq('player_id', playerId);

      return (response as List)
          .map((row) => PlayerMilestone.fromJson(_mapFromDb(row)))
          .toList();
    } catch (e) {
      // If table doesn't exist or query fails, return empty list
      return [];
    }
  }

  /// Get milestones with progress for a specific phase
  Future<List<MilestoneWithProgress>> getMilestonesForPhase(
    String playerId,
    int phase,
  ) async {
    // Get all definitions for this phase
    final definitions = PhaseMilestones.forPhase(phase);

    // Get player progress for these milestones
    final milestoneIds = definitions.map((d) => d.id).toList();

    try {
      final response = await _supabase
          .from(TableNames.playerMilestones)
          .select()
          .eq('player_id', playerId)
          .inFilter('milestone_id', milestoneIds);

      final progressMap = <String, PlayerMilestone>{};
      for (final row in response as List) {
        final pm = PlayerMilestone.fromJson(_mapFromDb(row));
        progressMap[pm.milestoneId] = pm;
      }

      return definitions.map((definition) {
        return MilestoneWithProgress(
          definition: definition,
          progress: progressMap[definition.id],
        );
      }).toList();
    } catch (e) {
      // If table doesn't exist or query fails, return definitions without progress
      return definitions.map((definition) {
        return MilestoneWithProgress(
          definition: definition,
          progress: null,
        );
      }).toList();
    }
  }

  /// Get all milestones with progress for a player (all phases)
  Future<List<MilestoneWithProgress>> getAllMilestonesWithProgress(
    String playerId,
  ) async {
    final playerMilestones = await getPlayerMilestones(playerId);

    final progressMap = <String, PlayerMilestone>{};
    for (final pm in playerMilestones) {
      progressMap[pm.milestoneId] = pm;
    }

    return PhaseMilestones.all.map((definition) {
      return MilestoneWithProgress(
        definition: definition,
        progress: progressMap[definition.id],
      );
    }).toList();
  }

  /// Complete a milestone
  Future<PlayerMilestone> completeMilestone({
    required String playerId,
    required String milestoneId,
    String? notes,
    String? mediaUrl,
  }) async {
    final existing = await _getExistingProgress(playerId, milestoneId);

    if (existing != null) {
      // Update existing
      final response = await _supabase
          .from(TableNames.playerMilestones)
          .update({
            'is_completed': true,
            'completed_at': DateTime.now().toIso8601String(),
            'notes': notes,
            'media_url': mediaUrl,
          })
          .eq('id', existing.id)
          .select()
          .single();

      return PlayerMilestone.fromJson(_mapFromDb(response));
    } else {
      // Insert new
      final response = await _supabase
          .from(TableNames.playerMilestones)
          .insert({
            'player_id': playerId,
            'milestone_id': milestoneId,
            'is_completed': true,
            'completed_at': DateTime.now().toIso8601String(),
            'notes': notes,
            'media_url': mediaUrl,
          })
          .select()
          .single();

      return PlayerMilestone.fromJson(_mapFromDb(response));
    }
  }

  /// Uncomplete a milestone (mark as not done)
  Future<PlayerMilestone> uncompleteMilestone({
    required String playerId,
    required String milestoneId,
  }) async {
    final existing = await _getExistingProgress(playerId, milestoneId);

    if (existing != null) {
      final response = await _supabase
          .from(TableNames.playerMilestones)
          .update({
            'is_completed': false,
            'completed_at': null,
          })
          .eq('id', existing.id)
          .select()
          .single();

      return PlayerMilestone.fromJson(_mapFromDb(response));
    } else {
      // Insert with not completed status
      final response = await _supabase
          .from(TableNames.playerMilestones)
          .insert({
            'player_id': playerId,
            'milestone_id': milestoneId,
            'is_completed': false,
          })
          .select()
          .single();

      return PlayerMilestone.fromJson(_mapFromDb(response));
    }
  }

  /// Toggle milestone completion
  Future<PlayerMilestone> toggleMilestone({
    required String playerId,
    required String milestoneId,
    String? notes,
  }) async {
    final existing = await _getExistingProgress(playerId, milestoneId);
    final isCurrentlyCompleted = existing?.isCompleted ?? false;

    if (isCurrentlyCompleted) {
      return uncompleteMilestone(playerId: playerId, milestoneId: milestoneId);
    } else {
      return completeMilestone(
        playerId: playerId,
        milestoneId: milestoneId,
        notes: notes,
      );
    }
  }

  /// Update milestone notes
  Future<PlayerMilestone> updateMilestoneNotes({
    required String id,
    String? notes,
  }) async {
    final response = await _supabase
        .from(TableNames.playerMilestones)
        .update({'notes': notes})
        .eq('id', id)
        .select()
        .single();

    return PlayerMilestone.fromJson(_mapFromDb(response));
  }

  /// Get completion stats for a player
  Future<Map<int, MilestoneStats>> getCompletionStats(String playerId) async {
    try {
      final milestones = await getAllMilestonesWithProgress(playerId);

      final stats = <int, MilestoneStats>{};
      for (var phase = 1; phase <= 4; phase++) {
        final phaseMilestones =
            milestones.where((m) => m.definition.phase == phase).toList();
        final completed = phaseMilestones.where((m) => m.isCompleted).length;
        final total = phaseMilestones.length;
        stats[phase] = MilestoneStats(completed: completed, total: total);
      }

      return stats;
    } catch (e) {
      // Return empty stats on error
      final stats = <int, MilestoneStats>{};
      for (var phase = 1; phase <= 4; phase++) {
        final total = PhaseMilestones.forPhase(phase).length;
        stats[phase] = MilestoneStats(completed: 0, total: total);
      }
      return stats;
    }
  }

  // ============ Helper Methods ============

  Future<PlayerMilestone?> _getExistingProgress(
    String playerId,
    String milestoneId,
  ) async {
    final response = await _supabase
        .from(TableNames.playerMilestones)
        .select()
        .eq('player_id', playerId)
        .eq('milestone_id', milestoneId)
        .maybeSingle();

    if (response == null) return null;
    return PlayerMilestone.fromJson(_mapFromDb(response));
  }

  Map<String, dynamic> _mapFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'playerId': row['player_id'],
      'milestoneId': row['milestone_id'],
      'isCompleted': row['is_completed'] ?? false,
      'completedAt': row['completed_at'],
      'notes': row['notes'],
      'mediaUrl': row['media_url'],
      'createdAt': row['created_at'],
      'updatedAt': row['updated_at'],
    };
  }
}

/// Stats for milestone completion
class MilestoneStats {
  final int completed;
  final int total;

  const MilestoneStats({required this.completed, required this.total});

  double get percentage => total > 0 ? completed / total : 0;
  String get displayText => '$completed/$total';
}
