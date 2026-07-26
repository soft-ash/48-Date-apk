import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../controllers/location_controller.dart';

class LocationActions extends StatelessWidget {
  const LocationActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationController>();

    return Column(
      children: [
        CustomButton(
          text: 'Set Location Services',
          onPressed: controller.onSetLocationServicesPressed,
        ),
        SizedBox(height: 12.h),
        CustomButton.outlined(
          text: 'Not Now',
          onPressed: controller.onNotNowPressed,
          border: const Border.fromBorderSide(
            BorderSide(color: AppColor.primary500, width: 1.5),
          ),
        ),
      ],
    );
  }
}
