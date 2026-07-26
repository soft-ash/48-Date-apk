import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';

class NicknameController extends GetxController {
  final TextEditingController nicknameController = TextEditingController();
  final RxnString errorText = RxnString();

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  final List<String> suggestions = [
    'GoldenHour',
    'WildRose',
    'CityLights',
    'NorthPeak',
  ];

  @override
  void onClose() {
    nicknameController.dispose();
    super.onClose();
  }

  void onSuggestionSelected(String suggestion) {
    nicknameController.text = suggestion;
    errorText.value = null;
  }

  Future<void> onContinuePressed() async {
    final name = nicknameController.text.trim();
    if (name.isEmpty) {
      errorText.value = 'Please enter a nickname';
      AppLogger.warning('Nickname is empty');
      return;
    }
    if (name.length < 3) {
      errorText.value = 'Nickname must be at least 3 characters';
      AppLogger.warning('Nickname is too short');
      return;
    }

    errorText.value = null;

    try {
      await Future.delayed(const Duration(milliseconds: 600));
      AppLogger.dismiss();
      commonController.setNickname(name);
      Get.toNamed(AppRoutes.realName);
    } catch (e) {
      AppLogger.dismiss();
      AppLogger.error('Failed to save nickname: $e');
    }
  }
}
