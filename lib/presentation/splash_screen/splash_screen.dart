import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _loadingAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _loadingAnimation;

  bool _isInitializing = true;
  bool _hasNetworkTimeout = false;
  double _initializationProgress = 0.0;
  String _currentTask = 'Initializing...';

  // Mock initialization tasks
  final List<String> _initializationTasks = [
    'Checking authentication status...',
    'Loading user preferences...',
    'Fetching market configuration...',
    'Preparing cached data...',
    'Establishing secure connections...',
    'Loading gold market data...',
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startInitialization();
  }

  void _setupAnimations() {
    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Loading animation controller
    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    // Loading animation
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start logo animation
    _logoAnimationController.forward();
  }

  Future<void> _startInitialization() async {
    try {
      // Simulate initialization process
      for (int i = 0; i < _initializationTasks.length; i++) {
        if (mounted) {
          setState(() {
            _currentTask = _initializationTasks[i];
            _initializationProgress = (i + 1) / _initializationTasks.length;
          });
        }

        // Simulate task delay
        await Future.delayed(const Duration(milliseconds: 500));

        // Simulate network timeout after 5 seconds
        if (i == 3) {
          await Future.delayed(const Duration(milliseconds: 2000));
        }
      }

      // Complete initialization
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });

        // Navigate based on mock authentication status
        await Future.delayed(const Duration(milliseconds: 500));
        _navigateToNextScreen();
      }
    } catch (e) {
      // Handle initialization error
      if (mounted) {
        setState(() {
          _hasNetworkTimeout = true;
          _isInitializing = false;
        });
      }
    }
  }

  void _navigateToNextScreen() {
    // Mock authentication check
    final bool isAuthenticated = DateTime.now().millisecond % 2 == 0;
    final bool isFirstTime = DateTime.now().millisecond % 3 == 0;

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/dashboard-home');
    } else if (isFirstTime) {
      // Navigate to onboarding (using biometric auth as placeholder)
      Navigator.pushReplacementNamed(context, '/biometric-authentication');
    } else {
      Navigator.pushReplacementNamed(context, '/biometric-authentication');
    }
  }

  void _retryInitialization() {
    setState(() {
      _hasNetworkTimeout = false;
      _isInitializing = true;
      _initializationProgress = 0.0;
      _currentTask = 'Retrying...';
    });
    _startInitialization();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.lightTheme.colorScheme.secondary,
              AppTheme.lightTheme.colorScheme.primary,
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Status bar spacing
              SizedBox(height: 8.h),

              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo section
                    AnimatedBuilder(
                      animation: _logoAnimationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: Opacity(
                            opacity: _logoFadeAnimation.value,
                            child: _buildLogo(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 6.h),

                    // App name
                    Text(
                      'GoldScope Pro',
                      style:
                          AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Tagline
                    Text(
                      'Professional Gold Market Analysis',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Loading section
                    _buildLoadingSection(),
                  ],
                ),
              ),

              // Bottom section
              _buildBottomSection(),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.1),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: 'trending_up',
          color: Colors.white,
          size: 12.w,
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    if (_hasNetworkTimeout) {
      return _buildRetrySection();
    }

    return Column(
      children: [
        // Loading indicator
        SizedBox(
          width: 60.w,
          child: Column(
            children: [
              // Progress bar
              Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: AnimatedBuilder(
                  animation: _loadingAnimationController,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _isInitializing ? _initializationProgress : 1.0,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withValues(alpha: 0.8),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 2.h),

              // Current task
              Text(
                _currentTask,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRetrySection() {
    return Column(
      children: [
        CustomIconWidget(
          iconName: 'wifi_off',
          color: Colors.white.withValues(alpha: 0.7),
          size: 8.w,
        ),
        SizedBox(height: 2.h),
        Text(
          'Connection Timeout',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Unable to connect to market data services',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Retry button
            ElevatedButton(
              onPressed: _retryInitialization,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.lightTheme.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 4.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Retry',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 4.w),

            // Offline mode button
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard-home');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              ),
              child: Text(
                'Continue Offline',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        // Version info
        Text(
          'Version 1.0.0',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 10.sp,
          ),
        ),

        SizedBox(height: 1.h),

        // Copyright
        Text(
          '© 2024 GoldScope Pro. All rights reserved.',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }
}
