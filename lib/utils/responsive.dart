import 'package:flutter/material.dart';

class Responsive {
  // Updated breakpoints for better responsiveness
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1100;
  static const double desktopBreakpoint = 1400;

  // Screen width checkers
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Device type checkers
  static bool isMobile(BuildContext context) =>
      screenWidth(context) < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) < tabletBreakpoint &&
          screenWidth(context) >= mobileBreakpoint;

  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= tabletBreakpoint;

  // For small tablets (between mobile and tablet)
  static bool isSmallTablet(BuildContext context) =>
      screenWidth(context) >= 600 && screenWidth(context) < 800;

  // For medium tablets
  static bool isMediumTablet(BuildContext context) =>
      screenWidth(context) >= 800 && screenWidth(context) < 1000;

  // Value adaptation
  static double responsiveValue({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return mobile;
    if (width < tabletBreakpoint) return tablet;
    return desktop;
  }

  static int responsiveGridCount({
    required BuildContext context,
    required int mobile,
    required int tablet,
    required int desktop,
  }) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return mobile;
    if (width < 900) return tablet; // Smaller breakpoint for grid
    return desktop;
  }

  // Adaptive font sizes
  static double adaptiveFontSize({
    required BuildContext context,
    required double baseSize,
  }) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return baseSize * 0.85;
    if (width < tabletBreakpoint) return baseSize * 0.95;
    return baseSize;
  }

  // Adaptive padding
  static EdgeInsets adaptivePadding({
    required BuildContext context,
    required EdgeInsets basePadding,
  }) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) {
      return EdgeInsets.symmetric(
        horizontal: basePadding.horizontal * 0.6,
        vertical: basePadding.vertical * 0.8,
      );
    }
    if (width < tabletBreakpoint) {
      return EdgeInsets.symmetric(
        horizontal: basePadding.horizontal * 0.8,
        vertical: basePadding.vertical * 0.9,
      );
    }
    return basePadding;
  }
}