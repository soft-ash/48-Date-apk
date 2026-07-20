import 'dart:ui'; // Required for ImageFilter
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import 'screen_utils.dart';
// import 'app_color.dart';
// import 'app_screen_util.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color backgroundColor;
  final bool extendBodyBehindAppBar;
  final bool useSafeArea;

  const BaseScreen({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor =
        Colors.white, // Matches the clean white base from the design
    this.extendBodyBehindAppBar = false,
    this.useSafeArea =
        true, // Usually true to prevent UI from hiding under the status bar
  });

  @override
  Widget build(BuildContext context) {
    // Figma's Layer Blur is roughly 2x Flutter's standard sigma.
    // So 188.6 blur becomes ~94.3 sigma in Flutter to match exactly.
    const double sigma = 188.6 / 2;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        children: [
          // --- 1. Background Gradient Effects ---

          // Ellipse 2 (Top Left - Peach/Orange)
          Positioned(
            top: -60.h,
            left: -80.w,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: Container(
                width: 336.w,
                height: 336.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFB396).withValues(alpha: 0.40),
                ),
              ),
            ),
          ),

          // Ellipse 1 (Top Right - Primary Pink)
          Positioned(
            top: -40.h,
            right: -100.w,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: Container(
                width: 336.w,
                height: 336.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary300.withValues(
                    alpha: 0.40,
                  ), // Pulling from your AppColor
                ),
              ),
            ),
          ),

          // --- 2. Foreground Content (Your Screen Body) ---
          useSafeArea ? SafeArea(child: body) : body,
        ],
      ),
    );
  }
}
