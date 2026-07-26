import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../../core/widgets/custom_input_field.dart';
import '../controllers/nickname_controller.dart';

class NicknameForm extends StatelessWidget {
  const NicknameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NicknameController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => CommonInputField(
            label: 'Public nickname',
            hintText: 'e.g. GoldenHour',
            controller: controller.nicknameController,
            errorText: controller.errorText.value,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'You can change this once every 30 days.',
          style: AppTextStyle.bodyExtraSmall(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray600),
        ),
      ],
    );
  }
}
