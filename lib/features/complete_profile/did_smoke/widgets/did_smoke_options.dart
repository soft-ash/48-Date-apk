import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/selection_option_card.dart';
import '../../../../core/widgets/custom_header.dart';
import '../controllers/did_smoke_controller.dart';

class DidSmokeOptions extends GetView<DidSmokeController> {
  const DidSmokeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(title: 'Do You Smoke?'),
        SizedBox(height: 24.h),
        ...controller.options.map((option) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Obx(() {
              final isSelected = controller.selectedOption.value == option;
              return SelectionOptionCard(
                text: option,
                isSelected: isSelected,
                onTap: () => controller.selectOption(option),
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
