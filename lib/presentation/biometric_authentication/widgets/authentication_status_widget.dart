import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AuthenticationStatusWidget extends StatelessWidget {
  final String status;
  final bool isAuthenticating;

  const AuthenticationStatusWidget({
    Key? key,
    required this.status,
    required this.isAuthenticating,
  }) : super(key: key);

  Color _getStatusColor() {
    if (status.isEmpty) return Colors.transparent;

    if (status.contains('successful') || status.contains('Success')) {
      return AppTheme.lightTheme.colorScheme.tertiary;
    } else if (status.contains('failed') ||
        status.contains('error') ||
        status.contains('Incorrect')) {
      return AppTheme.lightTheme.colorScheme.error;
    } else if (status.contains('Authenticating')) {
      return AppTheme.lightTheme.colorScheme.primary;
    } else {
      return AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.7);
    }
  }

  IconData _getStatusIcon() {
    if (status.isEmpty) return Icons.info;

    if (status.contains('successful') || status.contains('Success')) {
      return Icons.check_circle;
    } else if (status.contains('failed') ||
        status.contains('error') ||
        status.contains('Incorrect')) {
      return Icons.error;
    } else if (status.contains('Authenticating')) {
      return Icons.security;
    } else {
      return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status.isEmpty && !isAuthenticating) {
      return const SizedBox.shrink();
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (status.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: _getStatusColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: _getStatusColor().withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: _getStatusIcon().codePoint.toString(),
                    color: _getStatusColor(),
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    child: Text(
                      status,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (isAuthenticating && status.isEmpty) ...[
            SizedBox(
              width: 6.w,
              height: 6.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Connecting to secure servers...',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
