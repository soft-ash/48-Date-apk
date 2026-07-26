import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';

class BottomNavbarController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTabIndex(int index) {
    if (currentIndex.value == index) return;

    HapticFeedback.lightImpact();
    currentIndex.value = index;

    AppLogger.consoleInfo(
      title: "Tab Changed",
      subtitle: "Switched to tab index: $index",
    );
  }
}
