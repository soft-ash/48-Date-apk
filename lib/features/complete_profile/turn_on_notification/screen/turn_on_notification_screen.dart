import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import 'package:donnymaestro/core/widgets/onboarding_progress_bar.dart';
import 'package:donnymaestro/core/widgets/custom_header.dart';
import '../controllers/turn_on_notification_controller.dart';

class TurnOnNotificationScreen extends StatelessWidget {
  const TurnOnNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.find<TurnOnNotificationController>();

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
              child: const OnboardingProgressBar(progress: 1.0),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 100),
                            child: Image.asset(
                              AppIcons.notification,
                              width: 130.w,
                              height: 130.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 150),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: CustomHeader(
                                    title: 'Turn On Notifications',
                                    subtitle:
                                        'Get alerts for new matches and most importantly when a 48-hour timer is running low.',
                                    textAlign: TextAlign.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 200),
                            child: CustomButton(
                              text: 'Enable Notifications',
                              onPressed: controller.enableNotifications,
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
