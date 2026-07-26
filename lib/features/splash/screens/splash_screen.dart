import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/background.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.put(SplashController());
    return BaseScreen(
      body: SafeArea(
        child: Center(
          child: Obx(
            () => AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: controller.showLogo.value ? 1.0 : 0.0,
              curve: Curves.easeOutCubic,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 700),
                scale: controller.showLogo.value ? 1.0 : 0.85,
                curve: Curves.easeOutCubic,
                child: Image.asset(
                  AppIcons.splash,
                  height: 80.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
