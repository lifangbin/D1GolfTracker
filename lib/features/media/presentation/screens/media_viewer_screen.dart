import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme.dart';
import '../../domain/media_item.dart';
import '../providers/media_provider.dart';
import '../widgets/media_picker_sheet.dart';

class MediaViewerScreen extends ConsumerStatefulWidget {
  final MediaItem mediaItem;

  const MediaViewerScreen({
    super.key,
    required this.mediaItem,
  });

  @override
  ConsumerState<MediaViewerScreen> createState() => _MediaViewerScreenState();
}

class _MediaViewerScreenState extends ConsumerState<MediaViewerScreen> {
  late MediaItem _item;
  bool _showInfo = true;

  @override
  void initState() {
    super.initState();
    _item = widget.mediaItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showInfo
          ? AppBar(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              title: Text(
                _item.caption ?? _item.originalFilename,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    _item.isHighlight ? Icons.star : Icons.star_border,
                    color: _item.isHighlight ? AppColors.accent : Colors.white,
                  ),
                  onPressed: _toggleHighlight,
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: _handleMenuAction,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit Details'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text('Share'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: AppColors.error),
                          SizedBox(width: 8),
                          Text('Delete',
                              style: TextStyle(color: AppColors.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showInfo = !_showInfo;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Media content
            _item.isPhoto ? _buildPhotoView() : _buildVideoView(),

            // Bottom info panel
            if (_showInfo)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildInfoPanel(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoView() {
    final url = _item.url;
    if (url == null || url.isEmpty) {
      return const Center(
        child: Icon(Icons.broken_image, color: Colors.white54, size: 64),
      );
    }

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.contain,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.broken_image,
            color: Colors.white54,
            size: 64,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoView() {
    // For now, show a placeholder with play button
    // Full video player implementation would use video_player package
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_item.thumbnailUrl != null)
            Expanded(
              child: CachedNetworkImage(
                imageUrl: _item.thumbnailUrl!,
                fit: BoxFit.contain,
              ),
            )
          else
            const Icon(Icons.videocam, color: Colors.white54, size: 64),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_arrow, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Play Video',
                  style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          if (_item.durationDisplay.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _item.durationDisplay,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black87, Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Caption
          if (_item.caption != null && _item.caption!.isNotEmpty)
            Text(
              _item.caption!,
              style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
            ),

          const SizedBox(height: AppSpacing.sm),

          // Tags
          Row(
            children: [
              _buildTag(_item.categoryLabel, Icons.label_outline),
              const SizedBox(width: 8),
              _buildTag(
                _item.isPhoto ? 'Photo' : 'Video',
                _item.isPhoto ? Icons.photo : Icons.videocam,
              ),
              if (_item.isHighlight) ...[
                const SizedBox(width: 8),
                _buildTag('Highlight', Icons.star, color: AppColors.accent),
              ],
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // File info
          Row(
            children: [
              Text(
                _item.fileSizeDisplay,
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white60),
              ),
              if (_item.capturedAt != null) ...[
                const SizedBox(width: 16),
                Text(
                  _formatDate(_item.capturedAt!),
                  style:
                      AppTextStyles.bodySmall.copyWith(color: Colors.white60),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, IconData icon, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? Colors.white).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? Colors.white70),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color ?? Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _toggleHighlight() async {
    await ref.read(mediaUploadProvider.notifier).toggleHighlight(_item.id);
    setState(() {
      _item = _item.copyWith(isHighlight: !_item.isHighlight);
    });
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'edit':
        _showEditDialog();
        break;
      case 'share':
        // TODO: Implement share functionality
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Share feature coming soon')),
        );
        break;
      case 'delete':
        _confirmDelete();
        break;
    }
  }

  Future<void> _showEditDialog() async {
    String caption = _item.caption ?? '';
    MediaCategory category = _item.category;
    bool isHighlight = _item.isHighlight;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: TextEditingController(text: caption),
                  decoration: const InputDecoration(
                    labelText: 'Caption',
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
                  title: const Text('Highlight'),
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
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );

    if (result == true && mounted) {
      await ref.read(mediaUploadProvider.notifier).updateMediaItem(
            id: _item.id,
            caption: caption.isNotEmpty ? caption : null,
            category: category,
            isHighlight: isHighlight,
          );

      setState(() {
        _item = _item.copyWith(
          caption: caption.isNotEmpty ? caption : null,
          category: category,
          isHighlight: isHighlight,
        );
      });
    }
  }

  void _confirmDelete() {
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
                  .deleteMediaItem(_item.id);
              if (mounted) {
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
