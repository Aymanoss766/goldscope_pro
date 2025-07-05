import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MarketSentimentWidget extends StatelessWidget {
  final Map<String, dynamic> sentimentData;

  const MarketSentimentWidget({
    Key? key,
    required this.sentimentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String status = sentimentData["status"] ?? "neutral";
    final double confidence = (sentimentData["confidence"] ?? 0.0).toDouble();

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
          Row(
            children: [
              CustomIconWidget(
                iconName: 'psychology',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Market Sentiment',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Center(
            child: Column(
              children: [
                _buildSentimentGauge(status, confidence),
                SizedBox(height: 2.h),
                _buildSentimentDetails(status, confidence),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentGauge(String status, double confidence) {
    Color sentimentColor;
    IconData sentimentIcon;

    switch (status.toLowerCase()) {
      case 'bullish':
        sentimentColor = AppTheme.getSuccessColor(true);
        sentimentIcon = Icons.trending_up;
        break;
      case 'bearish':
        sentimentColor = AppTheme.getErrorColor(true);
        sentimentIcon = Icons.trending_down;
        break;
      default:
        sentimentColor = AppTheme.getWarningColor(true);
        sentimentIcon = Icons.trending_flat;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 40.w,
          height: 40.w,
          child: CircularProgressIndicator(
            value: confidence / 100,
            strokeWidth: 8,
            backgroundColor:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(sentimentColor),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: _getIconName(sentimentIcon),
              color: sentimentColor,
              size: 32,
            ),
            SizedBox(height: 1.h),
            Text(
              '${confidence.toStringAsFixed(1)}%',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: sentimentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSentimentDetails(String status, double confidence) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Sentiment:',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: _getSentimentColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: _getSentimentColor(status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Confidence Level:',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              Text(
                '${confidence.toStringAsFixed(1)}%',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildConfidenceBar(confidence),
        ],
      ),
    );
  }

  Widget _buildConfidenceBar(double confidence) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confidence Range',
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
        SizedBox(height: 1.h),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: confidence / 100,
            child: Container(
              decoration: BoxDecoration(
                color: _getConfidenceColor(confidence),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Low',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            Text(
              'High',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Color _getSentimentColor(String status) {
    switch (status.toLowerCase()) {
      case 'bullish':
        return AppTheme.getSuccessColor(true);
      case 'bearish':
        return AppTheme.getErrorColor(true);
      default:
        return AppTheme.getWarningColor(true);
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 75) {
      return AppTheme.getSuccessColor(true);
    } else if (confidence >= 50) {
      return AppTheme.getWarningColor(true);
    } else {
      return AppTheme.getErrorColor(true);
    }
  }

  String _getIconName(IconData icon) {
    if (icon == Icons.trending_up) return 'trending_up';
    if (icon == Icons.trending_down) return 'trending_down';
    return 'trending_flat';
  }
}
