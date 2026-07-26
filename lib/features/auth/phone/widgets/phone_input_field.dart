import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/custom_input_field.dart';
import '../controller/phone_controller.dart';
import 'country_code_selector.dart';

class PhoneInputField extends GetView<PhoneController> {
  const PhoneInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonInputField(
      label: 'Phone Number',
      hintText: 'Enter your phone number',
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 16.0, right: 8.0),
        child: CountryCodeSelector(),
      ),
    );
  }
}
