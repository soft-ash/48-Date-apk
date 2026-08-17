import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/core/utils/picker.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:logger_barta/logger_barta.dart';

class BirthdayOccupationController extends GetxController {
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  final FocusNode monthFocus = FocusNode();
  final FocusNode dayFocus = FocusNode();
  final FocusNode yearFocus = FocusNode();

  final RxnString birthdayError = RxnString();
  final RxnString occupationError = RxnString();

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  final List<String> occupationSuggestions = [
    'Software Engineer',
    'Doctor',
    'Student',
    'Artist',
    'Entrepreneur',
    'Designer',
    'Marketing Manager',
    'Finance / Banking',
    'Teacher',
    'Other',
  ];

  @override
  void onClose() {
    monthController.dispose();
    dayController.dispose();
    yearController.dispose();
    occupationController.dispose();
    monthFocus.dispose();
    dayFocus.dispose();
    yearFocus.dispose();
    super.onClose();
  }

  void onMonthChanged(String value) {
    birthdayError.value = null;
    if (value.length == 2) {
      dayFocus.requestFocus();
    }
  }

  void onDayChanged(String value) {
    birthdayError.value = null;
    if (value.length == 2) {
      yearFocus.requestFocus();
    }
  }

  void onYearChanged(String value) {
    birthdayError.value = null;
    if (value.length == 4) {
      yearFocus.unfocus();
    }
  }

  Future<void> openWheelDatePicker(BuildContext context) async {
    DateTime? initialDate;
    try {
      final int m = int.parse(monthController.text);
      final int d = int.parse(dayController.text);
      final int y = int.parse(yearController.text);
      initialDate = DateTime(y, m, d);
    } catch (_) {
      initialDate = null;
    }

    final selectedDate = await AppPicker.showWheelDatePicker(
      context,
      initialDate: initialDate,
    );
    if (selectedDate != null) {
      monthController.text = selectedDate.month.toString().padLeft(2, '0');
      dayController.text = selectedDate.day.toString().padLeft(2, '0');
      yearController.text = selectedDate.year.toString();
      birthdayError.value = null;
      BartaLog.debug(
        "Selected date: ${monthController.text}/${dayController.text}/${yearController.text}",
        tag: "openWheelDatePicker",
      );
    }
  }

  Future<void> onOccupationDropdownTapped(BuildContext context) async {
    final selected = await AppPicker.showOptionPicker(
      context,
      title: "Select Occupation",
      options: occupationSuggestions,
    );
    if (selected != null) {
      occupationController.text = selected;
      occupationError.value = null;
      BartaLog.debug(
        "Selected occupation: $selected",
        tag: "onOccupationDropdownTapped",
      );
    }
  }

  void onContinuePressed() {
    final monthStr = monthController.text.trim();
    final dayStr = dayController.text.trim();
    final yearStr = yearController.text.trim();
    final job = occupationController.text.trim();

    bool hasError = false;

    // Validate Birthday
    int? month = int.tryParse(monthStr);
    int? day = int.tryParse(dayStr);
    int? year = int.tryParse(yearStr);

    int calculatedAge = 0;

    if (month == null ||
        month < 1 ||
        month > 12 ||
        day == null ||
        day < 1 ||
        day > 31 ||
        year == null ||
        year < 1900 ||
        year > DateTime.now().year) {
      birthdayError.value = 'Please enter a valid birth date (MM/DD/YYYY)';
      hasError = true;
    } else {
      try {
        final birthDate = DateTime(year, month, day);
        final now = DateTime.now();
        calculatedAge = now.year - birthDate.year;
        if (now.month < birthDate.month ||
            (now.month == birthDate.month && now.day < birthDate.day)) {
          calculatedAge--;
        }

        if (calculatedAge < 18) {
          birthdayError.value = 'You must be at least 18 years old';
          hasError = true;
        } else {
          birthdayError.value = null;
        }
      } catch (e) {
        birthdayError.value = 'Invalid date format';
        hasError = true;
      }
    }

    // Validate Occupation
    if (job.isEmpty) {
      occupationError.value = 'Please select or enter your occupation';
      hasError = true;
    } else {
      occupationError.value = null;
    }

    if (hasError) {
      AppLogger.warning('Please complete all valid required fields');
      return;
    }

    commonController.setBirthdayAndOccupation(
      month: monthStr,
      day: dayStr,
      year: yearStr,
      age: calculatedAge,
      job: job,
    );

    Get.toNamed(AppRoutes.didSmoke);
  }
}
