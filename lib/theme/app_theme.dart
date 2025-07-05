import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
class AppTheme {
  AppTheme._();

  // Sophisticated Gold Spectrum Color Palette
  static const Color primaryLight = Color(0xFF1B365D); // Deep financial blue
  static const Color primaryVariantLight =
      Color(0xFF0F2A47); // Darker blue variant
  static const Color secondaryLight = Color(0xFFD4AF37); // Classic gold accent
  static const Color secondaryVariantLight =
      Color(0xFFB8941F); // Darker gold variant
  static const Color backgroundLight =
      Color(0xFFFAFBFC); // Soft neutral background
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white surface
  static const Color errorLight = Color(0xFFEF4444); // Clear red for losses
  static const Color successLight = Color(0xFF10B981); // Modern green for gains
  static const Color warningLight = Color(0xFFF59E0B); // Amber for caution
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFF000000);
  static const Color onBackgroundLight =
      Color(0xFF111827); // High contrast dark
  static const Color onSurfaceLight = Color(0xFF111827);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  // Dark theme colors - adapted for financial app
  static const Color primaryDark =
      Color(0xFF4A90E2); // Lighter blue for dark mode
  static const Color primaryVariantDark = Color(0xFF1B365D);
  static const Color secondaryDark =
      Color(0xFFD4AF37); // Gold remains consistent
  static const Color secondaryVariantDark = Color(0xFFE6C547);
  static const Color backgroundDark = Color(0xFF0F172A); // Deep dark background
  static const Color surfaceDark = Color(0xFF1E293B); // Elevated surface
  static const Color errorDark = Color(0xFFEF4444);
  static const Color successDark = Color(0xFF10B981);
  static const Color warningDark = Color(0xFFF59E0B);
  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFF8FAFC);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onErrorDark = Color(0xFFFFFFFF);

  // Card and dialog colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF1E293B);

  // Shadow colors - minimal elevation system
  static const Color shadowLight = Color(0x0A000000); // Very subtle shadows
  static const Color shadowDark = Color(0x1A000000);

  // Border colors - space-first philosophy
  static const Color borderLight =
      Color(0xFFE5E7EB); // Subtle boundary definition
  static const Color borderDark = Color(0xFF374151);

  // Text colors with proper hierarchy
  static const Color textPrimaryLight = Color(0xFF111827); // High contrast
  static const Color textSecondaryLight = Color(0xFF6B7280); // Balanced gray
  static const Color textDisabledLight = Color(0xFF9CA3AF);

  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textDisabledDark = Color(0xFF64748B);

  /// Light theme optimized for financial mobile applications
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryLight,
          onPrimary: onPrimaryLight,
          primaryContainer: primaryVariantLight,
          onPrimaryContainer: onPrimaryLight,
          secondary: secondaryLight,
          onSecondary: onSecondaryLight,
          secondaryContainer: secondaryVariantLight,
          onSecondaryContainer: onSecondaryLight,
          tertiary: successLight,
          onTertiary: onPrimaryLight,
          tertiaryContainer: successLight.withValues(alpha: 0.1),
          onTertiaryContainer: successLight,
          error: errorLight,
          onError: onErrorLight,
          surface: surfaceLight,
          onSurface: onSurfaceLight,
          onSurfaceVariant: textSecondaryLight,
          outline: borderLight,
          outlineVariant: borderLight.withValues(alpha: 0.5),
          shadow: shadowLight,
          scrim: shadowLight,
          inverseSurface: surfaceDark,
          onInverseSurface: onSurfaceDark,
          inversePrimary: primaryDark),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: cardLight,
      dividerColor: borderLight,

      // AppBar theme for financial credibility
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceLight,
          foregroundColor: textPrimaryLight,
          elevation: 1.0, // Minimal elevation
          shadowColor: shadowLight,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimaryLight),
          iconTheme: IconThemeData(color: textPrimaryLight)),

      // Card theme with subtle elevation
      cardTheme: CardTheme(
          color: cardLight,
          elevation: 2.0,
          shadowColor: shadowLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation for mobile-first design
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceLight,
          selectedItemColor: primaryLight,
          unselectedItemColor: textSecondaryLight,
          type: BottomNavigationBarType.fixed,
          elevation: 8.0,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // FAB theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryLight,
          foregroundColor: onSecondaryLight,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes optimized for financial actions
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryLight,
              backgroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2.0,
              shadowColor: shadowLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w600))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: primaryLight, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w500))),

      // Typography using Inter font family
      textTheme: _buildTextTheme(isLight: true),

      // Input decoration for financial forms
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceLight,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderLight, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderLight, width: 1.0)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: primaryLight, width: 2.0)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorLight, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorLight, width: 2.0)),
          labelStyle: GoogleFonts.inter(color: textSecondaryLight, fontSize: 14, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledLight, fontSize: 14, fontWeight: FontWeight.w400),
          prefixIconColor: textSecondaryLight,
          suffixIconColor: textSecondaryLight),

      // Switch theme
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textDisabledLight;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withValues(alpha: 0.3);
        }
        return borderLight;
      })),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryLight;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryLight),
          side: BorderSide(color: borderLight, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),

      // Radio theme
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textSecondaryLight;
      })),

      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryLight, linearTrackColor: borderLight, circularTrackColor: borderLight),

      // Slider theme for financial ranges
      sliderTheme: SliderThemeData(activeTrackColor: primaryLight, thumbColor: primaryLight, overlayColor: primaryLight.withValues(alpha: 0.1), inactiveTrackColor: borderLight, trackHeight: 4.0, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0)),

      // Tab bar theme
      tabBarTheme: TabBarTheme(labelColor: primaryLight, unselectedLabelColor: textSecondaryLight, indicatorColor: primaryLight, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltip theme
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryLight.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8.0)), textStyle: GoogleFonts.inter(color: surfaceLight, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // SnackBar theme for smart alert overlays
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryLight, contentTextStyle: GoogleFonts.inter(color: surfaceLight, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: secondaryLight, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), elevation: 4.0),

      // List tile theme
      listTileTheme: ListTileThemeData(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), titleTextStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textPrimaryLight), subtitleTextStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: textSecondaryLight)),

      // Chip theme
      chipTheme: ChipThemeData(backgroundColor: borderLight.withValues(alpha: 0.3), selectedColor: primaryLight.withValues(alpha: 0.1), labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textPrimaryLight), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))), dialogTheme: DialogThemeData(backgroundColor: dialogLight));

  /// Dark theme optimized for financial mobile applications
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryDark,
          onPrimary: onPrimaryDark,
          primaryContainer: primaryVariantDark,
          onPrimaryContainer: onPrimaryDark,
          secondary: secondaryDark,
          onSecondary: onSecondaryDark,
          secondaryContainer: secondaryVariantDark,
          onSecondaryContainer: onSecondaryDark,
          tertiary: successDark,
          onTertiary: onPrimaryDark,
          tertiaryContainer: successDark.withValues(alpha: 0.2),
          onTertiaryContainer: successDark,
          error: errorDark,
          onError: onErrorDark,
          surface: surfaceDark,
          onSurface: onSurfaceDark,
          onSurfaceVariant: textSecondaryDark,
          outline: borderDark,
          outlineVariant: borderDark.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: shadowDark,
          inverseSurface: surfaceLight,
          onInverseSurface: onSurfaceLight,
          inversePrimary: primaryLight),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: cardDark,
      dividerColor: borderDark,

      // AppBar theme for dark mode
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceDark,
          foregroundColor: textPrimaryDark,
          elevation: 1.0,
          shadowColor: shadowDark,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimaryDark),
          iconTheme: IconThemeData(color: textPrimaryDark)),

      // Card theme for dark mode
      cardTheme: CardTheme(
          color: cardDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation for dark mode
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceDark,
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondaryDark,
          type: BottomNavigationBarType.fixed,
          elevation: 8.0,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // FAB theme for dark mode
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryDark,
          foregroundColor: onSecondaryDark,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes for dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryDark,
              backgroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2.0,
              shadowColor: shadowDark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w600))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: primaryDark, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w500))),

      // Typography for dark mode
      textTheme: _buildTextTheme(isLight: false),

      // Input decoration for dark mode
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderDark, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: borderDark, width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: primaryDark, width: 2.0)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorDark, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorDark, width: 2.0)),
          labelStyle: GoogleFonts.inter(color: textSecondaryDark, fontSize: 14, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledDark, fontSize: 14, fontWeight: FontWeight.w400),
          prefixIconColor: textSecondaryDark,
          suffixIconColor: textSecondaryDark),

      // Switch theme for dark mode
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textDisabledDark;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark.withValues(alpha: 0.3);
        }
        return borderDark;
      })),

      // Checkbox theme for dark mode
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryDark;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryDark),
          side: BorderSide(color: borderDark, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),

      // Radio theme for dark mode
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textSecondaryDark;
      })),

      // Progress indicator theme for dark mode
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryDark, linearTrackColor: borderDark, circularTrackColor: borderDark),

      // Slider theme for dark mode
      sliderTheme: SliderThemeData(activeTrackColor: primaryDark, thumbColor: primaryDark, overlayColor: primaryDark.withValues(alpha: 0.1), inactiveTrackColor: borderDark, trackHeight: 4.0, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0)),

      // Tab bar theme for dark mode
      tabBarTheme: TabBarTheme(labelColor: primaryDark, unselectedLabelColor: textSecondaryDark, indicatorColor: primaryDark, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltip theme for dark mode
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryDark.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8.0)), textStyle: GoogleFonts.inter(color: backgroundDark, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // SnackBar theme for dark mode
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryDark, contentTextStyle: GoogleFonts.inter(color: backgroundDark, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: secondaryDark, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), elevation: 4.0),

      // List tile theme for dark mode
      listTileTheme: ListTileThemeData(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), titleTextStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textPrimaryDark), subtitleTextStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: textSecondaryDark)),

      // Chip theme for dark mode
      chipTheme: ChipThemeData(backgroundColor: borderDark.withValues(alpha: 0.3), selectedColor: primaryDark.withValues(alpha: 0.2), labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textPrimaryDark), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))), dialogTheme: DialogThemeData(backgroundColor: dialogDark));

  /// Helper method to build text theme based on brightness using Inter font
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimary = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textSecondary =
        isLight ? textSecondaryLight : textSecondaryDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
        // Display styles for large headings
        displayLarge: GoogleFonts.inter(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: -0.25),
        displayMedium: GoogleFonts.inter(
            fontSize: 45, fontWeight: FontWeight.w400, color: textPrimary),
        displaySmall: GoogleFonts.inter(
            fontSize: 36, fontWeight: FontWeight.w400, color: textPrimary),

        // Headline styles for section headers
        headlineLarge: GoogleFonts.inter(
            fontSize: 32, fontWeight: FontWeight.w600, color: textPrimary),
        headlineMedium: GoogleFonts.inter(
            fontSize: 28, fontWeight: FontWeight.w600, color: textPrimary),
        headlineSmall: GoogleFonts.inter(
            fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),

        // Title styles for cards and components
        titleLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0),
        titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.15),
        titleSmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1),

        // Body text for main content
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.5),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textPrimary,
            letterSpacing: 0.25),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textSecondary,
            letterSpacing: 0.4),

        // Label styles for buttons and form elements
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textDisabled,
            letterSpacing: 0.5));
  }

  /// Helper method to get monospace text style for financial data
  static TextStyle getMonospaceStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final Color textColor = isLight ? textPrimaryLight : textPrimaryDark;
    return GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        letterSpacing: 0);
  }

  /// Helper method to get success color based on theme
  static Color getSuccessColor(bool isLight) {
    return isLight ? successLight : successDark;
  }

  /// Helper method to get warning color based on theme
  static Color getWarningColor(bool isLight) {
    return isLight ? warningLight : warningDark;
  }

  /// Helper method to get error color based on theme
  static Color getErrorColor(bool isLight) {
    return isLight ? errorLight : errorDark;
  }
}
