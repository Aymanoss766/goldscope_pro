import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NewsArticleCardWidget extends StatelessWidget {
  final Map<String, dynamic> article;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onHideSource;

  const NewsArticleCardWidget({
    Key? key,
    required this.article,
    required this.isSaved,
    required this.onTap,
    required this.onSave,
    required this.onShare,
    required this.onHideSource,
  }) : super(key: key);

  Color _getImpactColor(String impact) {
    switch (impact) {
      case 'Highly Positive':
        return AppTheme.getSuccessColor(true);
      case 'Positive':
        return AppTheme.getSuccessColor(true);
      case 'Moderately Positive':
        return AppTheme.getWarningColor(true);
      case 'Neutral':
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
      case 'Negative':
        return AppTheme.getErrorColor(true);
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(article['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.getErrorColor(true),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomIconWidget(
          iconName: 'visibility_off',
          color: Colors.white,
          size: 24,
        ),
      ),
      confirmDismiss: (direction) async {
        onHideSource();
        return false;
      },
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () {
          _showContextMenu(context);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breaking News Badge
              if (article['isBreaking'] == true)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.getErrorColor(true),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'flash_on',
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'BREAKING NEWS',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Header
                    Row(
                      children: [
                        CustomImageWidget(
                          imageUrl: article['sourceLogo'],
                          width: 8.w,
                          height: 8.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['source'],
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                article['publishedTime'],
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Relevance Score
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${article['relevanceScore']}%',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // Article Content
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['headline'],
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                article['summary'],
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        if (article['thumbnail'] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomImageWidget(
                              imageUrl: article['thumbnail'],
                              width: 20.w,
                              height: 15.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // Article Footer
                    Row(
                      children: [
                        // Gold Impact Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: _getImpactColor(article['goldImpact'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            article['goldImpact'],
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: _getImpactColor(article['goldImpact']),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(width: 2.w),

                        // Category Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.secondary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            article['category'],
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.secondary,
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Reading Time
                        Text(
                          article['readingTime'],
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),

                        SizedBox(width: 2.w),

                        // Action Buttons
                        GestureDetector(
                          onTap: onSave,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            child: CustomIconWidget(
                              iconName:
                                  isSaved ? 'bookmark' : 'bookmark_border',
                              color: isSaved
                                  ? AppTheme.lightTheme.colorScheme.secondary
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                          ),
                        ),

                        SizedBox(width: 1.w),

                        GestureDetector(
                          onTap: onShare,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            child: CustomIconWidget(
                              iconName: 'share',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'open_in_browser',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 24,
              ),
              title: const Text('Open in Browser'),
              onTap: () {
                Navigator.pop(context);
                // Open in browser
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'playlist_add',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 24,
              ),
              title: const Text('Add to Reading List'),
              onTap: () {
                Navigator.pop(context);
                // Add to reading list
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report',
                color: AppTheme.getErrorColor(true),
                size: 24,
              ),
              title: Text(
                'Report Issue',
                style: TextStyle(color: AppTheme.getErrorColor(true)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Report issue
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
