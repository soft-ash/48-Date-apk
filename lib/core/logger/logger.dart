import 'package:donnymaestro/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLogger {
  const AppLogger._();

  // ─── Premium EasyLoading Configuration ────────────────────────────────────
  static void _setupEasyLoading({
    required Color bgColor,
    required Color fgColor,
  }) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2500)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = bgColor
      ..textColor = fgColor
      ..indicatorColor = fgColor
      ..progressColor = fgColor
      ..radius = 16.0
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      )
      ..boxShadow = <BoxShadow>[
        BoxShadow(
          color: bgColor.withValues(alpha: 0.2),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ]
      ..textStyle = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: fgColor,
        letterSpacing: 0.3,
      )
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.black.withValues(alpha: 0.15)
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..toastPosition = EasyLoadingToastPosition.bottom;
  }

  static void success(String message) {
    _setupEasyLoading(bgColor: AppColor.success500, fgColor: Colors.white);
    EasyLoading.showSuccess(message);
  }

  static void error(String message) {
    _setupEasyLoading(bgColor: AppColor.error500, fgColor: Colors.white);
    EasyLoading.showError(message);
  }

  static void info(String message) {
    _setupEasyLoading(bgColor: AppColor.info500, fgColor: Colors.white);
    EasyLoading.showInfo(message);
  }

  static void warning(String message) {
    _setupEasyLoading(bgColor: AppColor.warning500, fgColor: Colors.white);
    EasyLoading.showToast(message);
  }

  static void loading({String status = 'Loading...'}) {
    _setupEasyLoading(bgColor: AppColor.gray900, fgColor: Colors.white);
    EasyLoading.show(status: status, dismissOnTap: false);
  }

  static void dismiss() => EasyLoading.dismiss();
}
