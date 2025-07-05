import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/currency_comparison_widget.dart';
import './widgets/market_status_widget.dart';
import './widgets/price_chart_widget.dart';
import './widgets/price_display_widget.dart';
import './widgets/technical_indicators_widget.dart';

class LiveGoldPrices extends StatefulWidget {
  const LiveGoldPrices({Key? key}) : super(key: key);

  @override
  State<LiveGoldPrices> createState() => _LiveGoldPricesState();
}

class _LiveGoldPricesState extends State<LiveGoldPrices>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeframe = '1D';
  bool _isMarketOpen = true;
  double _currentPrice = 2045.67;
  double _priceChange = 12.45;
  double _percentageChange = 0.61;
  bool _isConnected = true;
  DateTime _lastUpdate = DateTime.now();

  final List<String> _timeframes = ['1D', '1W', '1M', '3M', '1Y', '5Y'];

  // Mock real-time price data
  final List<Map<String, dynamic>> _priceHistory = [
    {"time": "09:00", "price": 2033.22, "volume": 1250000},
    {"time": "10:00", "price": 2038.45, "volume": 1180000},
    {"time": "11:00", "price": 2041.78, "volume": 1320000},
    {"time": "12:00", "price": 2039.12, "volume": 1090000},
    {"time": "13:00", "price": 2043.89, "volume": 1450000},
    {"time": "14:00", "price": 2045.67, "volume": 1380000},
  ];

  // Mock currency comparison data
  final List<Map<String, dynamic>> _currencyComparisons = [
    {
      "currency": "USD",
      "rate": 1.0,
      "change": 0.61,
      "flag": "https://flagcdn.com/w320/us.png"
    },
    {
      "currency": "EUR",
      "rate": 0.85,
      "change": -0.23,
      "flag": "https://flagcdn.com/w320/eu.png"
    },
    {
      "currency": "GBP",
      "rate": 0.73,
      "change": 0.45,
      "flag": "https://flagcdn.com/w320/gb.png"
    },
    {
      "currency": "AED",
      "rate": 3.67,
      "change": 0.61,
      "flag": "https://flagcdn.com/w320/ae.png"
    },
    {
      "currency": "SAR",
      "rate": 3.75,
      "change": 0.58,
      "flag": "https://flagcdn.com/w320/sa.png"
    },
  ];

  // Mock technical indicators
  final Map<String, dynamic> _technicalIndicators = {
    "rsi": {"value": 68.5, "signal": "Overbought"},
    "macd": {"value": 2.34, "signal": "Bullish"},
    "sma20": {"value": 2041.23, "signal": "Above"},
    "sma50": {"value": 2038.45, "signal": "Above"},
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _simulateRealTimeUpdates();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _simulateRealTimeUpdates() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentPrice += (DateTime.now().millisecond % 10 - 5) * 0.1;
          _priceChange = _currentPrice - 2033.22;
          _percentageChange = (_priceChange / 2033.22) * 100;
          _lastUpdate = DateTime.now();
        });
        _simulateRealTimeUpdates();
      }
    });
  }

  void _showMarketDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market Details',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 3.h),
                    _buildMarketDetailRow('Bid Price',
                        '\$${(_currentPrice - 0.5).toStringAsFixed(2)}'),
                    _buildMarketDetailRow('Ask Price',
                        '\$${(_currentPrice + 0.5).toStringAsFixed(2)}'),
                    _buildMarketDetailRow('Spread', '\$1.00'),
                    _buildMarketDetailRow('Volume', '1.38M oz'),
                    _buildMarketDetailRow('Market Cap', '\$12.5B'),
                    _buildMarketDetailRow('24h High',
                        '\$${(_currentPrice + 15.23).toStringAsFixed(2)}'),
                    _buildMarketDetailRow('24h Low',
                        '\$${(_currentPrice - 8.45).toStringAsFixed(2)}'),
                    _buildMarketDetailRow('Open Price', '\$2033.22'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Gold Prices'),
        actions: [
          IconButton(
            onPressed: () {
              // Settings for price alerts and display preferences
            },
            icon: CustomIconWidget(
              iconName: 'settings',
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _lastUpdate = DateTime.now();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Market Status
              MarketStatusWidget(
                isMarketOpen: _isMarketOpen,
                isConnected: _isConnected,
                lastUpdate: _lastUpdate,
              ),

              // Current Price Display
              PriceDisplayWidget(
                currentPrice: _currentPrice,
                priceChange: _priceChange,
                percentageChange: _percentageChange,
                isConnected: _isConnected,
              ),

              // Timeframe Selector
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Row(
                  children: _timeframes.map((timeframe) {
                    final isSelected = _selectedTimeframe == timeframe;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTimeframe = timeframe;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).dividerColor,
                            ),
                          ),
                          child: Text(
                            timeframe,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Price Chart
              PriceChartWidget(
                priceHistory: _priceHistory,
                selectedTimeframe: _selectedTimeframe,
                currentPrice: _currentPrice,
              ),

              // Currency Comparison
              CurrencyComparisonWidget(
                currencyComparisons: _currencyComparisons,
                currentPrice: _currentPrice,
              ),

              // Technical Indicators
              TechnicalIndicatorsWidget(
                technicalIndicators: _technicalIndicators,
              ),

              // Market Details Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(4.w),
                child: ElevatedButton(
                  onPressed: _showMarketDetailsBottomSheet,
                  child: const Text('View Market Details'),
                ),
              ),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
