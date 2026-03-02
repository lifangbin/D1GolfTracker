import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

/// Offline cache service using Hive for local storage
class OfflineCacheService {
  static const String _playerBox = 'player_cache';
  static const String _tournamentsBox = 'tournaments_cache';
  static const String _coursesBox = 'courses_cache';
  static const String _handicapBox = 'handicap_cache';
  static const String _milestonesBox = 'milestones_cache';
  static const String _trainingBox = 'training_cache';
  static const String _settingsBox = 'settings';

  static OfflineCacheService? _instance;
  static OfflineCacheService get instance {
    _instance ??= OfflineCacheService._();
    return _instance!;
  }

  OfflineCacheService._();

  /// Initialize Hive and open boxes
  Future<void> init() async {
    await Hive.initFlutter();

    // Open all boxes
    await Future.wait([
      Hive.openBox<String>(_playerBox),
      Hive.openBox<String>(_tournamentsBox),
      Hive.openBox<String>(_coursesBox),
      Hive.openBox<String>(_handicapBox),
      Hive.openBox<String>(_milestonesBox),
      Hive.openBox<String>(_trainingBox),
      Hive.openBox<dynamic>(_settingsBox),
    ]);
  }

  // ==================== Player Cache ====================

  /// Cache player data
  Future<void> cachePlayer(String playerId, Map<String, dynamic> data) async {
    final box = Hive.box<String>(_playerBox);
    await box.put(playerId, jsonEncode({
      ...data,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached player data
  Map<String, dynamic>? getCachedPlayer(String playerId) {
    final box = Hive.box<String>(_playerBox);
    final cached = box.get(playerId);
    if (cached != null) {
      return jsonDecode(cached) as Map<String, dynamic>;
    }
    return null;
  }

  // ==================== Tournaments Cache ====================

  /// Cache tournaments list
  Future<void> cacheTournaments(
    String playerId,
    List<Map<String, dynamic>> tournaments,
  ) async {
    final box = Hive.box<String>(_tournamentsBox);
    await box.put(playerId, jsonEncode({
      'tournaments': tournaments,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached tournaments
  List<Map<String, dynamic>>? getCachedTournaments(String playerId) {
    final box = Hive.box<String>(_tournamentsBox);
    final cached = box.get(playerId);
    if (cached != null) {
      final data = jsonDecode(cached) as Map<String, dynamic>;
      return (data['tournaments'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
    return null;
  }

  /// Cache single tournament
  Future<void> cacheTournament(
    String tournamentId,
    Map<String, dynamic> tournament,
  ) async {
    final box = Hive.box<String>(_tournamentsBox);
    await box.put('tournament_$tournamentId', jsonEncode({
      ...tournament,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached tournament
  Map<String, dynamic>? getCachedTournament(String tournamentId) {
    final box = Hive.box<String>(_tournamentsBox);
    final cached = box.get('tournament_$tournamentId');
    if (cached != null) {
      return jsonDecode(cached) as Map<String, dynamic>;
    }
    return null;
  }

  // ==================== Courses Cache ====================

  /// Cache course data (90 day TTL)
  Future<void> cacheCourse(
    String courseId,
    Map<String, dynamic> course,
  ) async {
    final box = Hive.box<String>(_coursesBox);
    await box.put(courseId, jsonEncode({
      ...course,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached course
  Map<String, dynamic>? getCachedCourse(String courseId) {
    final box = Hive.box<String>(_coursesBox);
    final cached = box.get(courseId);
    if (cached != null) {
      final data = jsonDecode(cached) as Map<String, dynamic>;
      final cachedAt = DateTime.tryParse(data['_cachedAt'] ?? '');
      if (cachedAt != null) {
        // Check if cache is still valid (90 days)
        if (DateTime.now().difference(cachedAt).inDays < 90) {
          return data;
        }
      }
    }
    return null;
  }

  /// Cache favorite courses
  Future<void> cacheFavoriteCourses(List<String> courseIds) async {
    final box = Hive.box<String>(_coursesBox);
    await box.put('_favorites', jsonEncode(courseIds));
  }

  /// Get favorite course IDs
  List<String> getFavoriteCourses() {
    final box = Hive.box<String>(_coursesBox);
    final cached = box.get('_favorites');
    if (cached != null) {
      return (jsonDecode(cached) as List).cast<String>();
    }
    return [];
  }

  // ==================== Handicap Cache ====================

  /// Cache handicap history
  Future<void> cacheHandicapHistory(
    String playerId,
    List<Map<String, dynamic>> history,
  ) async {
    final box = Hive.box<String>(_handicapBox);
    await box.put(playerId, jsonEncode({
      'history': history,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached handicap history
  List<Map<String, dynamic>>? getCachedHandicapHistory(String playerId) {
    final box = Hive.box<String>(_handicapBox);
    final cached = box.get(playerId);
    if (cached != null) {
      final data = jsonDecode(cached) as Map<String, dynamic>;
      return (data['history'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
    return null;
  }

  // ==================== Training Cache ====================

  /// Cache training sessions
  Future<void> cacheTrainingSessions(
    String playerId,
    List<Map<String, dynamic>> sessions,
  ) async {
    final box = Hive.box<String>(_trainingBox);
    await box.put(playerId, jsonEncode({
      'sessions': sessions,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached training sessions
  List<Map<String, dynamic>>? getCachedTrainingSessions(String playerId) {
    final box = Hive.box<String>(_trainingBox);
    final cached = box.get(playerId);
    if (cached != null) {
      final data = jsonDecode(cached) as Map<String, dynamic>;
      return (data['sessions'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
    return null;
  }

  // ==================== Milestones Cache ====================

  /// Cache milestones
  Future<void> cacheMilestones(
    String playerId,
    List<Map<String, dynamic>> milestones,
  ) async {
    final box = Hive.box<String>(_milestonesBox);
    await box.put(playerId, jsonEncode({
      'milestones': milestones,
      '_cachedAt': DateTime.now().toIso8601String(),
    }));
  }

  /// Get cached milestones
  List<Map<String, dynamic>>? getCachedMilestones(String playerId) {
    final box = Hive.box<String>(_milestonesBox);
    final cached = box.get(playerId);
    if (cached != null) {
      final data = jsonDecode(cached) as Map<String, dynamic>;
      return (data['milestones'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
    return null;
  }

  // ==================== Pending Operations ====================

  /// Queue an operation for when online
  Future<void> queueOfflineOperation({
    required String type,
    required String table,
    required Map<String, dynamic> data,
  }) async {
    final box = Hive.box<dynamic>(_settingsBox);
    final queue = (box.get('_pendingOperations') as List?) ?? [];
    queue.add({
      'type': type,
      'table': table,
      'data': data,
      'queuedAt': DateTime.now().toIso8601String(),
    });
    await box.put('_pendingOperations', queue);
  }

  /// Get pending operations
  List<Map<String, dynamic>> getPendingOperations() {
    final box = Hive.box<dynamic>(_settingsBox);
    final queue = box.get('_pendingOperations') as List?;
    if (queue != null) {
      return queue.map((e) => e as Map<String, dynamic>).toList();
    }
    return [];
  }

  /// Clear pending operations
  Future<void> clearPendingOperations() async {
    final box = Hive.box<dynamic>(_settingsBox);
    await box.delete('_pendingOperations');
  }

  // ==================== Settings ====================

  /// Save a setting
  Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box<dynamic>(_settingsBox);
    await box.put(key, value);
  }

  /// Get a setting
  T? getSetting<T>(String key, {T? defaultValue}) {
    final box = Hive.box<dynamic>(_settingsBox);
    return box.get(key, defaultValue: defaultValue) as T?;
  }

  /// Get last sync time
  DateTime? getLastSyncTime(String key) {
    final box = Hive.box<dynamic>(_settingsBox);
    final timestamp = box.get('lastSync_$key') as String?;
    if (timestamp != null) {
      return DateTime.tryParse(timestamp);
    }
    return null;
  }

  /// Set last sync time
  Future<void> setLastSyncTime(String key) async {
    final box = Hive.box<dynamic>(_settingsBox);
    await box.put('lastSync_$key', DateTime.now().toIso8601String());
  }

  // ==================== Utility ====================

  /// Clear all caches
  Future<void> clearAllCaches() async {
    await Future.wait([
      Hive.box<String>(_playerBox).clear(),
      Hive.box<String>(_tournamentsBox).clear(),
      Hive.box<String>(_coursesBox).clear(),
      Hive.box<String>(_handicapBox).clear(),
      Hive.box<String>(_milestonesBox).clear(),
      Hive.box<String>(_trainingBox).clear(),
    ]);
  }

  /// Check if data is stale (older than specified hours)
  bool isStale(Map<String, dynamic> data, {int maxHours = 24}) {
    final cachedAt = DateTime.tryParse(data['_cachedAt'] ?? '');
    if (cachedAt == null) return true;
    return DateTime.now().difference(cachedAt).inHours > maxHours;
  }

  /// Get cache size in bytes (approximate)
  Future<int> getCacheSize() async {
    int totalSize = 0;
    for (final boxName in [
      _playerBox,
      _tournamentsBox,
      _coursesBox,
      _handicapBox,
      _milestonesBox,
      _trainingBox,
    ]) {
      final box = Hive.box<String>(boxName);
      for (final key in box.keys) {
        final value = box.get(key);
        if (value != null) {
          totalSize += value.length;
        }
      }
    }
    return totalSize;
  }
}
