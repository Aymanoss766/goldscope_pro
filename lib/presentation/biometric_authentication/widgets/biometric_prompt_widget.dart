import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BiometricPromptWidget extends StatelessWidget {
  final String biometricIcon;
  final String biometricLabel;
  final Animation<double> pulseAnimation;
  final bool isAuthenticating;
  final VoidCallback onAuthenticate;
  final VoidCallback onShowPasscode;
  final bool biometricAvailable;

  const BiometricPromptWidget({
    Key? key,
    required this.biometricIcon,
    required this.biometricLabel,
    required this.pulseAnimation,
    required this.isAuthenticating,
    required this.onAuthenticate,
    required this.onShowPasscode,
    required this.biometricAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Biometric Icon with Pulse Animation
        AnimatedBuilder(
          animation: pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isAuthenticating ? 1.0 : pulseAnimation.value,
              child: Container(
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                  color: biometricAvailable
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.onSurface
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.5.w),
                  border: Border.all(
                    color: biometricAvailable
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3)
                        : AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isAuthenticating
                      ? SizedBox(
                          width: 8.w,
                          height: 8.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        )
                      : CustomIconWidget(
                          iconName: biometricIcon,
                          color: biometricAvailable
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                          size: 10.w,
                        ),
                ),
              ),
            );
          },
        ),

        SizedBox(height: 4.h),

        // Authentication Message
        Text(
          'Unlock to view your gold portfolio',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 2.h),

        Text(
          biometricAvailable
              ? 'Use $biometricLabel to securely access your account'
              : 'Biometric authentication not available',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 6.h),

        // Biometric Authentication Button
        if (biometricAvailable) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAuthenticating ? null : onAuthenticate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.w),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isAuthenticating) ...[
                    CustomIconWidget(
                      iconName: biometricIcon,
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                  ],
                  Text(
                    isAuthenticating
                        ? 'Authenticating...'
                        : 'Use $biometricLabel',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],

        // Fallback Passcode Option
        TextButton(
          onPressed: onShowPasscode,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.lightTheme.colorScheme.primary,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'lock',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 4.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Enter Passcode',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
