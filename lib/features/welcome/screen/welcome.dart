import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/images.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(16.w, 40.h, 16.w, 10.h),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
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
            SizedBox(height: 20.h),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Image.asset(
                AppImages.welcomeImage,
                height: 420.h,
                width: 408.w,
              ),
            ),
            SizedBox(height: 14.h),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
