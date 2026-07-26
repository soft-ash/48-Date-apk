import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../controllers/nickname_controller.dart';

class NicknameSuggestions extends StatelessWidget {
  const NicknameSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NicknameController>();

    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: controller.suggestions.map((suggestion) {
        return InkWell(
          onTap: () => controller.onSuggestionSelected(suggestion),
          borderRadius: BorderRadius.circular(100.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: AppColor.gray300, width: 1),
            ),
            child: Text(
              suggestion,
              style: AppTextStyle.bodySmall(
                weight: AppTextStyle.medium,
              ).copyWith(color: AppColor.gray800),
            ),
          ),
        );
      }).toList(),
    );
  }
}
