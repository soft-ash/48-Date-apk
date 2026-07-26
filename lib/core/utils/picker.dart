import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../font/style/text_style.dart';
import 'screen_utils.dart';

class AppPicker {
  /// Shows a date picker specifically configured for birthdays (18+ validation)
  static Future<DateTime?> showBirthDatePicker(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    final now = DateTime.now();
    // Maximum date allowed for 18+ is 18 years ago today
    final maxDate = DateTime(now.year - 18, now.month, now.day);
    final minDate = DateTime(1900, 1, 1);

    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? maxDate,
      firstDate: minDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary500,
              onPrimary: Colors.white,
              onSurface: AppColor.gray900,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Shows a modal bottom sheet for picking from a list of options (e.g. occupations)
  static Future<String?> showOptionPicker(
    BuildContext context, {
    required String title,
    required List<String> options,
  }) async {
    return await Get.bottomSheet<String>(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.h6(weight: AppTextStyle.bold)
                      .copyWith(color: AppColor.gray900),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: AppColor.gray600),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (context, index) =>
                    Divider(color: AppColor.gray200, height: 1),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    title: Text(
                      option,
                      style: AppTextStyle.bodyMedium(weight: AppTextStyle.medium)
                          .copyWith(color: AppColor.gray800),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColor.gray400,
                    ),
                    onTap: () => Get.back(result: option),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
