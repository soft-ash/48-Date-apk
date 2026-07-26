import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/weight_controller.dart';

class WeightWheel extends GetView<WeightController> {
  const WeightWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is Your Weight',
          style: AppTextStyle.h5(
            weight: AppTextStyle.bold,
          ).copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 12.h),
        Text(
          'This helps us personalize your experience and better match you.',
          style: AppTextStyle.bodySmall(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray700, height: 1.5),
        ),
        SizedBox(height: 40.h),
        Expanded(
          child: CupertinoPicker(
            scrollController: controller.scrollController,
            itemExtent: 60.h,
            diameterRatio: 1.5,
            selectionOverlay: Center(
              child: Container(
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.primary500, width: 2.0),
                    bottom: BorderSide(color: AppColor.primary500, width: 2.0),
                  ),
                ),
              ),
            ),
            onSelectedItemChanged: controller.onWeightChanged,
            children: controller.weightOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final text = entry.value;
              return Center(
                child: Obx(() {
                  final diff = (controller.selectedIndex.value - index).abs();
                  Color color;
                  double fontSize;
                  FontWeight weight;

                  if (diff == 0) {
                    color = AppColor.primary500;
                    fontSize = 22.sp;
                    weight = AppTextStyle.bold;
                  } else if (diff == 1) {
                    color = AppColor.gray600;
                    fontSize = 18.sp;
                    weight = AppTextStyle.medium;
                  } else if (diff == 2) {
                    color = AppColor.gray400;
                    fontSize = 16.sp;
                    weight = AppTextStyle.regular;
                  } else {
                    color = AppColor.gray300;
                    fontSize = 15.sp;
                    weight = AppTextStyle.regular;
                  }

                  return Text(
                    text,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontWeight: weight,
                      fontSize: fontSize,
                      color: color,
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
