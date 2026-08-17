import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger_barta/logger_barta.dart';

class BottomNavbarController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTabIndex(int index) {
    if (currentIndex.value == index) return;

    HapticFeedback.lightImpact();
    currentIndex.value = index;

    BartaLog.debug("Switched to tab index: $index", tag: "Tab Changed");
  }
}
