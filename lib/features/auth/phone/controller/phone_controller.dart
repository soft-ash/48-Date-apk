import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/verification_dialog.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';

class PhoneController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final RxString countryCode = '+880'.obs;
  final RxString countryFlag = '🇧🇩'.obs;
  
  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void updateCountry(String code, String flag) {
    countryCode.value = code;
    countryFlag.value = flag;
  }

  void onContinuePressed() {
    if (phoneController.text.isEmpty) return;
    
    // Show verification dialog
    Get.dialog(
      VerificationDialog(
        countryCode: countryCode.value,
        phoneNumber: phoneController.text,
        onOkPressed: () {
          Get.back();
          // Navigate to next screen (e.g. OTP)
        },
      ),
    );
  }
}
