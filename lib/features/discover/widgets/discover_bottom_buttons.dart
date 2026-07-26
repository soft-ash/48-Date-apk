import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controller/discover_controller.dart';

class DiscoverBottomButtons extends StatelessWidget {
  final DiscoverController controller;

  const DiscoverBottomButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            iconAsset: AppIcons.reject,
            iconColor: AppColor.gray800,
            bgColor: AppColor.whiteColor,
            size: 60.w,
            iconSize: 24.w,
            hasShadow: true,
            onTap: controller.onReject,
          ),
          _buildActionButton(
            iconAsset: AppIcons.mark,
            iconColor: AppColor.whiteColor,
            bgColor: AppColor.primaryColor,
            size: 68.w,
            iconSize: 28.w,
            hasShadow: true,
            onTap: controller.onLike,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String iconAsset,
    required Color iconColor,
    required Color bgColor,
    required double size,
    required double iconSize,
    required bool hasShadow,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          boxShadow:
              hasShadow
                  ? [
                    BoxShadow(
                      color: bgColor.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: AppColor.blackColor.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        alignment: Alignment.center,
        child: Image.asset(
          iconAsset,
          width: iconSize,
          height: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
