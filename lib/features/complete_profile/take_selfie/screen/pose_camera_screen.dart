import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/images.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import '../controllers/take_selfie_controller.dart';

class PoseCameraScreen extends StatelessWidget {
  const PoseCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.find<TakeSelfieController>();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background reference pose image or camera feed placeholder
          Image.asset(
            AppImages.set,
            fit: BoxFit.cover,
          ),
          // Top AppBar with Back Button
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w, top: 8.h),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ),
          ),
          // Bottom Pose Instruction Card
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: FadeInUp(
                delay: const Duration(milliseconds: 150),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDECEF), // Light pink/cream background from mockup
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pose',
                        style: AppTextStyle.h4(
                          weight: AppTextStyle.bold,
                        ).copyWith(color: AppColor.gray900),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Copy this pose as accurately as possible.',
                        style: AppTextStyle.bodySmall(
                          weight: AppTextStyle.regular,
                        ).copyWith(color: AppColor.gray700, height: 1.4),
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: 'Continue',
                        onPressed: controller.takePictureAndVerify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
