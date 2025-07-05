import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SupplyDemandWidget extends StatefulWidget {
  final Map<String, dynamic> supplyDemandData;

  const SupplyDemandWidget({
    Key? key,
    required this.supplyDemandData,
  }) : super(key: key);

  @override
  State<SupplyDemandWidget> createState() => _SupplyDemandWidgetState();
}

class _SupplyDemandWidgetState extends State<SupplyDemandWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
          _buildHeader(),
          SizedBox(height: 3.h),
          _buildSupplyDemandChart(),
          SizedBox(height: 3.h),
          _buildDetailedBreakdown(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'analytics',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(width: 3.w),
        Text(
          'Supply & Demand Analysis',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSupplyDemandChart() {
    final List<Map<String, dynamic>> chartData = [
      {
        'category': 'Mining',
        'value':
            (widget.supplyDemandData["mining"]?["production"] ?? 0).toDouble(),
        'change':
            (widget.supplyDemandData["mining"]?["change"] ?? 0.0).toDouble(),
        'color': AppTheme.getWarningColor(true),
      },
      {
        'category': 'Jewelry',
        'value':
            (widget.supplyDemandData["jewelry"]?["demand"] ?? 0).toDouble(),
        'change':
            (widget.supplyDemandData["jewelry"]?["change"] ?? 0.0).toDouble(),
        'color': AppTheme.lightTheme.colorScheme.secondary,
      },
      {
        'category': 'Investment',
        'value':
            (widget.supplyDemandData["investment"]?["flows"] ?? 0).toDouble(),
        'change': (widget.supplyDemandData["investment"]?["change"] ?? 0.0)
            .toDouble(),
        'color': AppTheme.lightTheme.colorScheme.primary,
      },
      {
        'category': 'Central Banks',
        'value': (widget.supplyDemandData["central_banks"]?["purchases"] ?? 0)
            .toDouble(),
        'change': (widget.supplyDemandData["central_banks"]?["change"] ?? 0.0)
            .toDouble(),
        'color': AppTheme.getSuccessColor(true),
      },
    ];

    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 8.w,
                  sections: chartData.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final Map<String, dynamic> data = entry.value;
                    final bool isSelected = index == _selectedIndex;

                    return PieChartSectionData(
                      color: data['color'] as Color,
                      value: data['value'] as double,
                      title: isSelected ? '${data['value'].toInt()}' : '',
                      radius: isSelected ? 12.w : 10.w,
                      titleStyle:
                          AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (pieTouchResponse?.touchedSection != null) {
                        setState(() {
                          _selectedIndex = pieTouchResponse!
                              .touchedSection!.touchedSectionIndex;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: chartData.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final Map<String, dynamic> data = entry.value;
                  return _buildLegendItem(
                    data['category'] as String,
                    data['color'] as Color,
                    data['value'] as double,
                    data['change'] as double,
                    index == _selectedIndex,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String category, Color color, double value,
      double change, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: change >= 0
                        ? AppTheme.getSuccessColor(true)
                        : AppTheme.getErrorColor(true),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Breakdown',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        _buildBreakdownItem(
          'Mining Production',
          widget.supplyDemandData["mining"],
          'tons',
          Icons.terrain,
        ),
        _buildBreakdownItem(
          'Jewelry Demand',
          widget.supplyDemandData["jewelry"],
          'tons',
          Icons.diamond,
        ),
        _buildBreakdownItem(
          'Investment Flows',
          widget.supplyDemandData["investment"],
          'tons',
          Icons.trending_up,
        ),
        _buildBreakdownItem(
          'Central Bank Purchases',
          widget.supplyDemandData["central_banks"],
          'tons',
          Icons.account_balance,
        ),
      ],
    );
  }

  Widget _buildBreakdownItem(
      String title, Map<String, dynamic>? data, String unit, IconData icon) {
    if (data == null) return const SizedBox.shrink();

    final double value = (data["production"] ??
            data["demand"] ??
            data["flows"] ??
            data["purchases"] ??
            0)
        .toDouble();
    final double change = (data["change"] ?? 0.0).toDouble();
    final String trend = data["trend"] ?? "neutral";

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: _getIconName(icon),
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Text(
                      '${value.toStringAsFixed(0)} $unit',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: _getTrendColor(trend).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: _getTrendColor(trend),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomIconWidget(
            iconName: _getTrendIcon(trend),
            color: _getTrendColor(trend),
            size: 20,
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'increasing':
        return AppTheme.getSuccessColor(true);
      case 'declining':
        return AppTheme.getErrorColor(true);
      default:
        return AppTheme.getWarningColor(true);
    }
  }

  String _getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'increasing':
        return 'trending_up';
      case 'declining':
        return 'trending_down';
      default:
        return 'trending_flat';
    }
  }

  String _getIconName(IconData icon) {
    if (icon == Icons.terrain) return 'terrain';
    if (icon == Icons.diamond) return 'diamond';
    if (icon == Icons.trending_up) return 'trending_up';
    if (icon == Icons.account_balance) return 'account_balance';
    return 'analytics';
  }
}
