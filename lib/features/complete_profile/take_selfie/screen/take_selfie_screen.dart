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
import 'package:donnymaestro/core/widgets/custom_header.dart';
import '../controllers/take_selfie_controller.dart';

class TakeSelfieScreen extends StatelessWidget {
  const TakeSelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.find<TakeSelfieController>();

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
              child: const OnboardingProgressBar(progress: 0.97),
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
                                const CustomHeader(
                                  title: 'Selfie verification',
                                  subtitle:
                                      'A quick scan confirms you\'re real. Verified profiles get a badge and higher Trust Score.',
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 150),
                            child: Center(
                              child: Container(
                                width: 260.w,
                                height: 260.w,
                                decoration: BoxDecoration(
                                  color: AppColor.primary500.withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppIcons.selfiVerify,
                                    width: 130.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: Column(
                              children: [
                                Center(
                                  child: TextButton(
                                    onPressed: controller.skipSelfie,
                                    child: Text(
                                      'Skip for now',
                                      style: AppTextStyle.bodyMedium(
                                        weight: AppTextStyle.medium,
                                      ).copyWith(color: AppColor.primary500),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomButton(
                                  text: 'Verify ->',
                                  onPressed: controller.openPoseCamera,
                                ),
                              ],
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
