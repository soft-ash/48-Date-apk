import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';

class VerificationDialog extends StatelessWidget {
  final String countryCode;
  final String phoneNumber;
  final VoidCallback onOkPressed;

  const VerificationDialog({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We need to verify your number',
              style: AppTextStyle.bodyMedium(weight: AppTextStyle.medium),
            ),
            SizedBox(height: 12.h),
            Text(
              'We need to make sure that $countryCode$phoneNumber is your number.',
              style: AppTextStyle.bodySmall(
                weight: AppTextStyle.regular,
              ).copyWith(color: AppColor.gray700, height: 1.5),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Cancel',
                    style: AppTextStyle.bodyMedium(
                      weight: AppTextStyle.medium,
                    ).copyWith(color: AppColor.error500),
                  ),
                ),
                SizedBox(width: 8.w),
                TextButton(
                  onPressed: onOkPressed,
                  child: Text(
                    'OK',
                    style: AppTextStyle.bodyMedium(
                      weight: AppTextStyle.medium,
                    ).copyWith(color: AppColor.error500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
