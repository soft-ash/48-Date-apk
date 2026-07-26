import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import 'package:donnymaestro/core/widgets/onboarding_progress_bar.dart';
import '../controllers/complete_verification_controller.dart';

class CompleteVerificationScreen extends StatelessWidget {
  const CompleteVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.find<CompleteVerificationController>();

    return BaseScreen(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.gray700),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: const OnboardingProgressBar(progress: 0.98),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Complete Verification',
                                  style: AppTextStyle.h5(
                                    weight: AppTextStyle.bold,
                                  ).copyWith(color: AppColor.gray900),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'Verification successful. Enjoy the full experience.',
                                  style: AppTextStyle.bodySmall(
                                    weight: AppTextStyle.regular,
                                  ).copyWith(color: AppColor.gray700, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 150),
                            child: Center(
                              child: Image.asset(
                                AppIcons.complete,
                                width: 200.w,
                                height: 200.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: CustomButton(
                              text: 'Continue',
                              onPressed: controller.onContinuePressed,
                            ),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
