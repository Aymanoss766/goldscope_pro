import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EconomicDriversCardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> drivers;

  const EconomicDriversCardWidget({
    super.key,
    required this.drivers,
  });

  @override
  State<EconomicDriversCardWidget> createState() =>
      _EconomicDriversCardWidgetState();
}

class _EconomicDriversCardWidgetState extends State<EconomicDriversCardWidget> {
  bool _isExpanded = false;

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
                      iconName: 'trending_up',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 6.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Economic Drivers',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: CustomIconWidget(
                    iconName: _isExpanded ? 'expand_less' : 'expand_more',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _isExpanded ? widget.drivers.length : 1,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final driver = widget.drivers[index];
                return _buildDriverItem(driver);
              },
            ),
            if (!_isExpanded && widget.drivers.length > 1) ...[
              SizedBox(height: 2.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: Text(
                    'View ${widget.drivers.length - 1} more drivers',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDriverItem(Map<String, dynamic> driver) {
    final impact = driver["impact"] as String;
    final strength = driver["strength"] as double;
    final isBullish = impact.toLowerCase() == 'bullish';

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: (isBullish
                ? AppTheme.getSuccessColor(true)
                : AppTheme.getErrorColor(true))
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isBullish
                  ? AppTheme.getSuccessColor(true)
                  : AppTheme.getErrorColor(true))
              .withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  driver["title"] as String,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: isBullish
                      ? AppTheme.getSuccessColor(true)
                      : AppTheme.getErrorColor(true),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  impact,
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            driver["description"] as String,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Text(
                'Impact Strength: ',
                style: AppTheme.lightTheme.textTheme.labelSmall,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: strength,
                  backgroundColor: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isBullish
                        ? AppTheme.getSuccessColor(true)
                        : AppTheme.getErrorColor(true),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                '${(strength * 100).toInt()}%',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
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
