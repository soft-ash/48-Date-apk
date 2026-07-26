import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';
import '../controller/otp_controller.dart';

class OtpHeader extends GetView<OtpController> {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Your Number',
          style: AppTextStyle.h5(weight: AppTextStyle.bold),
        ),
        SizedBox(height: 12.h),
        RichText(
          text: TextSpan(
            style: AppTextStyle.bodyMedium(weight: AppTextStyle.regular).copyWith(
              color: AppColor.gray600,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: "Enter the code we've sent by text to\n"),
              TextSpan(
                text: "${controller.formattedPhoneNumber} ",
                style: AppTextStyle.bodyMedium(weight: AppTextStyle.medium).copyWith(
                  color: AppColor.gray900,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    "Change",
                    style: AppTextStyle.bodyMedium(
                      weight: AppTextStyle.semiBold,
                    ).copyWith(
                      color: AppColor.error500,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.error500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
