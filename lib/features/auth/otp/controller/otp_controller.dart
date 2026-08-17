import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/logger/logger.dart';
import '../../../../routes/app_routes.dart';
import '../../phone/controller/phone_controller.dart';
import 'package:logger_barta/logger_barta.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final RxBool isOtpComplete = false.obs;
  final RxInt remainingSeconds = 30.obs;
  Timer? _timer;

  String get formattedPhoneNumber {
    if (Get.arguments is String && (Get.arguments as String).isNotEmpty) {
      return Get.arguments as String;
    }
    if (Get.arguments is Map && Get.arguments['phone'] != null) {
      return Get.arguments['phone'].toString();
    }
    if (Get.isRegistered<PhoneController>()) {
      final phoneCtrl = Get.find<PhoneController>();
      return '${phoneCtrl.countryCode.value}${phoneCtrl.phoneController.text}';
    }
    return '+8801787936155';
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();
    remainingSeconds.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void onPinChanged(String pin) {
    isOtpComplete.value = pin.length == 6;
  }

  void onPinCompleted(String pin) {
    isOtpComplete.value = true;
    verifyOtp();
  }

  void verifyOtp() {
    if (!isOtpComplete.value || pinController.text.length < 6) {
      AppLogger.warning('Please enter the 6-digit code');
      return;
    }

    BartaLog.debug('Verifying OTP: ${pinController.text}');
    AppLogger.loading(status: 'Verifying...');

    Future.delayed(const Duration(seconds: 2), () {
      AppLogger.dismiss();
      AppLogger.success('Number verified successfully!');
      Get.offAllNamed(AppRoutes.location);
    });
  }

  void resendOtp() {
    BartaLog.debug('Resending OTP to $formattedPhoneNumber');
    AppLogger.loading(status: 'Resending...');

    Future.delayed(const Duration(seconds: 1), () {
      AppLogger.dismiss();
      AppLogger.success('A new code has been sent');
      pinController.clear();
      isOtpComplete.value = false;
      startTimer();
      focusNode.requestFocus();
    });
  }
}
