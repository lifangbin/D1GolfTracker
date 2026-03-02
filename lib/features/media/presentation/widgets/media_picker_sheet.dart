import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../domain/media_item.dart';

class MediaPickerSheet extends StatelessWidget {
  final bool allowVideo;
  final MediaCategory? defaultCategory;

  const MediaPickerSheet({
    super.key,
    this.allowVideo = true,
    this.defaultCategory,
  });

  static Future<MediaPickerResult?> show(
    BuildContext context, {
    bool allowVideo = true,
    MediaCategory? defaultCategory,
  }) {
    return showModalBottomSheet<MediaPickerResult>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MediaPickerSheet(
        allowVideo: allowVideo,
        defaultCategory: defaultCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textHint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Add Media',
              style: AppTextStyles.headlineSmall,
            ),
          ),

          const Divider(height: 1),

          // Photo options
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(Icons.camera_alt, color: AppColors.primary),
            ),
            title: const Text('Take Photo'),
            subtitle: const Text('Capture with camera'),
            onTap: () => Navigator.pop(
              context,
              const MediaPickerResult(
                source: MediaSource.camera,
                type: MediaType.photo,
              ),
            ),
          ),

          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(Icons.photo_library, color: AppColors.info),
            ),
            title: const Text('Choose Photo'),
            subtitle: const Text('Select from gallery'),
            onTap: () => Navigator.pop(
              context,
              const MediaPickerResult(
                source: MediaSource.gallery,
                type: MediaType.photo,
              ),
            ),
          ),

          // Video options
          if (allowVideo) ...[
            const Divider(height: 1, indent: 16, endIndent: 16),

            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(Icons.videocam, color: AppColors.secondary),
              ),
              title: const Text('Record Video'),
              subtitle: const Text('Capture swing video (max 2 min)'),
              onTap: () => Navigator.pop(
                context,
                const MediaPickerResult(
                  source: MediaSource.camera,
                  type: MediaType.video,
                ),
              ),
            ),

            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(Icons.video_library, color: AppColors.accentDark),
              ),
              title: const Text('Choose Video'),
              subtitle: const Text('Select from gallery'),
              onTap: () => Navigator.pop(
                context,
                const MediaPickerResult(
                  source: MediaSource.gallery,
                  type: MediaType.video,
                ),
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

enum MediaSource { camera, gallery }

class MediaPickerResult {
  final MediaSource source;
  final MediaType type;

  const MediaPickerResult({
    required this.source,
    required this.type,
  });
}

class MediaCategorySelector extends StatelessWidget {
  final MediaCategory? selected;
  final ValueChanged<MediaCategory> onChanged;

  const MediaCategorySelector({
    super.key,
    this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: MediaCategory.values.map((category) {
        final isSelected = selected == category;
        return ChoiceChip(
          label: Text(_getCategoryLabel(category)),
          selected: isSelected,
          onSelected: (_) => onChanged(category),
          selectedColor: AppColors.primary.withOpacity(0.2),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          avatar: Icon(
            _getCategoryIcon(category),
            size: 18,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        );
      }).toList(),
    );
  }

  String _getCategoryLabel(MediaCategory category) {
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

  IconData _getCategoryIcon(MediaCategory category) {
    switch (category) {
      case MediaCategory.swing:
        return Icons.sports_golf;
      case MediaCategory.tournament:
        return Icons.emoji_events;
      case MediaCategory.practice:
        return Icons.fitness_center;
      case MediaCategory.course:
        return Icons.landscape;
      case MediaCategory.milestone:
        return Icons.star;
      case MediaCategory.other:
        return Icons.photo;
    }
  }
}
