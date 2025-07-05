import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BreakingNewsBannerWidget extends StatefulWidget {
  final List<Map<String, dynamic>> breakingNews;
  final Function(Map<String, dynamic>) onTap;

  const BreakingNewsBannerWidget({
    Key? key,
    required this.breakingNews,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BreakingNewsBannerWidget> createState() =>
      _BreakingNewsBannerWidgetState();
}

class _BreakingNewsBannerWidgetState extends State<BreakingNewsBannerWidget>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.repeat(reverse: true);

    // Auto-scroll through breaking news
    if (widget.breakingNews.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _pageController.hasClients) {
        _currentIndex = (_currentIndex + 1) % widget.breakingNews.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.breakingNews.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 12.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.getErrorColor(true),
            AppTheme.getErrorColor(true).withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getErrorColor(true).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Breaking News Content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.breakingNews.length,
            itemBuilder: (context, index) {
              final news = widget.breakingNews[index];
              return GestureDetector(
                onTap: () => widget.onTap(news),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      // Breaking News Indicator
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: CustomIconWidget(
                                iconName: 'flash_on',
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(width: 3.w),

                      // News Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'BREAKING',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  news['publishedTime'],
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              news['headline'],
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Arrow Indicator
                      CustomIconWidget(
                        iconName: 'arrow_forward_ios',
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Page Indicators
          if (widget.breakingNews.length > 1)
            Positioned(
              bottom: 1.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.breakingNews.length,
                  (index) => Container(
                    width: index == _currentIndex ? 4.w : 2.w,
                    height: 0.5.h,
                    margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                    decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
