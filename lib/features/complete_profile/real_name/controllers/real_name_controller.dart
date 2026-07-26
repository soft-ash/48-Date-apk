import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class RealNameController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final RxnString firstNameError = RxnString();
  final RxnString lastNameError = RxnString();

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  Future<void> onContinuePressed() async {
    final first = firstNameController.text.trim();
    final last = lastNameController.text.trim();

    bool hasError = false;

    if (first.isEmpty) {
      firstNameError.value = 'Please enter your first name';
      hasError = true;
    } else {
      firstNameError.value = null;
    }

    if (last.isEmpty) {
      lastNameError.value = 'Please enter your last name';
      hasError = true;
    } else {
      lastNameError.value = null;
    }

    if (hasError) {
      AppLogger.warning('Please complete all required fields');
      return;
    }

    commonController.setRealName(first, last);
    AppLogger.success('Real name saved!');
    Get.toNamed(AppRoutes.birthdayOccupation);
  }
}
