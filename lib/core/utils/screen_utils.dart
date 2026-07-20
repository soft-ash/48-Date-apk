import 'package:flutter/material.dart';

class AppScreenUtil {
  // Figma base dimensions
  static const double figmaWidth = 375.0;
  static const double figmaHeight = 812.0;

  static late double screenWidth;
  static late double screenHeight;
  static bool _isInitialized = false;

  /// Call this inside the build method of your first screen or a wrapper widget
  static void init(BuildContext context) {
    if (_isInitialized) return;
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    _isInitialized = true;
  }
}

/// Extension to make usage incredibly clean (e.g., 20.w, 16.sp)
extension ResponsiveExtension on num {
  /// Responsive width: scales based on the screen's width compared to Figma
  double get w => (this / AppScreenUtil.figmaWidth) * AppScreenUtil.screenWidth;

  /// Responsive height: scales based on the screen's height compared to Figma
  double get h =>
      (this / AppScreenUtil.figmaHeight) * AppScreenUtil.screenHeight;

  /// Responsive font size: usually scales with width to maintain readability
  double get sp =>
      (this / AppScreenUtil.figmaWidth) * AppScreenUtil.screenWidth;

  /// Responsive radius: keeps border radii proportional
  double get r => (this / AppScreenUtil.figmaWidth) * AppScreenUtil.screenWidth;

  /// Helper for vertical spacing (SizedBox)
  Widget get vSpace => SizedBox(height: h);

  /// Helper for horizontal spacing (SizedBox)
  Widget get hSpace => SizedBox(width: w);
}
