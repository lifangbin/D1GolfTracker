import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/theme.dart';
import '../../../auth/presentation/providers/player_provider.dart';
import '../../domain/media_item.dart';
import '../providers/media_provider.dart';
import '../widgets/media_grid.dart';
import '../widgets/media_picker_sheet.dart';
import 'media_viewer_screen.dart';

class MediaGalleryScreen extends ConsumerStatefulWidget {
  final String? tournamentId;
  final String? roundId;
  final String? title;

  const MediaGalleryScreen({
    super.key,
    this.tournamentId,
    this.roundId,
    this.title,
  });

  @override
  ConsumerState<MediaGalleryScreen> createState() => _MediaGalleryScreenState();
}

class _MediaGalleryScreenState extends ConsumerState<MediaGalleryScreen> {
  MediaCategory? _selectedCategory;
  bool _showHighlightsOnly = false;

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerNotifierProvider).valueOrNull;
    if (player == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Get media based on context
    final mediaAsync = widget.tournamentId != null
        ? ref.watch(tournamentMediaProvider(widget.tournamentId!))
        : widget.roundId != null
            ? ref.watch(roundMediaProvider(widget.roundId!))
            : ref.watch(playerMediaProvider(player.id));

    final uploadState = ref.watch(mediaUploadProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Media Gallery'),
        actions: [
          // Filter by highlights
          IconButton(
            icon: Icon(
              _showHighlightsOnly ? Icons.star : Icons.star_border,
              color: _showHighlightsOnly ? AppColors.accent : null,
            ),
            onPressed: () {
              setState(() {
                _showHighlightsOnly = !_showHighlightsOnly;
              });
            },
            tooltip: 'Show highlights only',
          ),
          // Filter menu
          PopupMenuButton<MediaCategory?>(
            icon: Icon(
              _selectedCategory != null ? Icons.filter_alt : Icons.filter_alt_outlined,
            ),
            onSelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Categories'),
              ),
              ...MediaCategory.values.map((category) => PopupMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(
                          _getCategoryIcon(category),
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(_getCategoryLabel(category)),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Upload progress indicator
          if (uploadState.isUploading)
            const LinearProgressIndicator(),

          // Error message
          if (uploadState.error != null)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: AppColors.error.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(Icons.error, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      uploadState.error!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      ref.read(mediaUploadProvider.notifier).reset();
                    },
                  ),
                ],
              ),
            ),

          // Category filter chips
          if (_selectedCategory != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Chip(
                    label: Text(_getCategoryLabel(_selectedCategory!)),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedCategory = null;
                      });
                    },
                  ),
                ],
              ),
            ),

          // Media grid
          Expanded(
            child: mediaAsync.when(
              data: (items) {
                var filteredItems = items;

                // Filter by category
                if (_selectedCategory != null) {
                  filteredItems = filteredItems
                      .where((item) => item.category == _selectedCategory)
                      .toList();
                }

                // Filter by highlights
                if (_showHighlightsOnly) {
                  filteredItems =
                      filteredItems.where((item) => item.isHighlight).toList();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    if (widget.tournamentId != null) {
                      ref.invalidate(
                          tournamentMediaProvider(widget.tournamentId!));
                    } else if (widget.roundId != null) {
                      ref.invalidate(roundMediaProvider(widget.roundId!));
                    } else {
                      ref.invalidate(playerMediaProvider(player.id));
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: MediaGrid(
                      items: filteredItems,
                      onTap: (item) => _openMediaViewer(context, item),
                      onLongPress: (item) => _showMediaOptions(context, item),
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: AppColors.error),
                    const SizedBox(height: AppSpacing.md),
                    Text('Error loading media',
                        style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Text(error.toString(), style: AppTextStyles.bodySmall),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.tournamentId != null) {
                          ref.invalidate(
                              tournamentMediaProvider(widget.tournamentId!));
                        } else if (widget.roundId != null) {
                          ref.invalidate(roundMediaProvider(widget.roundId!));
                        } else {
                          ref.invalidate(playerMediaProvider(player.id));
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadState.isUploading ? null : () => _addMedia(context),
        child: uploadState.isUploading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> _addMedia(BuildContext context) async {
    final result = await MediaPickerSheet.show(context);
    if (result == null) return;

    final notifier = ref.read(mediaUploadProvider.notifier);
    XFile? file;

    if (result.type == MediaType.photo) {
      file = result.source == MediaSource.camera
          ? await notifier.takePhoto()
          : await notifier.pickPhoto();
    } else {
      file = result.source == MediaSource.camera
          ? await notifier.recordVideo()
          : await notifier.pickVideo();
    }

    if (file == null || !mounted) return;

    // Show caption/category dialog
    final details = await _showMediaDetailsDialog(context, result.type);
    if (details == null || !mounted) return;

    // Upload
    if (result.type == MediaType.photo) {
      await notifier.uploadPhoto(
        file: file,
        tournamentId: widget.tournamentId,
        roundId: widget.roundId,
        caption: details.caption,
        category: details.category,
        isHighlight: details.isHighlight,
      );
    } else {
      await notifier.uploadVideo(
        file: file,
        tournamentId: widget.tournamentId,
        roundId: widget.roundId,
        caption: details.caption,
        category: details.category,
        isHighlight: details.isHighlight,
      );
    }
  }

  Future<MediaDetails?> _showMediaDetailsDialog(
    BuildContext context,
    MediaType type,
  ) async {
    String caption = '';
    MediaCategory category =
        type == MediaType.video ? MediaCategory.swing : MediaCategory.other;
    bool isHighlight = false;

    return showDialog<MediaDetails>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Add ${type == MediaType.photo ? 'Photo' : 'Video'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Caption (optional)',
                    hintText: 'Add a description...',
                  ),
                  onChanged: (value) => caption = value,
                  maxLines: 2,
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Category', style: AppTextStyles.labelMedium),
                const SizedBox(height: AppSpacing.sm),
                MediaCategorySelector(
                  selected: category,
                  onChanged: (value) => setState(() => category = value),
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile(
                  title: const Text('Mark as highlight'),
                  subtitle: const Text('For recruiting showcase'),
                  value: isHighlight,
                  onChanged: (value) => setState(() => isHighlight = value),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(
                context,
                MediaDetails(
                  caption: caption.isNotEmpty ? caption : null,
                  category: category,
                  isHighlight: isHighlight,
                ),
              ),
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  void _openMediaViewer(BuildContext context, MediaItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaViewerScreen(mediaItem: item),
      ),
    );
  }

  void _showMediaOptions(BuildContext context, MediaItem item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('View'),
              onTap: () {
                Navigator.pop(context);
                _openMediaViewer(context, item);
              },
            ),
            ListTile(
              leading: Icon(
                item.isHighlight ? Icons.star : Icons.star_border,
                color: item.isHighlight ? AppColors.accent : null,
              ),
              title: Text(
                  item.isHighlight ? 'Remove from highlights' : 'Add to highlights'),
              onTap: () async {
                Navigator.pop(context);
                await ref
                    .read(mediaUploadProvider.notifier)
                    .toggleHighlight(item.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title:
                  const Text('Delete', style: TextStyle(color: AppColors.error)),
              onTap: () => _confirmDelete(context, item),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, MediaItem item) {
    Navigator.pop(context); // Close options sheet
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Media'),
        content: const Text('Are you sure you want to delete this media?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(mediaUploadProvider.notifier)
                  .deleteMediaItem(item.id);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
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

class MediaDetails {
  final String? caption;
  final MediaCategory category;
  final bool isHighlight;

  MediaDetails({
    this.caption,
    required this.category,
    required this.isHighlight,
  });
}
