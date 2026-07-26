import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controller/otp_controller.dart';

class OtpBottomActions extends GetView<OtpController> {
  const OtpBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.remainingSeconds.value > 0) {
            return RichText(
              text: TextSpan(
                style: AppTextStyle.bodySmall(
                  weight: AppTextStyle.regular,
                ).copyWith(color: AppColor.gray600),
                children: [
                  const TextSpan(text: 'This text should arrive within '),
                  TextSpan(
                    text: '${controller.remainingSeconds.value}s',
                    style: AppTextStyle.bodySmall(
                      weight: AppTextStyle.medium,
                    ).copyWith(color: AppColor.error500),
                  ),
                ],
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Didn't get a text? ",
                  style: AppTextStyle.bodySmall(
                    weight: AppTextStyle.regular,
                  ).copyWith(color: AppColor.gray600),
                ),
                GestureDetector(
                  onTap: controller.resendOtp,
                  child: Text(
                    "Resend",
                    style: AppTextStyle.bodySmall(weight: AppTextStyle.semiBold)
                        .copyWith(
                          color: AppColor.error500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.error500,
                        ),
                  ),
                ),
              ],
            );
          }
        }),
        SizedBox(height: 16.h),
        Obx(
          () => CustomButton(
            text: 'Next',
            onPressed: controller.isOtpComplete.value
                ? controller.verifyOtp
                : () {
                    controller.verifyOtp();
                  },
            color: controller.isOtpComplete.value
                ? AppColor.error500
                : AppColor.primary200,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
