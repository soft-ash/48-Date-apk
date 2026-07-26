import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/bottom_navbar_controller.dart';
import 'bottom_nav_item.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavbarController>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray950.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItem(
                icon: AppIcons.discover,
                label: 'Discover',
                index: 0,
                currentIndex: controller.currentIndex,
                onTap: controller.changeTabIndex,
              ),
              BottomNavItem(
                icon: AppIcons.matches,
                label: 'Matches',
                index: 1,
                currentIndex: controller.currentIndex,
                onTap: controller.changeTabIndex,
              ),
              BottomNavItem(
                icon: AppIcons.chats,
                label: 'Chats',
                index: 2,
                currentIndex: controller.currentIndex,
                onTap: controller.changeTabIndex,
              ),
              BottomNavItem(
                icon: AppIcons.stories,
                label: 'Stories',
                index: 3,
                currentIndex: controller.currentIndex,
                onTap: controller.changeTabIndex,
              ),
              BottomNavItem(
                icon: AppIcons.you,
                label: 'You',
                index: 4,
                currentIndex: controller.currentIndex,
                onTap: controller.changeTabIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
