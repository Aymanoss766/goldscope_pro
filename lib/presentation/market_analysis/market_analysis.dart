import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_predictions_widget.dart';
import './widgets/economic_factors_widget.dart';
import './widgets/expert_commentary_widget.dart';
import './widgets/market_sentiment_widget.dart';
import './widgets/supply_demand_widget.dart';
import './widgets/technical_chart_widget.dart';

class MarketAnalysis extends StatefulWidget {
  const MarketAnalysis({Key? key}) : super(key: key);

  @override
  State<MarketAnalysis> createState() => _MarketAnalysisState();
}

class _MarketAnalysisState extends State<MarketAnalysis>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  bool _isHeaderVisible = true;
  DateTime _lastRefresh = DateTime.now();

  // Mock data for market analysis
  final Map<String, dynamic> _marketData = {
    "sentiment": {
      "status": "bullish",
      "confidence": 78.5,
      "lastUpdated": "2024-01-15T10:30:00Z"
    },
    "technicalIndicators": {
      "rsi": {"value": 65.2, "signal": "neutral"},
      "macd": {"value": 2.1, "signal": "bullish"},
      "bollingerBands": {"upper": 2085.5, "lower": 2045.2, "signal": "neutral"},
      "movingAverages": {
        "sma20": 2065.3,
        "sma50": 2058.7,
        "ema12": 2067.1,
        "signal": "bullish"
      }
    },
    "priceData": [
      {"time": "09:00", "price": 2055.2, "volume": 1250},
      {"time": "10:00", "price": 2058.7, "volume": 1380},
      {"time": "11:00", "price": 2062.1, "volume": 1420},
      {"time": "12:00", "price": 2065.8, "volume": 1350},
      {"time": "13:00", "price": 2063.4, "volume": 1290},
      {"time": "14:00", "price": 2067.9, "volume": 1460},
      {"time": "15:00", "price": 2070.2, "volume": 1520}
    ],
    "economicFactors": [
      {
        "title": "Inflation Data",
        "impact": "positive",
        "relevanceScore": 85,
        "description":
            "Rising inflation rates typically drive gold prices higher as investors seek hedge against currency devaluation.",
        "details":
            "Current US inflation at 3.2%, above Fed target of 2%. Historical correlation shows 0.73 positive relationship with gold prices."
      },
      {
        "title": "Central Bank Policies",
        "impact": "neutral",
        "relevanceScore": 72,
        "description":
            "Federal Reserve maintains cautious stance on interest rates, creating mixed signals for gold market.",
        "details":
            "Fed signals potential rate cuts in Q2 2024. Lower rates typically support gold prices by reducing opportunity cost."
      },
      {
        "title": "Currency Impact",
        "impact": "positive",
        "relevanceScore": 68,
        "description":
            "US Dollar weakness against major currencies supports gold price momentum.",
        "details":
            "DXY index down 2.1% this month. Inverse correlation with gold remains strong at -0.82."
      },
      {
        "title": "Geopolitical Events",
        "impact": "positive",
        "relevanceScore": 91,
        "description":
            "Ongoing tensions in Middle East and Eastern Europe drive safe-haven demand for gold.",
        "details":
            "Geopolitical risk premium estimated at \$45-60 per ounce. Historical analysis shows 15-20% price spikes during major conflicts."
      }
    ],
    "aiPredictions": {
      "oneWeek": {
        "target": 2075.5,
        "confidence": 72,
        "range": {"low": 2065.2, "high": 2085.8}
      },
      "oneMonth": {
        "target": 2095.3,
        "confidence": 68,
        "range": {"low": 2070.1, "high": 2120.5}
      },
      "threeMonths": {
        "target": 2125.7,
        "confidence": 61,
        "range": {"low": 2085.4, "high": 2165.9}
      },
      "accuracy": {"oneWeek": 78.5, "oneMonth": 71.2, "threeMonths": 64.8}
    },
    "supplyDemand": {
      "mining": {"production": 3200, "change": -2.1, "trend": "declining"},
      "jewelry": {"demand": 1850, "change": 5.3, "trend": "increasing"},
      "investment": {"flows": 420, "change": 12.7, "trend": "increasing"},
      "central_banks": {"purchases": 180, "change": 8.9, "trend": "increasing"}
    },
    "expertCommentary": [
      {
        "author": "Dr. Sarah Mitchell",
        "title": "Senior Gold Analyst",
        "company": "Goldman Sachs",
        "summary":
            "Gold's technical breakout above \$2,060 resistance suggests continuation of bullish trend.",
        "fullArticle":
            "The recent breakout above the key \$2,060 resistance level, combined with strong institutional buying and weakening dollar dynamics, suggests gold is positioned for further upside. Technical indicators support this view with RSI showing healthy momentum without being overbought. We maintain our 12-month target of \$2,200 per ounce.",
        "timestamp": "2024-01-15T09:15:00Z",
        "rating": 4.8
      },
      {
        "author": "Michael Chen",
        "title": "Chief Market Strategist",
        "company": "JP Morgan",
        "summary":
            "Geopolitical tensions and inflation concerns create perfect storm for gold rally.",
        "fullArticle":
            "Current market conditions present an ideal environment for gold appreciation. Persistent geopolitical tensions, coupled with sticky inflation and potential Fed policy shifts, are driving institutional and retail investors toward safe-haven assets. Our models suggest gold could test \$2,100 levels within the next quarter.",
        "timestamp": "2024-01-15T08:45:00Z",
        "rating": 4.6
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 6, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && _isHeaderVisible) {
      setState(() {
        _isHeaderVisible = false;
      });
    } else if (_scrollController.offset <= 100 && !_isHeaderVisible) {
      setState(() {
        _isHeaderVisible = true;
      });
    }
  }

  Future<void> _refreshData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _lastRefresh = DateTime.now();
    });
  }

  void _shareAnalysis() {
    // Platform-native sharing implementation would go here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Analysis shared successfully'),
        backgroundColor: AppTheme.getSuccessColor(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildStickyHeader(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  MarketSentimentWidget(
                    sentimentData: _marketData["sentiment"],
                  ),
                  SizedBox(height: 3.h),
                  TechnicalChartWidget(
                    priceData: _marketData["priceData"],
                    technicalIndicators: _marketData["technicalIndicators"],
                  ),
                  SizedBox(height: 3.h),
                  EconomicFactorsWidget(
                    factors: _marketData["economicFactors"],
                  ),
                  SizedBox(height: 3.h),
                  AiPredictionsWidget(
                    predictions: _marketData["aiPredictions"],
                  ),
                  SizedBox(height: 3.h),
                  SupplyDemandWidget(
                    supplyDemandData: _marketData["supplyDemand"],
                  ),
                  SizedBox(height: 3.h),
                  ExpertCommentaryWidget(
                    commentary: _marketData["expertCommentary"],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareAnalysis,
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        foregroundColor: AppTheme.lightTheme.colorScheme.onSecondary,
        icon: CustomIconWidget(
          iconName: 'share',
          color: AppTheme.lightTheme.colorScheme.onSecondary,
          size: 20,
        ),
        label: Text(
          'Share Analysis',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildStickyHeader() {
    return SliverAppBar(
      expandedHeight: 12.h,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      elevation: _isHeaderVisible ? 0 : 2,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.lightTheme.colorScheme.onSurface,
          size: 24,
        ),
      ),
      title: AnimatedOpacity(
        opacity: _isHeaderVisible ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Text(
          'Market Analysis',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _refreshData,
          icon: CustomIconWidget(
            iconName: 'refresh',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'dashboard':
                Navigator.pushNamed(context, '/dashboard-home');
                break;
              case 'prices':
                Navigator.pushNamed(context, '/live-gold-prices');
                break;
              case 'news':
                Navigator.pushNamed(context, '/news-feed');
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'dashboard',
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'dashboard',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text('Dashboard'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'prices',
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'trending_up',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text('Live Prices'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'news',
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'article',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text('News Feed'),
                ],
              ),
            ),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Market Analysis',
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'schedule',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Updated: ${_formatTime(_lastRefresh)}',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color:
                          AppTheme.getSuccessColor(true).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.getSuccessColor(true),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Live',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.getSuccessColor(true),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
