import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme.dart';
import '../../domain/media_item.dart';

class MediaGrid extends StatelessWidget {
  final List<MediaItem> items;
  final int crossAxisCount;
  final double spacing;
  final void Function(MediaItem item)? onTap;
  final void Function(MediaItem item)? onLongPress;
  final bool showHighlightBadge;

  const MediaGrid({
    super.key,
    required this.items,
    this.crossAxisCount = 3,
    this.spacing = 4,
    this.onTap,
    this.onLongPress,
    this.showHighlightBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MediaGridItem(
          item: items[index],
          onTap: onTap != null ? () => onTap!(items[index]) : null,
          onLongPress:
              onLongPress != null ? () => onLongPress!(items[index]) : null,
          showHighlightBadge: showHighlightBadge,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: AppColors.textHint,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No media yet',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Add photos and videos to capture your golf journey',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MediaGridItem extends StatelessWidget {
  final MediaItem item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showHighlightBadge;

  const MediaGridItem({
    super.key,
    required this.item,
    this.onTap,
    this.onLongPress,
    this.showHighlightBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: _buildImage(),
          ),

          // Video duration overlay
          if (item.isVideo)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      item.durationDisplay.isNotEmpty
                          ? item.durationDisplay
                          : '0:00',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Highlight badge
          if (showHighlightBadge && item.isHighlight)
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final url = item.thumbnailUrl ?? item.url;
    if (url == null || url.isEmpty) {
      return Container(
        color: AppColors.surfaceVariant,
        child: Icon(
          item.isVideo ? Icons.videocam : Icons.image,
          color: AppColors.textHint,
          size: 32,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.surfaceVariant,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.surfaceVariant,
        child: Icon(
          item.isVideo ? Icons.videocam_off : Icons.broken_image,
          color: AppColors.textHint,
          size: 32,
        ),
      ),
    );
  }
}

class MediaListTile extends StatelessWidget {
  final MediaItem item;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleHighlight;

  const MediaListTile({
    super.key,
    required this.item,
    this.onTap,
    this.onDelete,
    this.onToggleHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: SizedBox(
          width: 60,
          height: 60,
          child: _buildThumbnail(),
        ),
      ),
      title: Text(
        item.caption ?? item.originalFilename,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.titleMedium,
      ),
      subtitle: Row(
        children: [
          Icon(
            item.isVideo ? Icons.videocam : Icons.photo,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            item.categoryLabel,
            style: AppTextStyles.bodySmall,
          ),
          if (item.isVideo && item.durationDisplay.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              item.durationDisplay,
              style: AppTextStyles.bodySmall,
            ),
          ],
          const Spacer(),
          Text(
            item.fileSizeDisplay,
            style: AppTextStyles.labelSmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onToggleHighlight != null)
            IconButton(
              icon: Icon(
                item.isHighlight ? Icons.star : Icons.star_border,
                color: item.isHighlight ? AppColors.accent : AppColors.textHint,
              ),
              onPressed: onToggleHighlight,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildThumbnail() {
    final url = item.thumbnailUrl ?? item.url;
    if (url == null || url.isEmpty) {
      return Container(
        color: AppColors.surfaceVariant,
        child: Icon(
          item.isVideo ? Icons.videocam : Icons.image,
          color: AppColors.textHint,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.surfaceVariant,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.surfaceVariant,
        child: const Icon(Icons.broken_image, color: AppColors.textHint),
      ),
    );
  }
}
