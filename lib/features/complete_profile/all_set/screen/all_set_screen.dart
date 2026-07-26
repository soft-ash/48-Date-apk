import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/images.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import 'package:donnymaestro/core/widgets/custom_header.dart';
import '../controllers/all_set_controller.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.find<AllSetController>();

    return BaseScreen(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: Center(
                child: Image.asset(
                  AppImages.set,
                  width: 340.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            FadeInUp(
              delay: const Duration(milliseconds: 150),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    CustomHeader(
                      title: "You're all set!",
                      subtitle:
                          'Your profile is live and verified. Time to find someone worth 48 hours.',
                      titleStyle: AppTextStyle.h5(
                        weight: AppTextStyle.bold,
                      ).copyWith(color: AppColor.gray900),
                      textAlign: TextAlign.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomButton(
                  text: 'Start Discovering',
                  onPressed: controller.startDiscovering,
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
