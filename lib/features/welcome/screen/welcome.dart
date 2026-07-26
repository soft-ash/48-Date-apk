import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/images.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import 'package:donnymaestro/features/welcome/controller/welcome_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.put(WelcomeController());

    return BaseScreen(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(
          () => AnimatedOpacity(
            opacity: controller.isLoginMode.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColor.gray700,
              ),
              onPressed: () {
                if (controller.isLoginMode.value) {
                  controller.showSplashMode();
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(16.w, 5.h, 16.w, 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: Text(
                "Match in a Moment,",
                style: AppTextStyle.h5(
                  weight: .bold,
                ).copyWith(color: AppColor.gray900),
              ),
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                "Meet in 48.",
                style: AppTextStyle.h5(
                  weight: .bold,
                ).copyWith(color: AppColor.primary500),
              ),
            ),
            SizedBox(height: 10.h),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Center(
                child: Text(
                  "Meet like-minded people and find your perfect match.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyMedium().copyWith(
                    color: AppColor.gray700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Image.asset(
                  AppImages.welcomeImage,
                  width: 380.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: controller.isLoginMode.value
                    ? Column(
                        key: const ValueKey('login'),
                        children: [
                          FadeInUp(
                            delay: const Duration(milliseconds: 100),
                            child: CustomButton(
                              text: 'Use mobile number',
                              textColor: AppColor.gray25,
                              prefixIcon: Icon(
                                Icons.phone,
                                color: AppColor.gray25,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                Get.toNamed(AppRoutes.phone);
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: CustomButton.outlined(
                              text: 'Sign in with Google',
                              textColor: AppColor.gray900,
                              prefixIcon: Image.asset(
                                AppIcons.google,
                                height: 24.h,
                              ),
                              border: Border.fromBorderSide(
                                BorderSide(color: AppColor.gray300, width: 1.5),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    : Column(
                        key: const ValueKey('splash'),
                        children: [
                          FadeInUp(
                            delay: const Duration(milliseconds: 500),
                            child: CustomButton(
                              text: 'Create Account',
                              textColor: AppColor.gray25,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 10.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 600),
                            child: CustomButton.outlined(
                              text: 'I have an account',
                              textColor: AppColor.primary500,
                              onPressed: controller.showLoginMode,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
