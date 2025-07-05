import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PriceDisplayWidget extends StatefulWidget {
  final double currentPrice;
  final double priceChange;
  final double percentageChange;
  final bool isConnected;

  const PriceDisplayWidget({
    Key? key,
    required this.currentPrice,
    required this.priceChange,
    required this.percentageChange,
    required this.isConnected,
  }) : super(key: key);

  @override
  State<PriceDisplayWidget> createState() => _PriceDisplayWidgetState();
}

class _PriceDisplayWidgetState extends State<PriceDisplayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  double _previousPrice = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _previousPrice = widget.currentPrice;
  }

  @override
  void didUpdateWidget(PriceDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPrice != widget.currentPrice) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      _previousPrice = oldWidget.currentPrice;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.priceChange >= 0;
    final changeColor = isPositive
        ? AppTheme.getSuccessColor(
            Theme.of(context).brightness == Brightness.light)
        : AppTheme.getErrorColor(
            Theme.of(context).brightness == Brightness.light);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Connection Status
                if (!widget.isConnected)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    margin: EdgeInsets.only(bottom: 2.h),
                    decoration: BoxDecoration(
                      color: AppTheme.getWarningColor(
                              Theme.of(context).brightness == Brightness.light)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.getWarningColor(
                            Theme.of(context).brightness == Brightness.light),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'wifi_off',
                          color: AppTheme.getWarningColor(
                              Theme.of(context).brightness == Brightness.light),
                          size: 16,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Offline - Last Known Price',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.getWarningColor(
                                        Theme.of(context).brightness ==
                                            Brightness.light),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),

                // Current Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '\$',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w300,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    Text(
                      widget.currentPrice.toStringAsFixed(2),
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: -1,
                              ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Price Change
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: changeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: isPositive ? 'trending_up' : 'trending_down',
                        color: changeColor,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${isPositive ? '+' : ''}\$${widget.priceChange.toStringAsFixed(2)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: changeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '(${isPositive ? '+' : ''}${widget.percentageChange.toStringAsFixed(2)}%)',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: changeColor,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Live Indicator
                if (widget.isConnected)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 2.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                          color: AppTheme.getSuccessColor(
                              Theme.of(context).brightness == Brightness.light),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'LIVE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.getSuccessColor(
                                  Theme.of(context).brightness ==
                                      Brightness.light),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
