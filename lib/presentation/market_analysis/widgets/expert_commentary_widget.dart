import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ExpertCommentaryWidget extends StatefulWidget {
  final List<dynamic> commentary;

  const ExpertCommentaryWidget({
    Key? key,
    required this.commentary,
  }) : super(key: key);

  @override
  State<ExpertCommentaryWidget> createState() => _ExpertCommentaryWidgetState();
}

class _ExpertCommentaryWidgetState extends State<ExpertCommentaryWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 3.h),
          _buildCommentaryCarousel(),
          SizedBox(height: 2.h),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'person',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(width: 3.w),
        Text(
          'Expert Commentary',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${widget.commentary.length} Experts',
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentaryCarousel() {
    return SizedBox(
      height: 35.h,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.commentary.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> comment =
              widget.commentary[index] as Map<String, dynamic>;
          return _buildCommentaryCard(comment);
        },
      ),
    );
  }

  Widget _buildCommentaryCard(Map<String, dynamic> comment) {
    final String author = comment["author"] ?? "";
    final String title = comment["title"] ?? "";
    final String company = comment["company"] ?? "";
    final String summary = comment["summary"] ?? "";
    final String fullArticle = comment["fullArticle"] ?? "";
    final String timestamp = comment["timestamp"] ?? "";
    final double rating = (comment["rating"] ?? 0.0).toDouble();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpertHeader(author, title, company, rating),
          SizedBox(height: 2.h),
          _buildSummary(summary),
          SizedBox(height: 2.h),
          _buildReadMoreButton(fullArticle),
          const Spacer(),
          _buildTimestamp(timestamp),
        ],
      ),
    );
  }

  Widget _buildExpertHeader(
      String author, String title, String company, double rating) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6.w,
          backgroundColor:
              AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          child: Text(
            author.isNotEmpty ? author[0].toUpperCase() : 'E',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                company,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        _buildRatingWidget(rating),
      ],
    );
  }

  Widget _buildRatingWidget(double rating) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.getSuccessColor(true).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: 'star',
            color: AppTheme.getSuccessColor(true),
            size: 16,
          ),
          SizedBox(width: 1.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.getSuccessColor(true),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(String summary) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        summary,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          height: 1.5,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildReadMoreButton(String fullArticle) {
    return TextButton(
      onPressed: () {
        _showFullArticle(fullArticle);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        backgroundColor:
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Read Full Article',
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 2.w),
          CustomIconWidget(
            iconName: 'arrow_forward',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp(String timestamp) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'schedule',
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          size: 16,
        ),
        SizedBox(width: 2.w),
        Text(
          _formatTimestamp(timestamp),
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.commentary.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          width: _currentIndex == index ? 8.w : 2.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  void _showFullArticle(String fullArticle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Full Article',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  fullArticle,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final Duration difference = DateTime.now().difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else {
        return '${difference.inMinutes}m ago';
      }
    } catch (e) {
      return 'Recently';
    }
  }
}
