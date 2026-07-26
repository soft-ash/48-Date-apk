import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../font/style/text_style.dart';
import 'screen_utils.dart';

class AppPicker {
  /// Shows a wheel date picker alert box specifically configured for birthdays
  static Future<DateTime?> showWheelDatePicker(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    return await showDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _WheelDatePickerDialog(initialDate: initialDate),
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
        constraints: BoxConstraints(maxHeight: Get.height * 0.65),
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

class _WheelDatePickerDialog extends StatefulWidget {
  final DateTime? initialDate;
  const _WheelDatePickerDialog({this.initialDate});

  @override
  State<_WheelDatePickerDialog> createState() => _WheelDatePickerDialogState();
}

class _WheelDatePickerDialogState extends State<_WheelDatePickerDialog> {
  late List<int> years;
  late int selectedMonthIndex;
  late int selectedDayIndex;
  late int selectedYearIndex;

  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController yearController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final int maxYear = now.year - 18; // Must be 18+
    final int minYear = 1920;
    years = List.generate(maxYear - minYear + 1, (index) => minYear + index);

    final defaultDate = widget.initialDate ?? DateTime(now.year - 20, 6, 15);
    selectedMonthIndex = (defaultDate.month - 1).clamp(0, 11);

    int yIdx = years.indexOf(defaultDate.year);
    if (yIdx == -1) yIdx = years.length - 1;
    selectedYearIndex = yIdx;

    final maxDays = _getDaysInMonth(years[selectedYearIndex], selectedMonthIndex + 1);
    selectedDayIndex = (defaultDate.day - 1).clamp(0, maxDays - 1);

    monthController = FixedExtentScrollController(initialItem: selectedMonthIndex);
    dayController = FixedExtentScrollController(initialItem: selectedDayIndex);
    yearController = FixedExtentScrollController(initialItem: selectedYearIndex);
  }

  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      final isLeapYear = (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
      return isLeapYear ? 29 : 28;
    }
    const daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonths[month - 1];
  }

  void _onMonthOrYearChanged() {
    final maxDays = _getDaysInMonth(years[selectedYearIndex], selectedMonthIndex + 1);
    if (selectedDayIndex >= maxDays) {
      setState(() {
        selectedDayIndex = maxDays - 1;
      });
      dayController.jumpToItem(selectedDayIndex);
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    monthController.dispose();
    dayController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxDays = _getDaysInMonth(years[selectedYearIndex], selectedMonthIndex + 1);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.r),
      ),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top pill indicator
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColor.gray200,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Choose Birthday',
              style: AppTextStyle.h5(weight: AppTextStyle.bold)
                  .copyWith(color: AppColor.gray900),
            ),
            SizedBox(height: 4.h),
            Text(
              'Select your birth date (18+ only)',
              style: AppTextStyle.bodySmall(weight: AppTextStyle.regular)
                  .copyWith(color: AppColor.gray500),
            ),
            SizedBox(height: 24.h),

            // 3-Column Wheel Picker
            SizedBox(
              height: 200.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background selection boxes
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColor.primary50,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: AppColor.primary200, width: 1.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                        child: Center(
                          child: Text(
                            '/',
                            style: TextStyle(
                              color: AppColor.gray300,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColor.primary50,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: AppColor.primary200, width: 1.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                        child: Center(
                          child: Text(
                            '/',
                            style: TextStyle(
                              color: AppColor.gray300,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColor.primary50,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: AppColor.primary200, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Scrolling Wheels
                  Row(
                    children: [
                      // Month Wheel
                      Expanded(
                        flex: 2,
                        child: CupertinoPicker.builder(
                          scrollController: monthController,
                          itemExtent: 48.h,
                          selectionOverlay: const SizedBox.shrink(),
                          backgroundColor: Colors.transparent,
                          onSelectedItemChanged: (index) {
                            selectedMonthIndex = index;
                            _onMonthOrYearChanged();
                          },
                          childCount: 12,
                          itemBuilder: (context, index) {
                            final isSelected = (index == selectedMonthIndex);
                            final monthNum = (index + 1).toString().padLeft(2, '0');
                            return Center(
                              child: Text(
                                monthNum,
                                style: TextStyle(
                                  fontSize: isSelected ? 20.sp : 16.sp,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? AppColor.primary500 : AppColor.gray400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 24.w),
                      // Day Wheel
                      Expanded(
                        flex: 2,
                        child: CupertinoPicker.builder(
                          scrollController: dayController,
                          itemExtent: 48.h,
                          selectionOverlay: const SizedBox.shrink(),
                          backgroundColor: Colors.transparent,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedDayIndex = index;
                            });
                          },
                          childCount: maxDays,
                          itemBuilder: (context, index) {
                            final isSelected = (index == selectedDayIndex);
                            final dayNum = (index + 1).toString().padLeft(2, '0');
                            return Center(
                              child: Text(
                                dayNum,
                                style: TextStyle(
                                  fontSize: isSelected ? 20.sp : 16.sp,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? AppColor.primary500 : AppColor.gray400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 24.w),
                      // Year Wheel
                      Expanded(
                        flex: 3,
                        child: CupertinoPicker.builder(
                          scrollController: yearController,
                          itemExtent: 48.h,
                          selectionOverlay: const SizedBox.shrink(),
                          backgroundColor: Colors.transparent,
                          onSelectedItemChanged: (index) {
                            selectedYearIndex = index;
                            _onMonthOrYearChanged();
                          },
                          childCount: years.length,
                          itemBuilder: (context, index) {
                            final isSelected = (index == selectedYearIndex);
                            final yearNum = years[index].toString();
                            return Center(
                              child: Text(
                                yearNum,
                                style: TextStyle(
                                  fontSize: isSelected ? 20.sp : 16.sp,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? AppColor.primary500 : AppColor.gray400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 28.h),

            // Bottom Buttons: Cancel | Done
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: AppColor.gray200, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.bodyMedium(weight: AppTextStyle.semiBold)
                          .copyWith(color: AppColor.gray700),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final year = years[selectedYearIndex];
                      final month = selectedMonthIndex + 1;
                      final day = selectedDayIndex + 1;
                      Navigator.of(context).pop(DateTime(year, month, day));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary500,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: AppTextStyle.bodyMedium(weight: AppTextStyle.bold)
                          .copyWith(color: Colors.white),
                    ),
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

