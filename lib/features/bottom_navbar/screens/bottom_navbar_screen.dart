import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/features/discover/screen/discover_screen.dart';
import 'package:donnymaestro/features/matches/screens/matches_screen.dart';
import '../controllers/bottom_navbar_controller.dart';
import '../widgets/custom_bottom_navbar.dart';

class BottomNavbarScreen extends StatelessWidget {
  const BottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    final controller = Get.find<BottomNavbarController>();

    final List<Widget> screens = [
      const DiscoverScreen(),
      const MatchesScreen(),
      _buildPlaceholder('Chats', AppIcons.chats),
      _buildPlaceholder('Stories', AppIcons.stories),
      _buildPlaceholder('You', AppIcons.you),
    ];

    return BaseScreen(
      bottomNavigationBar: const CustomBottomNavbar(),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: screens,
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String title, String icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 64.w,
            height: 64.w,
            color: AppColor.primary500.withValues(alpha: 0.8),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: AppTextStyle.h4(
              weight: AppTextStyle.bold,
            ).copyWith(color: AppColor.gray900),
          ),
          SizedBox(height: 8.h),
          Text(
            'Screen content will be attached here.',
            style: AppTextStyle.bodySmall(
              weight: AppTextStyle.medium,
            ).copyWith(color: AppColor.gray500),
          ),
        ],
      ),
    );
  }
}
