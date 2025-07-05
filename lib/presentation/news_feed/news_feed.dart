import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/breaking_news_banner_widget.dart';
import './widgets/news_article_card_widget.dart';
import './widgets/news_filter_widget.dart';
import './widgets/news_search_widget.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isSearching = false;
  String _selectedFilter = 'All Sources';
  List<String> _savedArticles = [];

  // Mock news data
  final List<Map<String, dynamic>> _newsArticles = [
    {
      "id": "1",
      "headline":
          "Gold Prices Surge to 6-Month High Amid Federal Reserve Policy Uncertainty",
      "source": "Financial Times",
      "sourceLogo":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=100&h=100&fit=crop",
      "publishedTime": "2 hours ago",
      "relevanceScore": 95,
      "thumbnail":
          "https://images.unsplash.com/photo-1610375461246-83df859d849d?w=300&h=200&fit=crop",
      "summary":
          "Gold futures climbed 2.3% as investors seek safe-haven assets amid growing concerns about Federal Reserve monetary policy shifts.",
      "keyPoints": [
        "Gold futures up 2.3% to \$2,045 per ounce",
        "Federal Reserve policy uncertainty drives demand",
        "Technical analysis suggests further upside potential"
      ],
      "goldImpact": "Highly Positive",
      "category": "Breaking News",
      "readingTime": "3 min read",
      "isBreaking": true
    },
    {
      "id": "2",
      "headline": "Central Bank Gold Purchases Hit Record High in Q3 2024",
      "source": "Reuters",
      "sourceLogo":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=100&h=100&fit=crop",
      "publishedTime": "4 hours ago",
      "relevanceScore": 88,
      "thumbnail":
          "https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=300&h=200&fit=crop",
      "summary":
          "Global central banks purchased 800 tonnes of gold in Q3, marking the highest quarterly acquisition in over a decade.",
      "keyPoints": [
        "Central banks bought 800 tonnes in Q3 2024",
        "China and India lead purchasing activity",
        "Diversification from US dollar reserves continues"
      ],
      "goldImpact": "Positive",
      "category": "Market Analysis",
      "readingTime": "5 min read",
      "isBreaking": false
    },
    {
      "id": "3",
      "headline": "Inflation Data Sparks Gold Rally as Hedge Demand Increases",
      "source": "Bloomberg",
      "sourceLogo":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=100&h=100&fit=crop",
      "publishedTime": "6 hours ago",
      "relevanceScore": 82,
      "thumbnail":
          "https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=300&h=200&fit=crop",
      "summary":
          "Latest inflation figures exceed expectations, driving investors toward gold as an inflation hedge.",
      "keyPoints": [
        "CPI rises 3.7% year-over-year, above forecast",
        "Gold ETF inflows surge 15% this week",
        "Institutional investors increase gold allocations"
      ],
      "goldImpact": "Positive",
      "category": "Economic Data",
      "readingTime": "4 min read",
      "isBreaking": false
    },
    {
      "id": "4",
      "headline":
          "Geopolitical Tensions Drive Safe-Haven Demand for Precious Metals",
      "source": "Wall Street Journal",
      "sourceLogo":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=100&h=100&fit=crop",
      "publishedTime": "8 hours ago",
      "relevanceScore": 75,
      "thumbnail":
          "https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=300&h=200&fit=crop",
      "summary":
          "Rising geopolitical tensions in multiple regions boost demand for gold and silver as safe-haven assets.",
      "keyPoints": [
        "Gold volatility increases amid global tensions",
        "Silver also benefits from safe-haven flows",
        "Mining stocks show mixed performance"
      ],
      "goldImpact": "Moderately Positive",
      "category": "Geopolitical",
      "readingTime": "6 min read",
      "isBreaking": false
    },
    {
      "id": "5",
      "headline":
          "Technical Analysis: Gold Breaks Key Resistance Level at \$2,040",
      "source": "MarketWatch",
      "sourceLogo":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=100&h=100&fit=crop",
      "publishedTime": "10 hours ago",
      "relevanceScore": 70,
      "thumbnail":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=300&h=200&fit=crop",
      "summary":
          "Gold futures break through critical resistance level, signaling potential for further upward movement.",
      "keyPoints": [
        "Gold breaks \$2,040 resistance level",
        "Next target at \$2,080 per ounce",
        "RSI indicates continued bullish momentum"
      ],
      "goldImpact": "Positive",
      "category": "Technical Analysis",
      "readingTime": "3 min read",
      "isBreaking": false
    }
  ];

  List<Map<String, dynamic>> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    _filteredArticles = List.from(_newsArticles);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreArticles();
    }
  }

  Future<void> _loadMoreArticles() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshNews() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _filteredArticles = List.from(_newsArticles);
      _isLoading = false;
    });
  }

  void _filterArticles(String filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'All Sources') {
        _filteredArticles = List.from(_newsArticles);
      } else if (filter == 'Breaking News') {
        _filteredArticles = _newsArticles
            .where((article) => article['isBreaking'] == true)
            .toList();
      } else if (filter == 'High Relevance') {
        _filteredArticles = _newsArticles
            .where((article) => (article['relevanceScore'] as int) >= 85)
            .toList();
      } else {
        _filteredArticles = _newsArticles
            .where((article) => article['source'] == filter)
            .toList();
      }
    });
  }

  void _searchArticles(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredArticles = List.from(_newsArticles);
      });
      return;
    }

    setState(() {
      _filteredArticles = _newsArticles.where((article) {
        return article['headline']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            article['summary']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
      }).toList();
    });
  }

  void _toggleSaveArticle(String articleId) {
    setState(() {
      if (_savedArticles.contains(articleId)) {
        _savedArticles.remove(articleId);
      } else {
        _savedArticles.add(articleId);
      }
    });
  }

  void _showArticlePreview(Map<String, dynamic> article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
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
                      article['headline'],
                      style: AppTheme.lightTheme.textTheme.headlineSmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        CustomImageWidget(
                          imageUrl: article['sourceLogo'],
                          width: 8.w,
                          height: 8.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          article['source'],
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: _getImpactColor(article['goldImpact'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            article['goldImpact'],
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: _getImpactColor(article['goldImpact']),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Summary',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      article['summary'],
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Key Points',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (article['keyPoints'] as List).length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 1.w,
                                  height: 1.w,
                                  margin: EdgeInsets.only(top: 1.h, right: 2.w),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    article['keyPoints'][index],
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Open full article
                            },
                            child: const Text('Read Full Article'),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        ElevatedButton(
                          onPressed: () {
                            _toggleSaveArticle(article['id']);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _savedArticles.contains(article['id'])
                                    ? AppTheme.lightTheme.colorScheme.secondary
                                    : AppTheme.lightTheme.colorScheme.surface,
                            foregroundColor: _savedArticles
                                    .contains(article['id'])
                                ? AppTheme.lightTheme.colorScheme.onSecondary
                                : AppTheme.lightTheme.colorScheme.primary,
                          ),
                          child: CustomIconWidget(
                            iconName: _savedArticles.contains(article['id'])
                                ? 'bookmark'
                                : 'bookmark_border',
                            color: _savedArticles.contains(article['id'])
                                ? AppTheme.lightTheme.colorScheme.onSecondary
                                : AppTheme.lightTheme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case 'Highly Positive':
        return AppTheme.getSuccessColor(true);
      case 'Positive':
        return AppTheme.getSuccessColor(true);
      case 'Moderately Positive':
        return AppTheme.getWarningColor(true);
      case 'Neutral':
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
      case 'Negative':
        return AppTheme.getErrorColor(true);
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'News Feed',
          style: AppTheme.lightTheme.textTheme.headlineSmall,
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: CustomIconWidget(
              iconName: _isSearching ? 'close' : 'search',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigate to saved articles
            },
            icon: CustomIconWidget(
              iconName: 'bookmark',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: Column(
        children: [
          // Breaking News Banner
          if (_newsArticles.any((article) => article['isBreaking'] == true))
            BreakingNewsBannerWidget(
              breakingNews: _newsArticles
                  .where((article) => article['isBreaking'] == true)
                  .toList(),
              onTap: _showArticlePreview,
            ),

          // Search Bar
          if (_isSearching)
            NewsSearchWidget(
              controller: _searchController,
              onChanged: _searchArticles,
              onClear: () {
                _searchController.clear();
                _searchArticles('');
              },
            ),

          // Filter Options
          NewsFilterWidget(
            selectedFilter: _selectedFilter,
            onFilterChanged: _filterArticles,
          ),

          // News Articles List
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshNews,
              color: AppTheme.lightTheme.colorScheme.primary,
              child: _filteredArticles.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'article',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 48,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'No articles found',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Try adjusting your filters or search terms',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      itemCount:
                          _filteredArticles.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= _filteredArticles.length) {
                          return Container(
                            padding: EdgeInsets.all(4.w),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.lightTheme.colorScheme.primary,
                              ),
                            ),
                          );
                        }

                        final article = _filteredArticles[index];
                        return NewsArticleCardWidget(
                          article: article,
                          isSaved: _savedArticles.contains(article['id']),
                          onTap: () => _showArticlePreview(article),
                          onSave: () => _toggleSaveArticle(article['id']),
                          onShare: () {
                            // Implement share functionality
                          },
                          onHideSource: () {
                            // Implement hide source functionality
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
