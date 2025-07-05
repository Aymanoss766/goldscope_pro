import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TechnicalChartWidget extends StatefulWidget {
  final List<dynamic> priceData;
  final Map<String, dynamic> technicalIndicators;

  const TechnicalChartWidget({
    Key? key,
    required this.priceData,
    required this.technicalIndicators,
  }) : super(key: key);

  @override
  State<TechnicalChartWidget> createState() => _TechnicalChartWidgetState();
}

class _TechnicalChartWidgetState extends State<TechnicalChartWidget> {
  bool _showRSI = true;
  bool _showMACD = true;
  bool _showBollingerBands = false;
  bool _showMovingAverages = true;

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
          SizedBox(height: 2.h),
          _buildIndicatorToggles(),
          SizedBox(height: 3.h),
          _buildChart(),
          SizedBox(height: 2.h),
          _buildIndicatorSummary(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'show_chart',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(width: 3.w),
        Text(
          'Technical Analysis',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // Reset chart view
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Chart view reset')),
            );
          },
          icon: CustomIconWidget(
            iconName: 'refresh',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicatorToggles() {
    return Wrap(
      spacing: 2.w,
      runSpacing: 1.h,
      children: [
        _buildToggleChip('RSI', _showRSI, (value) {
          setState(() {
            _showRSI = value;
          });
        }),
        _buildToggleChip('MACD', _showMACD, (value) {
          setState(() {
            _showMACD = value;
          });
        }),
        _buildToggleChip('Bollinger Bands', _showBollingerBands, (value) {
          setState(() {
            _showBollingerBands = value;
          });
        }),
        _buildToggleChip('Moving Averages', _showMovingAverages, (value) {
          setState(() {
            _showMovingAverages = value;
          });
        }),
      ],
    );
  }

  Widget _buildToggleChip(
      String label, bool isSelected, Function(bool) onChanged) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onChanged,
      selectedColor:
          AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.2),
      checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
      labelStyle: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
        color: isSelected
            ? AppTheme.lightTheme.colorScheme.primary
            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
    );
  }

  Widget _buildChart() {
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
        padding: EdgeInsets.all(3.w),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 5,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < widget.priceData.length) {
                      final timeStr = widget.priceData[index]["time"] as String;
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          timeStr,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 5,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '\$${value.toInt()}',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    );
                  },
                  reservedSize: 42,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
              ),
            ),
            minX: 0,
            maxX: (widget.priceData.length - 1).toDouble(),
            minY: 2040,
            maxY: 2080,
            lineBarsData: [
              LineChartBarData(
                spots: widget.priceData.asMap().entries.map((entry) {
                  return FlSpot(
                    entry.key.toDouble(),
                    (entry.value["price"] as num).toDouble(),
                  );
                }).toList(),
                isCurved: true,
                color: AppTheme.lightTheme.colorScheme.primary,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final flSpot = barSpot;
                    return LineTooltipItem(
                      '\$${flSpot.y.toStringAsFixed(2)}',
                      AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicatorSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technical Indicators Summary',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        _buildIndicatorRow('RSI', widget.technicalIndicators["rsi"]),
        _buildIndicatorRow('MACD', widget.technicalIndicators["macd"]),
        _buildIndicatorRow(
            'Bollinger Bands', widget.technicalIndicators["bollingerBands"]),
        _buildIndicatorRow(
            'Moving Averages', widget.technicalIndicators["movingAverages"]),
      ],
    );
  }

  Widget _buildIndicatorRow(String name, Map<String, dynamic>? data) {
    if (data == null) return const SizedBox.shrink();

    final String signal = data["signal"] ?? "neutral";
    final Color signalColor = _getSignalColor(signal);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: signalColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              signal.toUpperCase(),
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: signalColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSignalColor(String signal) {
    switch (signal.toLowerCase()) {
      case 'bullish':
        return AppTheme.getSuccessColor(true);
      case 'bearish':
        return AppTheme.getErrorColor(true);
      default:
        return AppTheme.getWarningColor(true);
    }
  }
}
