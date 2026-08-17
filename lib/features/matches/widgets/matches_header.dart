import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import '../controllers/matches_controller.dart';

class MatchesHeader extends StatelessWidget {
  const MatchesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();

    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Matches",
              style: AppTextStyle.h4(
                weight: AppTextStyle.bold,
              ).copyWith(color: AppColor.gray900),
            ),
            SizedBox(height: 4.h),
            Obx(() {
              final int count = controller.activeCount;
              return RichText(
                text: TextSpan(
                  style: AppTextStyle.bodySmall(
                    weight: AppTextStyle.medium,
                  ).copyWith(color: AppColor.gray600),
                  children: [
                    TextSpan(
                      text: "$count",
                      style: AppTextStyle.bodySmall(
                        weight: AppTextStyle.bold,
                      ).copyWith(color: AppColor.primary500),
                    ),
                    const TextSpan(
                      text: " active · beat the clock and plan a real date.",
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
