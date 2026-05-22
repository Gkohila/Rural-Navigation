import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Material 3 color tokens from the Tenkasi SmartNav HTML design.
abstract final class SmartNavColors {
  static const Color surfaceVariant = Color(0xFFE2E2E2);
  static const Color onSurface = Color(0xFF1A1C1C);
  static const Color outlineVariant = Color(0xFFC0C9BB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color onSurfaceVariant = Color(0xFF41493E);
  static const Color onPrimaryContainer = Color(0xFF90D689);
  static const Color surfaceContainerLow = Color(0xFFF3F3F3);
  static const Color secondary = Color(0xFF00639A);
  static const Color error = Color(0xFFBA1A1A);
  static const Color background = Color(0xFFF9F9F9);
  static const Color primaryContainer = Color(0xFF1B5E20);
  static const Color surface = Color(0xFFF9F9F9);
  static const Color primary = Color(0xFF00450D);
  static const Color surfaceContainerHighest = Color(0xFFE2E2E2);
  static const Color outline = Color(0xFF717A6D);
  static const Color surfaceContainer = Color(0xFFEEEEEE);
  static const Color surfaceContainerHigh = Color(0xFFE8E8E8);
  static const Color primaryFixed = Color(0xFFACF4A4);
  static const Color onPrimaryFixed = Color(0xFF002203);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1A1C1C);
  static const Color surfaceDim = Color(0xFFDADADA);
  static const Color mapBase = Color(0xFFE4E8E2);
  static const Color mapRoad = Color(0xFFF7F8F5);
  static const Color mapRoadDim = Color(0xFFD8DED4);
}

/// Spacing and radius tokens aligned with code.html + screenshot polish.
abstract final class SmartNavSpacing {
  static const double unit = 8;
  static const double containerPaddingMobile = 16;
  static const double gutter = 24;
  static const double cardGap = 16;
  static const double mapHeight = 300;
  static const double sheetOverlap = 48;
  static const double sheetTopRadius = 32;
  static const double bottomNavClearance = 112;
  static const double headerVertical = 6;
  static const double searchOuterVertical = 8;
  static const double searchInnerPadding = 10;
  static const double transportChipGap = 20;
  static const double filterChipGap = 10;
}

/// Material 3 elevation shadows (soft).
abstract final class SmartNavElevation {
  static List<BoxShadow> get header => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get card => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get sheet => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 24,
          offset: const Offset(0, -6),
        ),
      ];

  static List<BoxShadow> get bottomNav => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, -2),
        ),
      ];
}

/// Typography — refined hierarchy (slightly smaller, softer weights).
abstract final class SmartNavTextStyles {
  static TextStyle get bodyMd => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: SmartNavColors.onSurface,
      );

  static TextStyle get labelLg => GoogleFonts.plusJakartaSans(
        fontSize: 13,
        height: 1.35,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w600,
        color: SmartNavColors.onSurface,
      );

  static TextStyle get labelSm => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        height: 1.35,
        fontWeight: FontWeight.w500,
        color: SmartNavColors.onSurfaceVariant,
      );

  /// Screen / sheet section titles.
  static TextStyle get headlineMd => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: SmartNavColors.onSurface,
      );

  static TextStyle get headlineMdBold => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: SmartNavColors.primary,
      );

  /// Route card duration (primary green).
  static TextStyle get titleSm => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w600,
        color: SmartNavColors.primary,
      );

  static TextStyle get bodyLg => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        height: 1.4,
        fontWeight: FontWeight.w400,
        color: SmartNavColors.onSurface,
      );
}

/// Application-wide Material 3 theme.
abstract final class SmartNavTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: SmartNavColors.primary,
      onPrimary: SmartNavColors.onPrimary,
      primaryContainer: SmartNavColors.primaryContainer,
      onPrimaryContainer: SmartNavColors.onPrimaryContainer,
      secondary: SmartNavColors.secondary,
      onSecondary: SmartNavColors.onPrimary,
      error: SmartNavColors.error,
      onError: SmartNavColors.onPrimary,
      surface: SmartNavColors.surface,
      onSurface: SmartNavColors.onSurface,
      surfaceContainerHighest: SmartNavColors.surfaceContainerHighest,
      surfaceContainerHigh: SmartNavColors.surfaceContainerHigh,
      surfaceContainer: SmartNavColors.surfaceContainer,
      surfaceContainerLow: SmartNavColors.surfaceContainerLow,
      surfaceContainerLowest: SmartNavColors.surfaceContainerLowest,
      outline: SmartNavColors.outline,
      outlineVariant: SmartNavColors.outlineVariant,
      onSurfaceVariant: SmartNavColors.onSurfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: SmartNavColors.background,
      textTheme: TextTheme(
        bodyMedium: SmartNavTextStyles.bodyMd,
        labelLarge: SmartNavTextStyles.labelLg,
        labelSmall: SmartNavTextStyles.labelSm,
        headlineMedium: SmartNavTextStyles.headlineMd,
        bodyLarge: SmartNavTextStyles.bodyLg,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: SmartNavColors.surface,
        foregroundColor: SmartNavColors.primary,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        titleTextStyle: SmartNavTextStyles.headlineMdBold,
      ),
    );
  }
}
