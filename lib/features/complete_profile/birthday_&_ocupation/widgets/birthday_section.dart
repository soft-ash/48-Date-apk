import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/birthday_occupation_controller.dart';

class BirthdaySection extends StatelessWidget {
  const BirthdaySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BirthdayOccupationController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When’s Your Birthday?',
          style: AppTextStyle.h5(weight: AppTextStyle.bold)
              .copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 8.h),
        Text(
          'You must be 18+. We show your age, never your exact date.',
          style: AppTextStyle.bodySmall(weight: AppTextStyle.regular)
              .copyWith(color: AppColor.gray600),
        ),
        SizedBox(height: 20.h),
        Obx(() {
          final bool hasError = controller.birthdayError.value != null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildDateBox(
                      label: 'Month',
                      hint: '06',
                      controller: controller.monthController,
                      hasError: hasError,
                      onTap: () => controller.openWheelDatePicker(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: _buildDateBox(
                      label: 'Day',
                      hint: '06',
                      controller: controller.dayController,
                      hasError: hasError,
                      onTap: () => controller.openWheelDatePicker(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 3,
                    child: _buildDateBox(
                      label: 'Year',
                      hint: '1997',
                      controller: controller.yearController,
                      hasError: hasError,
                      onTap: () => controller.openWheelDatePicker(context),
                    ),
                  ),
                ],
              ),
              if (hasError) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const Icon(Icons.error, color: AppColor.error500, size: 16),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        controller.birthdayError.value!,
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

  Widget _buildDateBox({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool hasError,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.gray900,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: hasError ? AppColor.error500 : AppColor.gray300,
                width: 1,
              ),
            ),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, val, child) {
                final text = val.text;
                final isEmpty = text.isEmpty;
                return Text(
                  isEmpty ? hint : text,
                  style: TextStyle(
                    fontSize: 14,
                    color: isEmpty ? AppColor.gray400 : AppColor.gray900,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
