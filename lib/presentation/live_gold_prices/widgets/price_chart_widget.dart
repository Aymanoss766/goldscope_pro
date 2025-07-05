import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PriceChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> priceHistory;
  final String selectedTimeframe;
  final double currentPrice;

  const PriceChartWidget({
    Key? key,
    required this.priceHistory,
    required this.selectedTimeframe,
    required this.currentPrice,
  }) : super(key: key);

  @override
  State<PriceChartWidget> createState() => _PriceChartWidgetState();
}

class _PriceChartWidgetState extends State<PriceChartWidget> {
  bool _showTooltip = false;
  double _tooltipX = 0;
  double _tooltipY = 0;
  String _tooltipValue = '';

  List<FlSpot> _generateSpots() {
    return widget.priceHistory.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return FlSpot(index.toDouble(), (data['price'] as num).toDouble());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final spots = _generateSpots();
    final minY =
        spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b) - 5;
    final maxY =
        spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 5;

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Price Chart (${widget.selectedTimeframe})',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            Row(children: [
              CustomIconWidget(
                  iconName: 'zoom_in',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20),
              SizedBox(width: 2.w),
              CustomIconWidget(
                  iconName: 'fullscreen',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20),
            ]),
          ]),

          SizedBox(height: 3.h),

          // Chart
          SizedBox(
              height: 40.h,
              child: Stack(children: [
                LineChart(LineChartData(
                    gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        horizontalInterval: (maxY - minY) / 4,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withValues(alpha: 0.3),
                              strokeWidth: 1);
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withValues(alpha: 0.3),
                              strokeWidth: 1);
                        }),
                    titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < widget.priceHistory.length) {
                                    return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                            widget.priceHistory[index]['time']
                                                as String,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall));
                                  }
                                  return const Text('');
                                })),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                interval: (maxY - minY) / 4,
                                reservedSize: 60,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                          '\$${value.toStringAsFixed(0)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall));
                                }))),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: Theme.of(context).dividerColor, width: 1)),
                    minX: 0,
                    maxX: (widget.priceHistory.length - 1).toDouble(),
                    minY: minY,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ]),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                    radius: 4,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    strokeWidth: 2,
                                    strokeColor: Theme.of(context).cardColor);
                              }),
                          belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.3),
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.1),
                                  ]))),
                    ],
                    lineTouchData: LineTouchData(
                        enabled: true,
                        touchCallback: (FlTouchEvent event,
                            LineTouchResponse? touchResponse) {
                          if (touchResponse != null &&
                              touchResponse.lineBarSpots != null) {
                            final spot = touchResponse.lineBarSpots!.first;
                            setState(() {
                              _showTooltip = true;
                              _tooltipX = spot.x;
                              _tooltipY = spot.y;
                              _tooltipValue = '\$${spot.y.toStringAsFixed(2)}';
                            });
                          } else {
                            setState(() {
                              _showTooltip = false;
                            });
                          }
                        },
                        touchTooltipData: LineTouchTooltipData(
                            tooltipRoundedRadius: 8,
                            getTooltipItems:
                                (List<LineBarSpot> touchedBarSpots) {
                              return touchedBarSpots.map((barSpot) {
                                return LineTooltipItem(
                                    '\$${barSpot.y.toStringAsFixed(2)}',
                                    TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold));
                              }).toList();
                            })))),

                // Chart Instructions
                Positioned(
                    top: 2.h,
                    right: 4.w,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chart Controls:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              Text('• Pinch to zoom',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text('• Pan to navigate',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text('• Tap for price',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ]))),
              ])),

          SizedBox(height: 2.h),

          // Chart Statistics
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _buildStatItem(
                'High',
                '\$${maxY.toStringAsFixed(2)}',
                AppTheme.getSuccessColor(
                    Theme.of(context).brightness == Brightness.light)),
            _buildStatItem(
                'Low',
                '\$${minY.toStringAsFixed(2)}',
                AppTheme.getErrorColor(
                    Theme.of(context).brightness == Brightness.light)),
            _buildStatItem('Volume', '1.38M oz',
                Theme.of(context).colorScheme.onSurfaceVariant),
          ]),
        ]));
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(children: [
      Text(label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      SizedBox(height: 0.5.h),
      Text(value,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: color, fontWeight: FontWeight.w600)),
    ]);
  }
}
