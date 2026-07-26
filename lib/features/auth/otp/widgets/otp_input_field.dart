import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';
import '../controller/otp_controller.dart';

class OtpInputField extends GetView<OtpController> {
  const OtpInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 41.w,
      height: 48.h,
      textStyle: AppTextStyle.bodyLarge(
        weight: AppTextStyle.bold,
      ).copyWith(color: AppColor.gray900),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.gray300, width: 1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.error500, width: 1.5),
      borderRadius: BorderRadius.circular(12.r),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.gray300, width: 1),
      borderRadius: BorderRadius.circular(12.r),
    );

    return Center(
      child: Pinput(
        length: 6,
        controller: controller.pinController,
        focusNode: controller.focusNode,
        autofocus: true,
        keyboardType: TextInputType.number,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        separatorBuilder: (index) => SizedBox(width: 8.w),
        preFilledWidget: Text(
          'X',
          style: AppTextStyle.bodyLarge(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray400),
        ),
        onChanged: controller.onPinChanged,
        onCompleted: controller.onPinCompleted,
      ),
    );
  }
}
