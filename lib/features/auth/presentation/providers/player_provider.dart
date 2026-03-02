import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/player.dart';
import '../../data/player_repository.dart';

/// Provider for PlayerRepository
final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return PlayerRepository();
});

/// Provider for current player profile
final currentPlayerProvider = FutureProvider<Player?>((ref) async {
  final repository = ref.watch(playerRepositoryProvider);
  return repository.getCurrentPlayer();
});

/// StateNotifier for player state management
class PlayerNotifier extends StateNotifier<AsyncValue<Player?>> {
  final PlayerRepository _repository;

  PlayerNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadPlayer();
  }

  Future<void> loadPlayer() async {
    state = const AsyncValue.loading();
    try {
      final player = await _repository.getCurrentPlayer();
      state = AsyncValue.data(player);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createPlayer({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    String? gender,
    String? gaNumber,
    String? homeCourse,
  }) async {
    state = const AsyncValue.loading();
    try {
      final player = await _repository.createPlayer(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        gaNumber: gaNumber,
        homeCourse: homeCourse,
      );
      state = AsyncValue.data(player);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updatePlayer(Player player) async {
    try {
      final updated = await _repository.updatePlayer(player);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateAvatarUrl(String avatarUrl) async {
    final currentPlayer = state.valueOrNull;
    if (currentPlayer == null) return;

    try {
      await _repository.updateAvatarUrl(currentPlayer.id, avatarUrl);
      state = AsyncValue.data(currentPlayer.copyWith(avatarUrl: avatarUrl));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateGAConnect({
    required String gaNumber,
    required double handicap,
  }) async {
    final currentPlayer = state.valueOrNull;
    if (currentPlayer == null) return;

    try {
      final updated = await _repository.updatePlayer(
        currentPlayer.copyWith(
          gaNumber: gaNumber,
          currentHandicap: handicap,
          gaConnected: true,
          gaLastSync: DateTime.now(),
        ),
      );
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for PlayerNotifier
final playerNotifierProvider =
    StateNotifierProvider<PlayerNotifier, AsyncValue<Player?>>((ref) {
  final repository = ref.watch(playerRepositoryProvider);
  return PlayerNotifier(repository);
});

/// Provider to check if player profile exists
final hasPlayerProfileProvider = Provider<bool>((ref) {
  final playerAsync = ref.watch(playerNotifierProvider);
  return playerAsync.valueOrNull != null;
});
