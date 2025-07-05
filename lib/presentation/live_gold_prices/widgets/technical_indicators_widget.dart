import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TechnicalIndicatorsWidget extends StatefulWidget {
  final Map<String, dynamic> technicalIndicators;

  const TechnicalIndicatorsWidget({
    Key? key,
    required this.technicalIndicators,
  }) : super(key: key);

  @override
  State<TechnicalIndicatorsWidget> createState() =>
      _TechnicalIndicatorsWidgetState();
}

class _TechnicalIndicatorsWidgetState extends State<TechnicalIndicatorsWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Technical Indicators',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'info_outline',
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: _isExpanded ? 'expand_less' : 'expand_more',
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Indicators Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                // RSI and MACD Row
                Row(
                  children: [
                    Expanded(
                      child: _buildIndicatorCard(
                        'RSI',
                        '${(widget.technicalIndicators['rsi']['value'] as double).toStringAsFixed(1)}',
                        widget.technicalIndicators['rsi']['signal'] as String,
                        _getRSIColor((widget.technicalIndicators['rsi']['value']
                            as double)),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: _buildIndicatorCard(
                        'MACD',
                        '${(widget.technicalIndicators['macd']['value'] as double).toStringAsFixed(2)}',
                        widget.technicalIndicators['macd']['signal'] as String,
                        _getMACDColor(widget.technicalIndicators['macd']
                            ['signal'] as String),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.w),

                // Moving Averages Row
                Row(
                  children: [
                    Expanded(
                      child: _buildIndicatorCard(
                        'SMA 20',
                        '\$${(widget.technicalIndicators['sma20']['value'] as double).toStringAsFixed(2)}',
                        widget.technicalIndicators['sma20']['signal'] as String,
                        _getSMAColor(widget.technicalIndicators['sma20']
                            ['signal'] as String),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: _buildIndicatorCard(
                        'SMA 50',
                        '\$${(widget.technicalIndicators['sma50']['value'] as double).toStringAsFixed(2)}',
                        widget.technicalIndicators['sma50']['signal'] as String,
                        _getSMAColor(widget.technicalIndicators['sma50']
                            ['signal'] as String),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expanded Educational Content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isExpanded ? null : 0,
            child: _isExpanded ? _buildEducationalContent() : null,
          ),

          SizedBox(height: 4.w),
        ],
      ),
    );
  }

  Widget _buildIndicatorCard(
      String title, String value, String signal, Color color) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: 0.5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              signal,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationalContent() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Theme.of(context).dividerColor),
          SizedBox(height: 2.h),
          Text(
            'Understanding Technical Indicators',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 2.h),
          _buildEducationalItem(
            'RSI (Relative Strength Index)',
            'Measures momentum. Values above 70 indicate overbought conditions, below 30 indicate oversold.',
          ),
          _buildEducationalItem(
            'MACD (Moving Average Convergence Divergence)',
            'Shows relationship between two moving averages. Bullish when MACD line crosses above signal line.',
          ),
          _buildEducationalItem(
            'SMA (Simple Moving Average)',
            'Average price over a specific period. Price above SMA indicates upward trend.',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationalItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Color _getRSIColor(double rsi) {
    if (rsi > 70) {
      return AppTheme.getErrorColor(
          Theme.of(context).brightness == Brightness.light);
    } else if (rsi < 30) {
      return AppTheme.getSuccessColor(
          Theme.of(context).brightness == Brightness.light);
    } else {
      return AppTheme.getWarningColor(
          Theme.of(context).brightness == Brightness.light);
    }
  }

  Color _getMACDColor(String signal) {
    switch (signal.toLowerCase()) {
      case 'bullish':
        return AppTheme.getSuccessColor(
            Theme.of(context).brightness == Brightness.light);
      case 'bearish':
        return AppTheme.getErrorColor(
            Theme.of(context).brightness == Brightness.light);
      default:
        return AppTheme.getWarningColor(
            Theme.of(context).brightness == Brightness.light);
    }
  }

  Color _getSMAColor(String signal) {
    switch (signal.toLowerCase()) {
      case 'above':
        return AppTheme.getSuccessColor(
            Theme.of(context).brightness == Brightness.light);
      case 'below':
        return AppTheme.getErrorColor(
            Theme.of(context).brightness == Brightness.light);
      default:
        return AppTheme.getWarningColor(
            Theme.of(context).brightness == Brightness.light);
    }
  }
}
