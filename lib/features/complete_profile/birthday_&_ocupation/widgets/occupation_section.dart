import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_header.dart';
import '../controllers/birthday_occupation_controller.dart';

class OccupationSection extends StatelessWidget {
  const OccupationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BirthdayOccupationController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(
          title: 'What is Your Occupation?',
          titleStyle: AppTextStyle.h6(
            weight: AppTextStyle.bold,
          ).copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 16.h),
        Obx(() {
          final bool hasError = controller.occupationError.value != null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Occupation',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.gray900,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller.occupationController,
                style: const TextStyle(fontSize: 14, color: AppColor.gray900),
                onChanged: (_) => controller.occupationError.value = null,
                decoration: InputDecoration(
                  hintText: 'Select or enter your occupation',
                  hintStyle: const TextStyle(
                    color: AppColor.gray400,
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        controller.onOccupationDropdownTapped(context),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColor.gray600,
                    ),
                    tooltip: "Choose from list",
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: hasError ? AppColor.error500 : AppColor.gray300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: hasError ? AppColor.error500 : AppColor.gray600,
                      width: 1,
                    ),
                  ),
                ),
              ),
              if (hasError) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const Icon(Icons.error, color: AppColor.error500, size: 16),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        controller.occupationError.value!,
                        style: const TextStyle(
                          color: AppColor.error500,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
        }),
      ],
    );
  }
}
