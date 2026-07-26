import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/images.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/take_selfie_controller.dart';
import '../widgets/pose_bottom_card.dart';
import '../widgets/scan_line_overlay.dart';

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
          Image.asset(AppImages.faceScanBg, fit: BoxFit.cover),
          const ScanLineOverlay(),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, top: 8.h),
                child: CircleAvatar(
                  backgroundColor: AppColor.gray950.withValues(alpha: 0.35),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PoseBottomCard(onContinue: controller.takePictureAndVerify),
          ),
        ],
      ),
    );
  }
}
