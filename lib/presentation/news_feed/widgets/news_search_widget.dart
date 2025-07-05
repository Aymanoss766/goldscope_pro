import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NewsSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const NewsSearchWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Input
          Container(
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Search news articles...',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: onClear,
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'clear',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              ),
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),

          SizedBox(height: 2.h),

          // Trending Topics
          if (controller.text.isEmpty) ...[
            Text(
              'Trending Topics',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 1.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: [
                'Federal Reserve',
                'Gold ETF',
                'Inflation',
                'Central Banks',
                'Mining Stocks',
              ]
                  .map((topic) => GestureDetector(
                        onTap: () {
                          controller.text = topic;
                          onChanged(topic);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.secondary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.lightTheme.colorScheme.secondary
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            topic,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],

          // Recent Searches
          if (controller.text.isEmpty) ...[
            SizedBox(height: 2.h),
            Text(
              'Recent Searches',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 1.h),
            Column(
              children: [
                'gold price surge',
                'central bank policy',
                'inflation hedge',
              ]
                  .map((search) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CustomIconWidget(
                          iconName: 'history',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        title: Text(
                          search,
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            // Remove from recent searches
                          },
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 16,
                          ),
                        ),
                        onTap: () {
                          controller.text = search;
                          onChanged(search);
                        },
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
