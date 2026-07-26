import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../otp/screen/otp_screen.dart';
import '../widgets/verification_dialog.dart';

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
          Get.to(
            () => const OtpScreen(),
            arguments: '${countryCode.value}${phoneController.text}',
          );
        },
      ),
    );
  }
}
