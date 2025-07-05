import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/economic_drivers_card_widget.dart';
import './widgets/market_summary_card_widget.dart';
import './widgets/price_chart_card_widget.dart';
import './widgets/recent_news_card_widget.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isRefreshing = false;
  late AnimationController _priceAnimationController;
  late Animation<Color?> _priceColorAnimation;

  // Mock data for gold price
  final Map<String, dynamic> goldPriceData = {
    "currentPrice": 2045.67,
    "currency": "USD",
    "change": 12.45,
    "changePercent": 0.61,
    "isPositive": true,
    "lastUpdated": "2024-01-15 14:30:00",
    "high24h": 2058.90,
    "low24h": 2032.15,
    "volume": "1.2M oz",
    "marketCap": "\$12.8B"
  };

  final List<Map<String, dynamic>> economicDrivers = [
    {
      "title": "Federal Reserve Policy",
      "impact": "Bullish",
      "description": "Interest rate cuts expected in Q2 2024",
      "strength": 0.8
    },
    {
      "title": "USD Weakness",
      "impact": "Bullish",
      "description": "Dollar index declining against major currencies",
      "strength": 0.7
    },
    {
      "title": "Inflation Concerns",
      "impact": "Bullish",
      "description": "CPI data showing persistent inflation pressure",
      "strength": 0.6
    }
  ];

  final List<Map<String, dynamic>> recentNews = [
    {
      "title": "Gold Hits 3-Month High on Fed Rate Cut Speculation",
      "source": "Reuters",
      "time": "2 hours ago",
      "imageUrl":
          "https://images.pexels.com/photos/730547/pexels-photo-730547.jpeg"
    },
    {
      "title": "Central Banks Increase Gold Reserves by 15%",
      "source": "Bloomberg",
      "time": "4 hours ago",
      "imageUrl":
          "https://images.pexels.com/photos/844124/pexels-photo-844124.jpeg"
    },
    {
      "title": "Geopolitical Tensions Drive Safe-Haven Demand",
      "source": "Financial Times",
      "time": "6 hours ago",
      "imageUrl":
          "https://images.pexels.com/photos/259027/pexels-photo-259027.jpeg"
    }
  ];

  @override
  void initState() {
    super.initState();
    _priceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _priceColorAnimation = ColorTween(
      begin: AppTheme.lightTheme.colorScheme.onSurface,
      end: goldPriceData["isPositive"] as bool
          ? AppTheme.getSuccessColor(true)
          : AppTheme.getErrorColor(true),
    ).animate(_priceAnimationController);
    _priceAnimationController.forward();
  }

  @override
  void dispose() {
    _priceAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Navigator.pushNamed(context, '/live-gold-prices');
        break;
      case 2:
        // Portfolio navigation would go here
        break;
      case 3:
        // Alerts navigation would go here
        break;
      case 4:
        // More navigation would go here
        break;
    }
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Quick Actions',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 3.h),
            _buildQuickActionTile(
              icon: 'notifications',
              title: 'Set Price Alert',
              subtitle: 'Get notified when price changes',
              onTap: () => Navigator.pop(context),
            ),
            _buildQuickActionTile(
              icon: 'bookmark',
              title: 'Add to Watchlist',
              subtitle: 'Track this asset',
              onTap: () => Navigator.pop(context),
            ),
            _buildQuickActionTile(
              icon: 'share',
              title: 'Share Price',
              subtitle: 'Share current gold price',
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 12.w,
        height: 6.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.lightTheme.textTheme.bodySmall,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: CustomScrollView(
          slivers: [
            // Sticky header with gold price
            SliverAppBar(
              expandedHeight: 20.h,
              floating: false,
              pinned: true,
              backgroundColor: AppTheme.lightTheme.colorScheme.surface,
              elevation: 2,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gold Price (XAU/USD)',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              AnimatedBuilder(
                                animation: _priceColorAnimation,
                                builder: (context, child) {
                                  return Text(
                                    '\$${goldPriceData["currentPrice"].toStringAsFixed(2)}',
                                    style: AppTheme
                                        .lightTheme.textTheme.headlineLarge
                                        ?.copyWith(
                                      color: _priceColorAnimation.value,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          GestureDetector(
                            onLongPress: _showQuickActions,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: (goldPriceData["isPositive"] as bool)
                                    ? AppTheme.getSuccessColor(true)
                                        .withValues(alpha: 0.1)
                                    : AppTheme.getErrorColor(true)
                                        .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomIconWidget(
                                        iconName: (goldPriceData["isPositive"]
                                                as bool)
                                            ? 'trending_up'
                                            : 'trending_down',
                                        color: (goldPriceData["isPositive"]
                                                as bool)
                                            ? AppTheme.getSuccessColor(true)
                                            : AppTheme.getErrorColor(true),
                                        size: 4.w,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        '+\$${goldPriceData["change"].toStringAsFixed(2)}',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: (goldPriceData["isPositive"]
                                                  as bool)
                                              ? AppTheme.getSuccessColor(true)
                                              : AppTheme.getErrorColor(true),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '(+${goldPriceData["changePercent"].toStringAsFixed(2)}%)',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color:
                                          (goldPriceData["isPositive"] as bool)
                                              ? AppTheme.getSuccessColor(true)
                                              : AppTheme.getErrorColor(true),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/news-feed'),
                  icon: CustomIconWidget(
                    iconName: 'notifications',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 2.w),
              ],
            ),

            // Main content
            SliverPadding(
              padding: EdgeInsets.all(4.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Market Summary Card
                  MarketSummaryCardWidget(
                    high24h: goldPriceData["high24h"] as double,
                    low24h: goldPriceData["low24h"] as double,
                    volume: goldPriceData["volume"] as String,
                    marketCap: goldPriceData["marketCap"] as String,
                  ),

                  SizedBox(height: 2.h),

                  // Economic Drivers Card
                  EconomicDriversCardWidget(
                    drivers: economicDrivers,
                  ),

                  SizedBox(height: 2.h),

                  // Price Chart Card
                  PriceChartCardWidget(),

                  SizedBox(height: 2.h),

                  // Recent News Card
                  RecentNewsCardWidget(
                    news: recentNews,
                  ),

                  SizedBox(height: 10.h), // Bottom padding for FAB
                ]),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
        unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _selectedIndex == 0
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'trending_up',
              color: _selectedIndex == 1
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Markets',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'account_balance_wallet',
              color: _selectedIndex == 2
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'notifications',
              color: _selectedIndex == 3
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'more_horiz',
              color: _selectedIndex == 4
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'More',
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Quick trade functionality
        },
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        foregroundColor: AppTheme.lightTheme.colorScheme.onSecondary,
        icon: CustomIconWidget(
          iconName: 'flash_on',
          color: AppTheme.lightTheme.colorScheme.onSecondary,
          size: 5.w,
        ),
        label: Text(
          'Quick Trade',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
