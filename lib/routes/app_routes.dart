import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/biometric_authentication/biometric_authentication.dart';
import '../presentation/dashboard_home/dashboard_home.dart';
import '../presentation/news_feed/news_feed.dart';
import '../presentation/live_gold_prices/live_gold_prices.dart';
import '../presentation/market_analysis/market_analysis.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String biometricAuthentication = '/biometric-authentication';
  static const String dashboardHome = '/dashboard-home';
  static const String newsFeed = '/news-feed';
  static const String liveGoldPrices = '/live-gold-prices';
  static const String marketAnalysis = '/market-analysis';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    biometricAuthentication: (context) => const BiometricAuthentication(),
    dashboardHome: (context) => const DashboardHome(),
    newsFeed: (context) => const NewsFeed(),
    liveGoldPrices: (context) => const LiveGoldPrices(),
    marketAnalysis: (context) => const MarketAnalysis(),
    // TODO: Add your other routes here
  };
}
