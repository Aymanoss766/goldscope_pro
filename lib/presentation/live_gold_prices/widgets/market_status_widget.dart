import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MarketStatusWidget extends StatelessWidget {
  final bool isMarketOpen;
  final bool isConnected;
  final DateTime lastUpdate;

  const MarketStatusWidget({
    Key? key,
    required this.isMarketOpen,
    required this.isConnected,
    required this.lastUpdate,
  }) : super(key: key);

  String _getTimeUntilNextSession() {
    final now = DateTime.now();
    final nextOpen = DateTime(now.year, now.month, now.day, 9, 0);
    final nextClose = DateTime(now.year, now.month, now.day, 17, 0);

    if (isMarketOpen) {
      final timeUntilClose = nextClose.difference(now);
      final hours = timeUntilClose.inHours;
      final minutes = timeUntilClose.inMinutes % 60;
      return 'Closes in ${hours}h ${minutes}m';
    } else {
      final timeUntilOpen =
          nextOpen.add(const Duration(days: 1)).difference(now);
      final hours = timeUntilOpen.inHours;
      final minutes = timeUntilOpen.inMinutes % 60;
      return 'Opens in ${hours}h ${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Connection Status Indicator
          Container(
            width: 3.w,
            height: 3.w,
            decoration: BoxDecoration(
              color: isConnected
                  ? AppTheme.getSuccessColor(
                      Theme.of(context).brightness == Brightness.light)
                  : AppTheme.getErrorColor(
                      Theme.of(context).brightness == Brightness.light),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 3.w),

          // Market Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isMarketOpen ? 'Market Open' : 'Market Closed',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isMarketOpen
                                ? AppTheme.getSuccessColor(
                                    Theme.of(context).brightness ==
                                        Brightness.light)
                                : AppTheme.getErrorColor(
                                    Theme.of(context).brightness ==
                                        Brightness.light),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: isMarketOpen ? 'trending_up' : 'trending_down',
                      color: isMarketOpen
                          ? AppTheme.getSuccessColor(
                              Theme.of(context).brightness == Brightness.light)
                          : AppTheme.getErrorColor(
                              Theme.of(context).brightness == Brightness.light),
                      size: 16,
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  _getTimeUntilNextSession(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Last Update
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Last Update',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 0.5.h),
              Text(
                '${lastUpdate.hour.toString().padLeft(2, '0')}:${lastUpdate.minute.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
