import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/services/supabase_service.dart';
import '../domain/media_item.dart';

class MediaRepository {
  final SupabaseService _supabase;
  final ImagePicker _imagePicker;
  final Uuid _uuid;

  MediaRepository({
    SupabaseService? supabase,
    ImagePicker? imagePicker,
  })  : _supabase = supabase ?? SupabaseService.instance,
        _imagePicker = imagePicker ?? ImagePicker(),
        _uuid = const Uuid();

  // ============ Camera & Gallery ============

  /// Pick photo from camera
  Future<XFile?> pickPhotoFromCamera() async {
    return await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: AppConstants.photoMaxWidth.toDouble(),
      imageQuality: AppConstants.photoQuality,
    );
  }

  /// Pick photo from gallery
  Future<XFile?> pickPhotoFromGallery() async {
    return await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: AppConstants.photoMaxWidth.toDouble(),
      imageQuality: AppConstants.photoQuality,
    );
  }

  /// Pick multiple photos from gallery
  Future<List<XFile>> pickMultiplePhotos() async {
    return await _imagePicker.pickMultiImage(
      maxWidth: AppConstants.photoMaxWidth.toDouble(),
      imageQuality: AppConstants.photoQuality,
    );
  }

  /// Pick video from camera
  Future<XFile?> pickVideoFromCamera() async {
    return await _imagePicker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: AppConstants.maxVideoSeconds),
    );
  }

  /// Pick video from gallery
  Future<XFile?> pickVideoFromGallery() async {
    return await _imagePicker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(seconds: AppConstants.maxVideoSeconds),
    );
  }

  // ============ Upload ============

  /// Upload a photo and create media item record
  Future<MediaItem> uploadPhoto({
    required String playerId,
    required XFile file,
    String? tournamentId,
    String? roundId,
    String? caption,
    MediaCategory category = MediaCategory.other,
    bool isHighlight = false,
    List<String> tags = const [],
  }) async {
    final fileBytes = await file.readAsBytes();
    final fileName = _basename(file.path);
    final extension = _extension(fileName).toLowerCase();
    final storagePath = _generateStoragePath(playerId, 'photo', extension);

    // Upload to storage
    await _supabase.uploadFile(
      bucket: StorageBuckets.tournamentMedia,
      path: storagePath,
      fileBytes: fileBytes,
      contentType: _getContentType(extension),
    );

    // Get public URL
    final url = _supabase.getPublicUrl(
      bucket: StorageBuckets.tournamentMedia,
      path: storagePath,
    );

    // Create database record
    final mediaItem = await _createMediaRecord(
      playerId: playerId,
      tournamentId: tournamentId,
      roundId: roundId,
      mediaType: MediaType.photo,
      category: category,
      storagePath: storagePath,
      originalFilename: fileName,
      url: url,
      caption: caption,
      tags: tags,
      isHighlight: isHighlight,
      fileSizeBytes: fileBytes.length,
    );

    return mediaItem;
  }

  /// Upload a video and create media item record
  Future<MediaItem> uploadVideo({
    required String playerId,
    required XFile file,
    String? tournamentId,
    String? roundId,
    String? caption,
    MediaCategory category = MediaCategory.swing,
    bool isHighlight = false,
    int? durationSeconds,
    List<String> tags = const [],
  }) async {
    final fileBytes = await file.readAsBytes();
    final fileName = _basename(file.path);
    final extension = _extension(fileName).toLowerCase();
    final storagePath = _generateStoragePath(playerId, 'video', extension);

    // Check file size
    final fileSizeMB = fileBytes.length / (1024 * 1024);
    if (fileSizeMB > AppConstants.maxFileSizeMB) {
      throw Exception(
          'Video file too large. Maximum size is ${AppConstants.maxFileSizeMB}MB');
    }

    // Upload to storage
    await _supabase.uploadFile(
      bucket: StorageBuckets.tournamentMedia,
      path: storagePath,
      fileBytes: fileBytes,
      contentType: _getContentType(extension),
    );

    // Get public URL
    final url = _supabase.getPublicUrl(
      bucket: StorageBuckets.tournamentMedia,
      path: storagePath,
    );

    // Create database record
    final mediaItem = await _createMediaRecord(
      playerId: playerId,
      tournamentId: tournamentId,
      roundId: roundId,
      mediaType: MediaType.video,
      category: category,
      storagePath: storagePath,
      originalFilename: fileName,
      url: url,
      caption: caption,
      tags: tags,
      isHighlight: isHighlight,
      fileSizeBytes: fileBytes.length,
      durationSeconds: durationSeconds,
    );

    return mediaItem;
  }

  /// Upload from file bytes directly
  Future<MediaItem> uploadFromBytes({
    required String playerId,
    required Uint8List bytes,
    required String filename,
    required MediaType mediaType,
    String? tournamentId,
    String? roundId,
    String? caption,
    MediaCategory category = MediaCategory.other,
    bool isHighlight = false,
    List<String> tags = const [],
  }) async {
    final extension = _extension(filename).toLowerCase();
    final typePrefix = mediaType == MediaType.photo ? 'photo' : 'video';
    final storagePath = _generateStoragePath(playerId, typePrefix, extension);

    // Upload to storage
    await _supabase.uploadFile(
      bucket: StorageBuckets.tournamentMedia,
      path: storagePath,
      fileBytes: bytes,
      contentType: _getContentType(extension),
    );

    // Get public URL
    final url = _supabase.getPublicUrl(
      bucket: StorageBuckets.tournamentMedia,
      path: storagePath,
    );

    // Create database record
    return await _createMediaRecord(
      playerId: playerId,
      tournamentId: tournamentId,
      roundId: roundId,
      mediaType: mediaType,
      category: category,
      storagePath: storagePath,
      originalFilename: filename,
      url: url,
      caption: caption,
      tags: tags,
      isHighlight: isHighlight,
      fileSizeBytes: bytes.length,
    );
  }

  // ============ CRUD Operations ============

  /// Get all media items for a player
  Future<List<MediaItem>> getPlayerMedia(String playerId) async {
    final response = await _supabase
        .from(TableNames.mediaItems)
        .select()
        .eq('player_id', playerId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => MediaItem.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Get media items for a tournament
  Future<List<MediaItem>> getTournamentMedia(String tournamentId) async {
    final response = await _supabase
        .from(TableNames.mediaItems)
        .select()
        .eq('tournament_id', tournamentId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => MediaItem.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Get media items for a round
  Future<List<MediaItem>> getRoundMedia(String roundId) async {
    final response = await _supabase
        .from(TableNames.mediaItems)
        .select()
        .eq('round_id', roundId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => MediaItem.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Get highlight media for recruiting
  Future<List<MediaItem>> getHighlights(String playerId) async {
    final response = await _supabase
        .from(TableNames.mediaItems)
        .select()
        .eq('player_id', playerId)
        .eq('is_highlight', true)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => MediaItem.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Get media by category
  Future<List<MediaItem>> getMediaByCategory(
    String playerId,
    MediaCategory category,
  ) async {
    final response = await _supabase
        .from(TableNames.mediaItems)
        .select()
        .eq('player_id', playerId)
        .eq('category', category.name)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => MediaItem.fromJson(_mapFromDb(row)))
        .toList();
  }

  /// Get single media item
  Future<MediaItem?> getMediaItem(String id) async {
    final response = await _supabase
        .from(TableNames.mediaItems)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return MediaItem.fromJson(_mapFromDb(response));
  }

  /// Update media item
  Future<MediaItem> updateMediaItem({
    required String id,
    String? caption,
    String? description,
    MediaCategory? category,
    bool? isHighlight,
    String? highlightNotes,
    List<String>? tags,
  }) async {
    final data = <String, dynamic>{};
    if (caption != null) data['caption'] = caption;
    if (description != null) data['description'] = description;
    if (category != null) data['category'] = category.name;
    if (isHighlight != null) data['is_highlight'] = isHighlight;
    if (highlightNotes != null) data['highlight_notes'] = highlightNotes;
    if (tags != null) data['tags'] = tags;

    final response = await _supabase
        .from(TableNames.mediaItems)
        .update(data)
        .eq('id', id)
        .select()
        .single();

    return MediaItem.fromJson(_mapFromDb(response));
  }

  /// Toggle highlight status
  Future<MediaItem> toggleHighlight(String id, {String? notes}) async {
    final current = await getMediaItem(id);
    if (current == null) throw Exception('Media item not found');

    return await updateMediaItem(
      id: id,
      isHighlight: !current.isHighlight,
      highlightNotes: notes,
    );
  }

  /// Delete media item
  Future<void> deleteMediaItem(String id) async {
    final item = await getMediaItem(id);
    if (item == null) return;

    // Delete from storage
    await _supabase.deleteFile(
      bucket: StorageBuckets.tournamentMedia,
      path: item.storagePath,
    );

    // Delete thumbnail if exists
    if (item.thumbnailPath != null) {
      await _supabase.deleteFile(
        bucket: StorageBuckets.tournamentMedia,
        path: item.thumbnailPath!,
      );
    }

    // Delete database record
    await _supabase.from(TableNames.mediaItems).delete().eq('id', id);
  }

  // ============ Helper Methods ============

  Future<MediaItem> _createMediaRecord({
    required String playerId,
    String? tournamentId,
    String? roundId,
    required MediaType mediaType,
    required MediaCategory category,
    required String storagePath,
    required String originalFilename,
    String? url,
    String? thumbnailUrl,
    String? caption,
    String? description,
    List<String> tags = const [],
    bool isHighlight = false,
    String? highlightNotes,
    int? fileSizeBytes,
    int? width,
    int? height,
    int? durationSeconds,
  }) async {
    final data = {
      'player_id': playerId,
      'tournament_id': tournamentId,
      'round_id': roundId,
      'media_type': mediaType.name,
      'category': category.name,
      'storage_path': storagePath,
      'original_filename': originalFilename,
      'url': url,
      'thumbnail_url': thumbnailUrl,
      'caption': caption,
      'description': description,
      'tags': tags,
      'is_highlight': isHighlight,
      'highlight_notes': highlightNotes,
      'file_size_bytes': fileSizeBytes,
      'width': width,
      'height': height,
      'duration_seconds': durationSeconds,
      'captured_at': DateTime.now().toIso8601String(),
    };

    final response = await _supabase
        .from(TableNames.mediaItems)
        .insert(data)
        .select()
        .single();

    return MediaItem.fromJson(_mapFromDb(response));
  }

  String _generateStoragePath(String playerId, String type, String extension) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uniqueId = _uuid.v4().substring(0, 8);
    return '$playerId/$type/${timestamp}_$uniqueId$extension';
  }

  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      case '.heic':
        return 'image/heic';
      case '.mp4':
        return 'video/mp4';
      case '.mov':
        return 'video/quicktime';
      case '.avi':
        return 'video/x-msvideo';
      case '.webm':
        return 'video/webm';
      default:
        return 'application/octet-stream';
    }
  }

  Map<String, dynamic> _mapFromDb(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'playerId': row['player_id'],
      'tournamentId': row['tournament_id'],
      'roundId': row['round_id'],
      'holeNumber': row['hole_number'],
      'mediaType': row['media_type'],
      'category': row['category'],
      'storagePath': row['storage_path'],
      'thumbnailPath': row['thumbnail_path'],
      'originalFilename': row['original_filename'],
      'url': row['url'],
      'thumbnailUrl': row['thumbnail_url'],
      'caption': row['caption'],
      'description': row['description'],
      'tags': row['tags'] != null ? List<String>.from(row['tags']) : <String>[],
      'isHighlight': row['is_highlight'] ?? false,
      'highlightNotes': row['highlight_notes'],
      'durationSeconds': row['duration_seconds'],
      'fileSizeBytes': row['file_size_bytes'],
      'width': row['width'],
      'height': row['height'],
      'capturedAt': row['captured_at'],
      'createdAt': row['created_at'],
      'updatedAt': row['updated_at'],
    };
  }

  /// Get basename from a path
  String _basename(String path) {
    final lastSeparator = path.lastIndexOf('/');
    if (lastSeparator == -1) {
      final winSeparator = path.lastIndexOf('\\');
      if (winSeparator == -1) return path;
      return path.substring(winSeparator + 1);
    }
    return path.substring(lastSeparator + 1);
  }

  /// Get file extension from a filename
  String _extension(String filename) {
    final dotIndex = filename.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == filename.length - 1) return '';
    return filename.substring(dotIndex);
  }
}
