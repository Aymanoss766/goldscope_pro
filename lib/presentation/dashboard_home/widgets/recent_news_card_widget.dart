import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentNewsCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> news;

  const RecentNewsCardWidget({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'article',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Recent News',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/news-feed'),
                  child: Text(
                    'View All',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: news.length > 3 ? 3 : news.length,
              separatorBuilder: (context, index) => Divider(
                height: 3.h,
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
              ),
              itemBuilder: (context, index) {
                final newsItem = news[index];
                return _buildNewsItem(newsItem);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(Map<String, dynamic> newsItem) {
    return GestureDetector(
      onTap: () {
        // Navigate to news detail or open in browser
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomImageWidget(
                imageUrl: newsItem["imageUrl"] as String,
                width: 20.w,
                height: 12.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem["title"] as String,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text(
                        newsItem["source"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        width: 1.w,
                        height: 1.w,
                        decoration: BoxDecoration(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        newsItem["time"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}
