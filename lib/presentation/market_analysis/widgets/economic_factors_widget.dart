import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EconomicFactorsWidget extends StatefulWidget {
  final List<dynamic> factors;

  const EconomicFactorsWidget({
    Key? key,
    required this.factors,
  }) : super(key: key);

  @override
  State<EconomicFactorsWidget> createState() => _EconomicFactorsWidgetState();
}

class _EconomicFactorsWidgetState extends State<EconomicFactorsWidget> {
  int? _expandedIndex;

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
          _buildFactorsList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'account_balance',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(width: 3.w),
        Text(
          'Economic Factors',
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
            '${widget.factors.length} Factors',
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFactorsList() {
    return Column(
      children: widget.factors.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, dynamic> factor = entry.value as Map<String, dynamic>;
        return _buildFactorCard(factor, index);
      }).toList(),
    );
  }

  Widget _buildFactorCard(Map<String, dynamic> factor, int index) {
    final bool isExpanded = _expandedIndex == index;
    final String title = factor["title"] ?? "";
    final String impact = factor["impact"] ?? "neutral";
    final int relevanceScore = factor["relevanceScore"] ?? 0;
    final String description = factor["description"] ?? "";
    final String details = factor["details"] ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildImpactIndicator(impact),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          title,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildRelevanceScore(relevanceScore),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: isExpanded ? 'expand_less' : 'expand_more',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded ? null : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detailed Analysis',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    details,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: 2.h),
                  _buildImpactDetails(impact, relevanceScore),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImpactIndicator(String impact) {
    Color impactColor;
    IconData impactIcon;

    switch (impact.toLowerCase()) {
      case 'positive':
        impactColor = AppTheme.getSuccessColor(true);
        impactIcon = Icons.trending_up;
        break;
      case 'negative':
        impactColor = AppTheme.getErrorColor(true);
        impactIcon = Icons.trending_down;
        break;
      default:
        impactColor = AppTheme.getWarningColor(true);
        impactIcon = Icons.trending_flat;
    }

    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: impactColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomIconWidget(
        iconName: _getIconName(impactIcon),
        color: impactColor,
        size: 16,
      ),
    );
  }

  Widget _buildRelevanceScore(int score) {
    Color scoreColor;
    if (score >= 80) {
      scoreColor = AppTheme.getSuccessColor(true);
    } else if (score >= 60) {
      scoreColor = AppTheme.getWarningColor(true);
    } else {
      scoreColor = AppTheme.getErrorColor(true);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: scoreColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$score%',
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: scoreColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImpactDetails(String impact, int relevanceScore) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Impact Direction:',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: _getImpactColor(impact).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  impact.toUpperCase(),
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: _getImpactColor(impact),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Relevance Score:',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              Text(
                '$relevanceScore/100',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          LinearProgressIndicator(
            value: relevanceScore / 100,
            backgroundColor:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            valueColor:
                AlwaysStoppedAnimation<Color>(_getScoreColor(relevanceScore)),
          ),
        ],
      ),
    );
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'positive':
        return AppTheme.getSuccessColor(true);
      case 'negative':
        return AppTheme.getErrorColor(true);
      default:
        return AppTheme.getWarningColor(true);
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) {
      return AppTheme.getSuccessColor(true);
    } else if (score >= 60) {
      return AppTheme.getWarningColor(true);
    } else {
      return AppTheme.getErrorColor(true);
    }
  }

  String _getIconName(IconData icon) {
    if (icon == Icons.trending_up) return 'trending_up';
    if (icon == Icons.trending_down) return 'trending_down';
    return 'trending_flat';
  }
}
