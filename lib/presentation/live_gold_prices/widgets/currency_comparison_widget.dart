import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CurrencyComparisonWidget extends StatelessWidget {
  final List<Map<String, dynamic>> currencyComparisons;
  final double currentPrice;

  const CurrencyComparisonWidget({
    Key? key,
    required this.currencyComparisons,
    required this.currentPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              'Gold vs Major Currencies',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 20.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currencyComparisons.length,
              itemBuilder: (context, index) {
                final currency = currencyComparisons[index];
                final isPositive = (currency['change'] as double) >= 0;
                final changeColor = isPositive
                    ? AppTheme.getSuccessColor(
                        Theme.of(context).brightness == Brightness.light)
                    : AppTheme.getErrorColor(
                        Theme.of(context).brightness == Brightness.light);

                return Container(
                  width: 35.w,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 2.w : 1.w,
                    right: index == currencyComparisons.length - 1 ? 2.w : 1.w,
                  ),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Currency Flag and Code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageWidget(
                            imageUrl: currency['flag'] as String,
                            width: 6.w,
                            height: 4.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            currency['currency'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),

                      // Exchange Rate
                      Column(
                        children: [
                          Text(
                            'Rate',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            (currency['rate'] as double).toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),

                      // Price in Currency
                      Column(
                        children: [
                          Text(
                            'Price',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            '${_getCurrencySymbol(currency['currency'] as String)}${(currentPrice * (currency['rate'] as double)).toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),

                      // Change Indicator
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: changeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: isPositive
                                  ? 'arrow_upward'
                                  : 'arrow_downward',
                              color: changeColor,
                              size: 12,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '${isPositive ? '+' : ''}${(currency['change'] as double).toStringAsFixed(2)}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: changeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrencySymbol(String currency) {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'AED':
        return 'د.إ';
      case 'SAR':
        return 'ر.س';
      default:
        return '';
    }
  }
}
