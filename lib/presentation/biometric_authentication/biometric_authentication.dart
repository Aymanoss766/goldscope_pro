import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/authentication_status_widget.dart';
import './widgets/biometric_prompt_widget.dart';
import './widgets/fallback_passcode_widget.dart';
import 'widgets/authentication_status_widget.dart';
import 'widgets/biometric_prompt_widget.dart';
import 'widgets/fallback_passcode_widget.dart';

class BiometricAuthentication extends StatefulWidget {
  const BiometricAuthentication({Key? key}) : super(key: key);

  @override
  State<BiometricAuthentication> createState() =>
      _BiometricAuthenticationState();
}

class _BiometricAuthenticationState extends State<BiometricAuthentication>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _logoController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _logoAnimation;

  bool _isAuthenticating = false;
  bool _showPasscodeInput = false;
  bool _biometricAvailable = true;
  int _failedAttempts = 0;
  String _authenticationStatus = '';
  String _passcode = '';
  final int _maxFailedAttempts = 3;

  // Mock biometric types for demonstration
  final List<String> _availableBiometrics = ['face', 'fingerprint', 'touchId'];
  String _primaryBiometric = 'face';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkBiometricAvailability();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _pulseController.repeat(reverse: true);
    _logoController.forward();
  }

  void _checkBiometricAvailability() {
    // Mock biometric availability check
    setState(() {
      _biometricAvailable = _availableBiometrics.isNotEmpty;
      if (_biometricAvailable) {
        _primaryBiometric = _availableBiometrics.first;
      }
    });
  }

  Future<void> _authenticateWithBiometric() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
      _authenticationStatus = 'Authenticating...';
    });

    // Haptic feedback
    HapticFeedback.lightImpact();

    try {
      // Mock biometric authentication delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication result (80% success rate for demo)
      final bool isAuthenticated = DateTime.now().millisecond % 5 != 0;

      if (isAuthenticated) {
        _handleAuthenticationSuccess();
      } else {
        _handleAuthenticationFailure();
      }
    } catch (e) {
      _handleAuthenticationError(e.toString());
    }
  }

  void _handleAuthenticationSuccess() {
    setState(() {
      _isAuthenticating = false;
      _authenticationStatus = 'Authentication successful!';
    });

    // Success haptic feedback
    HapticFeedback.heavyImpact();

    // Navigate to dashboard after brief delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard-home');
      }
    });
  }

  void _handleAuthenticationFailure() {
    setState(() {
      _isAuthenticating = false;
      _failedAttempts++;
      _authenticationStatus = 'Authentication failed. Please try again.';
    });

    // Error haptic feedback
    HapticFeedback.vibrate();

    if (_failedAttempts >= _maxFailedAttempts) {
      setState(() {
        _showPasscodeInput = true;
        _authenticationStatus =
            'Too many failed attempts. Please enter your passcode.';
      });
    }

    // Clear status after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _authenticationStatus = '';
        });
      }
    });
  }

  void _handleAuthenticationError(String error) {
    setState(() {
      _isAuthenticating = false;
      _authenticationStatus = 'Authentication error: $error';
    });

    HapticFeedback.vibrate();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _authenticationStatus = '';
        });
      }
    });
  }

  void _togglePasscodeInput() {
    setState(() {
      _showPasscodeInput = true;
    });
  }

  void _onPasscodeEntered(String passcode) {
    setState(() {
      _passcode = passcode;
    });

    if (passcode.length == 6) {
      _validatePasscode(passcode);
    }
  }

  void _validatePasscode(String passcode) {
    // Mock passcode validation (correct passcode: 123456)
    const String correctPasscode = '123456';

    if (passcode == correctPasscode) {
      _handleAuthenticationSuccess();
    } else {
      setState(() {
        _passcode = '';
        _authenticationStatus = 'Incorrect passcode. Please try again.';
      });

      HapticFeedback.vibrate();

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _authenticationStatus = '';
          });
        }
      });
    }
  }

  void _handleForgotPasscode() {
    // Mock forgot passcode flow
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Account Recovery',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Please contact support to recover your account or use biometric authentication.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _exitApp() {
    SystemNavigator.pop();
  }

  String _getBiometricIcon() {
    switch (_primaryBiometric) {
      case 'face':
        return 'face';
      case 'fingerprint':
        return 'fingerprint';
      case 'touchId':
        return 'touch_app';
      default:
        return 'security';
    }
  }

  String _getBiometricLabel() {
    switch (_primaryBiometric) {
      case 'face':
        return 'Face ID';
      case 'fingerprint':
        return 'Fingerprint';
      case 'touchId':
        return 'Touch ID';
      default:
        return 'Biometric';
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _exitApp();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: Column(
              children: [
                // Logo Section
                Expanded(
                  flex: 2,
                  child: AnimatedBuilder(
                    animation: _logoAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color:
                                    AppTheme.lightTheme.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(4.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme
                                        .lightTheme.colorScheme.secondary
                                        .withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CustomIconWidget(
                                  iconName: 'auto_awesome',
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSecondary,
                                  size: 8.w,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              'GoldScope Pro',
                              style: AppTheme.lightTheme.textTheme.headlineSmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Authentication Section
                Expanded(
                  flex: 3,
                  child: _showPasscodeInput
                      ? FallbackPasscodeWidget(
                          onPasscodeEntered: _onPasscodeEntered,
                          onForgotPasscode: _handleForgotPasscode,
                          passcode: _passcode,
                        )
                      : BiometricPromptWidget(
                          biometricIcon: _getBiometricIcon(),
                          biometricLabel: _getBiometricLabel(),
                          pulseAnimation: _pulseAnimation,
                          isAuthenticating: _isAuthenticating,
                          onAuthenticate: _authenticateWithBiometric,
                          onShowPasscode: _togglePasscodeInput,
                          biometricAvailable: _biometricAvailable,
                        ),
                ),

                // Status Section
                Expanded(
                  flex: 1,
                  child: AuthenticationStatusWidget(
                    status: _authenticationStatus,
                    isAuthenticating: _isAuthenticating,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}