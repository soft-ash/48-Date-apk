import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/selection_option_card.dart';
import '../controllers/have_kids_controller.dart';

class HaveKidsOptions extends GetView<HaveKidsController> {
  const HaveKidsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Do You Have Kids?
        Text(
          'Do You Have Kids?',
          style: AppTextStyle.h5(weight: AppTextStyle.bold)
              .copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 20.h),
        ...controller.kidsOptions.map((option) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Obx(() {
              final isSelected =
                  controller.selectedKidsOption.value == option;
              return SelectionOptionCard(
                text: option,
                isSelected: isSelected,
                onTap: () => controller.selectKidsOption(option),
              );
            }),
          );
        }),

        SizedBox(height: 24.h),

        // Section 2: Future Plan About Kids?
        Text(
          'Do you have any future plan about kids?',
          style: AppTextStyle.bodyLarge(weight: AppTextStyle.bold)
              .copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 20.h),
        ...controller.futurePlanOptions.map((option) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Obx(() {
              final isSelected =
                  controller.selectedFuturePlanOption.value == option;
              return SelectionOptionCard(
                text: option,
                isSelected: isSelected,
                onTap: () => controller.selectFuturePlanOption(option),
              );
            }),
          );
        }),

        Obx(() {
          if (controller.errorText.value != null) {
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
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
