import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../controller/phone_controller.dart';

class PhoneInputField extends GetView<PhoneController> {
  const PhoneInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonInputField(
      label: 'Phone Number',
      hintText: 'Enter your phone number',
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              countryListTheme: CountryListThemeData(
                bottomSheetHeight: 500.h,
                backgroundColor: AppColor.primary50,
                textStyle: AppTextStyle.bodyMedium(weight: AppTextStyle.medium),
                searchTextStyle: AppTextStyle.bodyMedium(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                inputDecoration: InputDecoration(
                  hintText: 'Search country or code',
                  hintStyle: AppTextStyle.bodySmall().copyWith(
                    color: AppColor.gray400,
                  ),
                  prefixIcon: const Icon(Icons.search, color: AppColor.gray400),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColor.gray300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: AppColor.primary600,
                      width: 1,
                    ),
                  ),
                ),
              ),
              onSelect: (Country country) {
                controller.updateCountry(
                  '+${country.phoneCode}',
                  country.flagEmoji,
                );
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Text(
                  controller.countryFlag.value,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 8.w),
              Obx(
                () => Text(
                  controller.countryCode.value,
                  style: AppTextStyle.bodyMedium(weight: AppTextStyle.medium),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.gray600,
                size: 20,
              ),
              SizedBox(width: 8.w),
              Container(height: 24.h, width: 1, color: AppColor.gray300),
            ],
          ),
        ),
      ),
    );
  }
}
