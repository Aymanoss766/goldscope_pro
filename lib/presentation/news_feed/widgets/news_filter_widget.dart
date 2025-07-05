import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NewsFilterWidget extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const NewsFilterWidget({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filters = [
      {'name': 'All Sources', 'icon': 'all_inclusive'},
      {'name': 'Breaking News', 'icon': 'flash_on'},
      {'name': 'High Relevance', 'icon': 'trending_up'},
      {'name': 'Financial Times', 'icon': 'newspaper'},
      {'name': 'Reuters', 'icon': 'newspaper'},
      {'name': 'Bloomberg', 'icon': 'newspaper'},
    ];

    return Container(
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter['name'];

          return GestureDetector(
            onTap: () => onFilterChanged(filter['name']),
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: filter['icon'],
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    filter['name'],
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
