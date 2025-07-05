import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MarketSummaryCardWidget extends StatelessWidget {
  final double high24h;
  final double low24h;
  final String volume;
  final String marketCap;

  const MarketSummaryCardWidget({
    super.key,
    required this.high24h,
    required this.low24h,
    required this.volume,
    required this.marketCap,
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
              children: [
                CustomIconWidget(
                  iconName: 'analytics',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 6.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Market Summary',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    '24h High',
                    '\$${high24h.toStringAsFixed(2)}',
                    AppTheme.getSuccessColor(true),
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    '24h Low',
                    '\$${low24h.toStringAsFixed(2)}',
                    AppTheme.getErrorColor(true),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    'Volume',
                    volume,
                    AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    'Market Cap',
                    marketCap,
                    AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
