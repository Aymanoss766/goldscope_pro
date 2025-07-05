import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PriceChartCardWidget extends StatefulWidget {
  const PriceChartCardWidget({super.key});

  @override
  State<PriceChartCardWidget> createState() => _PriceChartCardWidgetState();
}

class _PriceChartCardWidgetState extends State<PriceChartCardWidget> {
  String _selectedTimeframe = '1D';
  final List<String> _timeframes = ['1H', '1D', '1W', '1M', '3M', '1Y'];

  // Mock chart data
  final List<FlSpot> chartData = [
    const FlSpot(0, 2032.15),
    const FlSpot(1, 2035.20),
    const FlSpot(2, 2038.45),
    const FlSpot(3, 2041.30),
    const FlSpot(4, 2039.80),
    const FlSpot(5, 2043.60),
    const FlSpot(6, 2045.67),
  ];

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
                      iconName: 'show_chart',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Price Chart',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/market-analysis'),
                  child: CustomIconWidget(
                    iconName: 'fullscreen',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Timeframe selector
            Container(
              height: 5.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _timeframes.length,
                separatorBuilder: (context, index) => SizedBox(width: 2.w),
                itemBuilder: (context, index) {
                  final timeframe = _timeframes[index];
                  final isSelected = timeframe == _selectedTimeframe;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeframe = timeframe;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                      ),
                      child: Center(
                        child: Text(
                          timeframe,
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.onPrimary
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 3.h),

            // Chart
            Container(
              height: 25.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
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
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          );
                          String text = '';
                          switch (value.toInt()) {
                            case 0:
                              text = '9:00';
                              break;
                            case 1:
                              text = '11:00';
                              break;
                            case 2:
                              text = '13:00';
                              break;
                            case 3:
                              text = '15:00';
                              break;
                            case 4:
                              text = '17:00';
                              break;
                            case 5:
                              text = '19:00';
                              break;
                            case 6:
                              text = '21:00';
                              break;
                            default:
                              return Container();
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            '\$${value.toInt()}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
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
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 2030,
                  maxY: 2050,
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.getSuccessColor(true),
                          AppTheme.getSuccessColor(true).withValues(alpha: 0.7),
                        ],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.getSuccessColor(true)
                                .withValues(alpha: 0.3),
                            AppTheme.getSuccessColor(true)
                                .withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return LineTooltipItem(
                            '\$${barSpot.y.toStringAsFixed(2)}',
                            TextStyle(
                              color: AppTheme.lightTheme.colorScheme.onPrimary,
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
          ],
        ),
      ),
    );
  }
}
