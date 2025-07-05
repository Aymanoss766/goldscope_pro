import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FallbackPasscodeWidget extends StatelessWidget {
  final Function(String) onPasscodeEntered;
  final VoidCallback onForgotPasscode;
  final String passcode;

  const FallbackPasscodeWidget({
    Key? key,
    required this.onPasscodeEntered,
    required this.onForgotPasscode,
    required this.passcode,
  }) : super(key: key);

  void _onNumberPressed(String number) {
    if (passcode.length < 6) {
      HapticFeedback.lightImpact();
      onPasscodeEntered(passcode + number);
    }
  }

  void _onBackspacePressed() {
    if (passcode.isNotEmpty) {
      HapticFeedback.lightImpact();
      onPasscodeEntered(passcode.substring(0, passcode.length - 1));
    }
  }

  Widget _buildNumberButton(String number) {
    return Container(
      width: 18.w,
      height: 18.w,
      margin: EdgeInsets.all(1.w),
      child: ElevatedButton(
        onPressed: () => _onNumberPressed(number),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          foregroundColor: AppTheme.lightTheme.colorScheme.onSurface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.w),
            side: BorderSide(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          number,
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String iconName,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 18.w,
      height: 18.w,
      margin: EdgeInsets.all(1.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          foregroundColor: AppTheme.lightTheme.colorScheme.onSurface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.w),
            side: BorderSide(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          padding: EdgeInsets.zero,
        ),
        child: CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.onSurface,
          size: 6.w,
        ),
      ),
    );
  }

  Widget _buildPasscodeIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        final bool isFilled = index < passcode.length;
        return Container(
          width: 4.w,
          height: 4.w,
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color: isFilled
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2.w),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Passcode Header
        CustomIconWidget(
          iconName: 'lock',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 12.w,
        ),

        SizedBox(height: 3.h),

        Text(
          'Enter Passcode',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          'Enter your 6-digit passcode to continue',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 4.h),

        // Passcode Indicator
        _buildPasscodeIndicator(),

        SizedBox(height: 4.h),

        // Number Pad
        Column(
          children: [
            // Row 1: 1, 2, 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
              ],
            ),
            // Row 2: 4, 5, 6
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
              ],
            ),
            // Row 3: 7, 8, 9
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
              ],
            ),
            // Row 4: empty, 0, backspace
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 18.w, height: 18.w, margin: EdgeInsets.all(1.w)),
                _buildNumberButton('0'),
                _buildActionButton(
                  iconName: 'backspace',
                  onPressed: _onBackspacePressed,
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Forgot Passcode Link
        TextButton(
          onPressed: onForgotPasscode,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.lightTheme.colorScheme.primary,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
          ),
          child: Text(
            'Forgot Passcode?',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
