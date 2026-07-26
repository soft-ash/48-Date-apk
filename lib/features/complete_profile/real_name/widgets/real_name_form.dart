import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../../core/widgets/custom_input_field.dart';
import '../controllers/real_name_controller.dart';

class RealNameForm extends StatelessWidget {
  const RealNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RealNameController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => CommonInputField(
            label: 'First name (Private)',
            hintText: 'e.g. John',
            controller: controller.firstNameController,
            errorText: controller.firstNameError.value,
          ),
        ),
        SizedBox(height: 16.h),
        Obx(
          () => CommonInputField(
            label: 'Last name (Private)',
            hintText: 'e.g. Doe',
            controller: controller.lastNameController,
            errorText: controller.lastNameError.value,
          ),
        ),
      ],
    );
  }
}
