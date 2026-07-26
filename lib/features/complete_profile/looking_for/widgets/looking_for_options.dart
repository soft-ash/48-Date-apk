import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/selection_option_card.dart';
import 'package:donnymaestro/core/widgets/custom_header.dart';
import '../controllers/looking_for_controller.dart';

class LookingForOptions extends GetView<LookingForController> {
  const LookingForOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(
          title: 'What Are You Looking For?',
          subtitle:
              'Be honest—it helps our AI match you with the right people.',
        ),
        SizedBox(height: 24.h),
        ...controller.options.map((option) {
          final title = option['title']!;
          final subtitle = option['subtitle']!;
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Obx(() {
              final isSelected = controller.selectedOption.value == title;
              return SelectionOptionCard(
                text: title,
                subtitle: subtitle,
                isSelected: isSelected,
                onTap: () => controller.selectOption(title),
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
