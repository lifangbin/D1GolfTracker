import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item.freezed.dart';
part 'media_item.g.dart';

/// Type of media content
enum MediaType {
  photo,
  video,
}

/// Category for organizing media
enum MediaCategory {
  swing,
  tournament,
  practice,
  course,
  milestone,
  other,
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required String id,
    required String playerId,

    // Association (one or more can be set)
    String? tournamentId,
    String? roundId,
    String? holeNumber,

    // Media Info
    required MediaType mediaType,
    @Default(MediaCategory.other) MediaCategory category,
    required String storagePath,
    String? thumbnailPath,
    required String originalFilename,

    // URLs (populated after upload)
    String? url,
    String? thumbnailUrl,

    // Metadata
    String? caption,
    String? description,
    @Default([]) List<String> tags,

    // For recruiting highlights
    @Default(false) bool isHighlight,
    String? highlightNotes,

    // Video specific
    int? durationSeconds,

    // File info
    int? fileSizeBytes,
    int? width,
    int? height,

    // Timestamps
    DateTime? capturedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
}

extension MediaItemX on MediaItem {
  bool get isPhoto => mediaType == MediaType.photo;
  bool get isVideo => mediaType == MediaType.video;

  String get typeIcon {
    switch (mediaType) {
      case MediaType.photo:
        return '📷';
      case MediaType.video:
        return '🎬';
    }
  }

  String get categoryLabel {
    switch (category) {
      case MediaCategory.swing:
        return 'Swing';
      case MediaCategory.tournament:
        return 'Tournament';
      case MediaCategory.practice:
        return 'Practice';
      case MediaCategory.course:
        return 'Course';
      case MediaCategory.milestone:
        return 'Milestone';
      case MediaCategory.other:
        return 'Other';
    }
  }

  String get durationDisplay {
    if (durationSeconds == null) return '';
    final minutes = durationSeconds! ~/ 60;
    final seconds = durationSeconds! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get fileSizeDisplay {
    if (fileSizeBytes == null) return '';
    if (fileSizeBytes! < 1024) return '$fileSizeBytes B';
    if (fileSizeBytes! < 1024 * 1024) {
      return '${(fileSizeBytes! / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSizeBytes! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
