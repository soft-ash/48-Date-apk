import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../font/style/text_style.dart';
import 'screen_utils.dart';
import '../widgets/wheel_date_picker_dialog.dart';

class AppPicker {
  /// Shows a wheel date picker alert box specifically configured for birthdays
  static Future<DateTime?> showWheelDatePicker(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    return await showDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      builder: (context) => WheelDatePickerDialog(initialDate: initialDate),
    );
  }

  /// Shows a modal bottom sheet for picking from a list of options (e.g. occupations)
  static Future<String?> showOptionPicker(
    BuildContext context, {
    required String title,
    required List<String> options,
  }) async {
    return await Get.bottomSheet<String>(
      Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          constraints: BoxConstraints(maxHeight: Get.height * 0.65),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.h6(
                      weight: AppTextStyle.bold,
                    ).copyWith(color: AppColor.gray900),
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
                        style: AppTextStyle.bodyMedium(
                          weight: AppTextStyle.medium,
                        ).copyWith(color: AppColor.gray800),
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
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
