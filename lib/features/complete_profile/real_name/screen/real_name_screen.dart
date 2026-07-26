import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/utils/background.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/fade_in_up.dart';
import '../../../../../core/widgets/onboarding_progress_bar.dart';
import '../controllers/real_name_controller.dart';
import '../widgets/privacy_banner.dart';
import '../widgets/real_name_form.dart';
import '../widgets/real_name_header.dart';

class RealNameScreen extends StatelessWidget {
  const RealNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.put(RealNameController());

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
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: const OnboardingProgressBar(progress: 0.35),
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
                            child: const RealNameHeader(),
                          ),
                          SizedBox(height: 24.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: const RealNameForm(),
                          ),
                          SizedBox(height: 20.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 300),
                            child: const PrivacyBanner(),
                          ),
                          const Spacer(),
                          SizedBox(height: 24.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 400),
                            child: CustomButton(
                              text: 'Continue ->',
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
