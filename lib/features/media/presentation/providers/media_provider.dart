import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/media_repository.dart';
import '../../domain/media_item.dart';
import '../../../auth/presentation/providers/player_provider.dart';

/// Provider for MediaRepository
final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return MediaRepository();
});

/// Provider for player's media items
final playerMediaProvider =
    FutureProvider.family<List<MediaItem>, String>((ref, playerId) async {
  final repository = ref.watch(mediaRepositoryProvider);
  return repository.getPlayerMedia(playerId);
});

/// Provider for tournament media items
final tournamentMediaProvider =
    FutureProvider.family<List<MediaItem>, String>((ref, tournamentId) async {
  final repository = ref.watch(mediaRepositoryProvider);
  return repository.getTournamentMedia(tournamentId);
});

/// Provider for round media items
final roundMediaProvider =
    FutureProvider.family<List<MediaItem>, String>((ref, roundId) async {
  final repository = ref.watch(mediaRepositoryProvider);
  return repository.getRoundMedia(roundId);
});

/// Provider for highlights (recruiting)
final highlightsProvider =
    FutureProvider.family<List<MediaItem>, String>((ref, playerId) async {
  final repository = ref.watch(mediaRepositoryProvider);
  return repository.getHighlights(playerId);
});

/// Provider for single media item
final mediaItemProvider =
    FutureProvider.family<MediaItem?, String>((ref, id) async {
  final repository = ref.watch(mediaRepositoryProvider);
  return repository.getMediaItem(id);
});

/// State for media upload
class MediaUploadState {
  final bool isUploading;
  final double? progress;
  final String? error;
  final MediaItem? uploadedItem;

  MediaUploadState({
    this.isUploading = false,
    this.progress,
    this.error,
    this.uploadedItem,
  });

  MediaUploadState copyWith({
    bool? isUploading,
    double? progress,
    String? error,
    MediaItem? uploadedItem,
  }) {
    return MediaUploadState(
      isUploading: isUploading ?? this.isUploading,
      progress: progress ?? this.progress,
      error: error,
      uploadedItem: uploadedItem ?? this.uploadedItem,
    );
  }
}

/// Notifier for media upload operations
class MediaUploadNotifier extends StateNotifier<MediaUploadState> {
  final MediaRepository _repository;
  final Ref _ref;

  MediaUploadNotifier(this._repository, this._ref) : super(MediaUploadState());

  /// Take photo from camera
  Future<XFile?> takePhoto() async {
    return await _repository.pickPhotoFromCamera();
  }

  /// Pick photo from gallery
  Future<XFile?> pickPhoto() async {
    return await _repository.pickPhotoFromGallery();
  }

  /// Pick multiple photos
  Future<List<XFile>> pickMultiplePhotos() async {
    return await _repository.pickMultiplePhotos();
  }

  /// Record video from camera
  Future<XFile?> recordVideo() async {
    return await _repository.pickVideoFromCamera();
  }

  /// Pick video from gallery
  Future<XFile?> pickVideo() async {
    return await _repository.pickVideoFromGallery();
  }

  /// Upload a photo
  Future<MediaItem?> uploadPhoto({
    required XFile file,
    String? tournamentId,
    String? roundId,
    String? caption,
    MediaCategory category = MediaCategory.other,
    bool isHighlight = false,
    List<String> tags = const [],
  }) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) {
      state = state.copyWith(error: 'No player profile found');
      return null;
    }

    state = state.copyWith(isUploading: true, error: null);

    try {
      final item = await _repository.uploadPhoto(
        playerId: player.id,
        file: file,
        tournamentId: tournamentId,
        roundId: roundId,
        caption: caption,
        category: category,
        isHighlight: isHighlight,
        tags: tags,
      );

      state = state.copyWith(isUploading: false, uploadedItem: item);

      // Invalidate relevant providers
      _invalidateProviders(player.id, tournamentId, roundId);

      return item;
    } catch (e) {
      state = state.copyWith(isUploading: false, error: e.toString());
      return null;
    }
  }

  /// Upload a video
  Future<MediaItem?> uploadVideo({
    required XFile file,
    String? tournamentId,
    String? roundId,
    String? caption,
    MediaCategory category = MediaCategory.swing,
    bool isHighlight = false,
    int? durationSeconds,
    List<String> tags = const [],
  }) async {
    final player = _ref.read(playerNotifierProvider).valueOrNull;
    if (player == null) {
      state = state.copyWith(error: 'No player profile found');
      return null;
    }

    state = state.copyWith(isUploading: true, error: null);

    try {
      final item = await _repository.uploadVideo(
        playerId: player.id,
        file: file,
        tournamentId: tournamentId,
        roundId: roundId,
        caption: caption,
        category: category,
        isHighlight: isHighlight,
        durationSeconds: durationSeconds,
        tags: tags,
      );

      state = state.copyWith(isUploading: false, uploadedItem: item);

      // Invalidate relevant providers
      _invalidateProviders(player.id, tournamentId, roundId);

      return item;
    } catch (e) {
      state = state.copyWith(isUploading: false, error: e.toString());
      return null;
    }
  }

  /// Toggle highlight status
  Future<void> toggleHighlight(String id, {String? notes}) async {
    try {
      await _repository.toggleHighlight(id, notes: notes);
      final player = _ref.read(playerNotifierProvider).valueOrNull;
      if (player != null) {
        _ref.invalidate(highlightsProvider(player.id));
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Update media item
  Future<void> updateMediaItem({
    required String id,
    String? caption,
    String? description,
    MediaCategory? category,
    bool? isHighlight,
    String? highlightNotes,
    List<String>? tags,
  }) async {
    try {
      await _repository.updateMediaItem(
        id: id,
        caption: caption,
        description: description,
        category: category,
        isHighlight: isHighlight,
        highlightNotes: highlightNotes,
        tags: tags,
      );
      _ref.invalidate(mediaItemProvider(id));
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Delete media item
  Future<void> deleteMediaItem(String id) async {
    try {
      await _repository.deleteMediaItem(id);
      final player = _ref.read(playerNotifierProvider).valueOrNull;
      if (player != null) {
        _ref.invalidate(playerMediaProvider(player.id));
        _ref.invalidate(highlightsProvider(player.id));
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Reset state
  void reset() {
    state = MediaUploadState();
  }

  void _invalidateProviders(
      String playerId, String? tournamentId, String? roundId) {
    _ref.invalidate(playerMediaProvider(playerId));
    if (tournamentId != null) {
      _ref.invalidate(tournamentMediaProvider(tournamentId));
    }
    if (roundId != null) {
      _ref.invalidate(roundMediaProvider(roundId));
    }
  }
}

/// Provider for media upload notifier
final mediaUploadProvider =
    StateNotifierProvider<MediaUploadNotifier, MediaUploadState>((ref) {
  final repository = ref.watch(mediaRepositoryProvider);
  return MediaUploadNotifier(repository, ref);
});
