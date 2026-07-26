import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/interest_controller.dart';

class InterestOptions extends GetView<InterestController> {
  const InterestOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Interests',
          style: AppTextStyle.h5(
            weight: AppTextStyle.bold,
          ).copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 12.h),
        Text(
          'Pick up to 5 things you love. It\'ll help you match with people who love them too.',
          style: AppTextStyle.bodySmall(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray700, height: 1.5),
        ),
        SizedBox(height: 24.h),
        ...controller.categorizedInterests.entries.map((entry) {
          final category = entry.key;
          final items = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTextStyle.bodyLarge(
                    weight: AppTextStyle.bold,
                  ).copyWith(color: AppColor.gray900),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: items.map((item) {
                    final label = item['label']!;
                    final emoji = item['emoji']!;
                    return Obx(() {
                      final isSelected =
                          controller.selectedInterests.contains(label);
                      return GestureDetector(
                        onTap: () => controller.toggleInterest(label),
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.primary500
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primary500
                                  : AppColor.gray200,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(emoji, style: TextStyle(fontSize: 14.sp)),
                              SizedBox(width: 6.w),
                              Text(
                                label,
                                style: AppTextStyle.bodyMedium(
                                  weight: isSelected
                                      ? AppTextStyle.medium
                                      : AppTextStyle.regular,
                                ).copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColor.gray800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ],
            ),
          );
        }),
        Obx(() {
          if (controller.errorText.value != null) {
            return Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                controller.errorText.value!,
                style: AppTextStyle.bodySmall().copyWith(
                  color: AppColor.error500,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
