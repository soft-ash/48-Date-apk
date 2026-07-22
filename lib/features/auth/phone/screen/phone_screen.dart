import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/font/style/text_style.dart';
import '../../../../core/utils/background.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/fade_in_up.dart';
import '../controller/phone_controller.dart';
import '../widgets/phone_input_field.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Screen Utils if not already
    AppScreenUtil.init(context);

    final PhoneController controller = Get.put(PhoneController());

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
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      child: Text(
                        'What\'s Your Number?',
                        style: AppTextStyle.h5(weight: AppTextStyle.bold),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        'We protect our community by making sure everyone on 48 Date is real.',
                        style: AppTextStyle.bodyMedium(
                          weight: AppTextStyle.regular,
                        ).copyWith(color: AppColor.gray600, height: 1.5),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: const PhoneInputField(),
                    ),
                    const Spacer(),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: CustomButton(
                        text: 'Continue',
                        onPressed: controller.onContinuePressed,
                        color: AppColor
                            .error500, // Or your specific pink/red primary color
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppIcons.lock,
                            width: 16.w,
                            height: 16.w,
                            color: AppColor.error500,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'We never share this with anyone and it won\'t be on your profile.',
                              style: AppTextStyle.bodySmall(
                                weight: AppTextStyle.regular,
                              ).copyWith(color: AppColor.gray600),
                            ),
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
    );
  }
}
