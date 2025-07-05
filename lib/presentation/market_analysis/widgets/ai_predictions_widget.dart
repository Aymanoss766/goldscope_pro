import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiPredictionsWidget extends StatefulWidget {
  final Map<String, dynamic> predictions;

  const AiPredictionsWidget({
    Key? key,
    required this.predictions,
  }) : super(key: key);

  @override
  State<AiPredictionsWidget> createState() => _AiPredictionsWidgetState();
}

class _AiPredictionsWidgetState extends State<AiPredictionsWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          _buildTabBar(),
          SizedBox(height: 2.h),
          _buildTabBarView(),
          SizedBox(height: 3.h),
          _buildAccuracyMetrics(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'psychology',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(width: 3.w),
        Text(
          'AI Predictions',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.secondary
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'auto_awesome',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                'AI Powered',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: '1 Week'),
          Tab(text: '1 Month'),
          Tab(text: '3 Months'),
        ],
        labelColor: AppTheme.lightTheme.colorScheme.primary,
        unselectedLabelColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        indicatorColor: AppTheme.lightTheme.colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: 25.h,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPredictionCard('oneWeek'),
          _buildPredictionCard('oneMonth'),
          _buildPredictionCard('threeMonths'),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(String timeframe) {
    final Map<String, dynamic>? predictionData =
        widget.predictions[timeframe] as Map<String, dynamic>?;
    if (predictionData == null) return const SizedBox.shrink();

    final double target = (predictionData["target"] ?? 0.0).toDouble();
    final int confidence = predictionData["confidence"] ?? 0;
    final Map<String, dynamic>? range =
        predictionData["range"] as Map<String, dynamic>?;
    final double low = (range?["low"] ?? 0.0).toDouble();
    final double high = (range?["high"] ?? 0.0).toDouble();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price Target',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildConfidenceBadge(confidence),
            ],
          ),
          SizedBox(height: 2.h),
          Center(
            child: Column(
              children: [
                Text(
                  '\$${target.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Target Price',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          _buildPriceRange(low, high, target),
        ],
      ),
    );
  }

  Widget _buildConfidenceBadge(int confidence) {
    Color confidenceColor;
    if (confidence >= 70) {
      confidenceColor = AppTheme.getSuccessColor(true);
    } else if (confidence >= 50) {
      confidenceColor = AppTheme.getWarningColor(true);
    } else {
      confidenceColor = AppTheme.getErrorColor(true);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: confidenceColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$confidence% Confidence',
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: confidenceColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriceRange(double low, double high, double target) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Low',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                Text(
                  '\$${low.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.getErrorColor(true),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'High',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                Text(
                  '\$${high.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.getSuccessColor(true),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 2.h),
        _buildRangeIndicator(low, high, target),
      ],
    );
  }

  Widget _buildRangeIndicator(double low, double high, double target) {
    final double range = high - low;
    final double targetPosition = (target - low) / range;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.getErrorColor(true).withValues(alpha: 0.3),
                    AppTheme.getWarningColor(true).withValues(alpha: 0.3),
                    AppTheme.getSuccessColor(true).withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Positioned(
              left: targetPosition * 100.w * 0.8,
              child: Container(
                width: 4,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bearish',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.getErrorColor(true),
              ),
            ),
            Text(
              'Bullish',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.getSuccessColor(true),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccuracyMetrics() {
    final Map<String, dynamic>? accuracy =
        widget.predictions["accuracy"] as Map<String, dynamic>?;
    if (accuracy == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Historical Accuracy',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAccuracyItem('1W', (accuracy["oneWeek"] ?? 0.0).toDouble()),
              _buildAccuracyItem(
                  '1M', (accuracy["oneMonth"] ?? 0.0).toDouble()),
              _buildAccuracyItem(
                  '3M', (accuracy["threeMonths"] ?? 0.0).toDouble()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracyItem(String period, double accuracy) {
    return Column(
      children: [
        Text(
          '${accuracy.toStringAsFixed(1)}%',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          period,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
