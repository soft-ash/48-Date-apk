import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controller/discover_controller.dart';
import '../widgets/discover_bottom_buttons.dart';
import '../widgets/discover_card.dart';
import '../widgets/discover_loading_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscoverController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildCardStack(controller)),
            DiscoverBottomButtons(controller: controller),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '48',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColor.primaryColor,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildHeaderIcon(Icons.notifications_none),
              SizedBox(width: 12.w),
              _buildHeaderIcon(Icons.tune),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: AppColor.gray800, size: 20.sp),
    );
  }

  Widget _buildCardStack(DiscoverController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const DiscoverLoadingCard();
        }

        final int currentIndex = controller.currentIndex.value;
        final int totalUsers = controller.users.length;

        if (totalUsers == 0 || currentIndex >= totalUsers) {
          return DiscoverLoadingCard(
            isEmpty: true,
            onRefresh: () => controller.loadInitialUsers(),
          );
        }

        final int maxIndex = math.min(currentIndex + 2, totalUsers - 1);
        final List<Widget> cardWidgets = [];

        for (int i = maxIndex; i >= currentIndex; i--) {
          final user = controller.users[i];

          if (i == currentIndex) {
            cardWidgets.add(
              DiscoverCard(
                user: user,
                isTopCard: true,
                controller: controller,
              ),
            );
          } else if (i == currentIndex + 1) {
            cardWidgets.add(
              Obx(() {
                final double progress = (controller.dragX.value.abs() / 350.0)
                    .clamp(0.0, 1.0);
                final double scale = 0.96 + (0.04 * progress);
                final double offset = 14.0 - (14.0 * progress);

                return Transform.translate(
                  offset: Offset(0, offset),
                  child: Transform.scale(
                    scale: scale,
                    child: DiscoverCard(
                      user: user,
                      isTopCard: false,
                      controller: controller,
                    ),
                  ),
                );
              }),
            );
          } else if (i == currentIndex + 2) {
            cardWidgets.add(
              Obx(() {
                final double progress = (controller.dragX.value.abs() / 350.0)
                    .clamp(0.0, 1.0);
                final double scale = 0.92 + (0.04 * progress);
                final double offset = 28.0 - (14.0 * progress);

                return Transform.translate(
                  offset: Offset(0, offset),
                  child: Transform.scale(
                    scale: scale,
                    child: DiscoverCard(
                      user: user,
                      isTopCard: false,
                      controller: controller,
                    ),
                  ),
                );
              }),
            );
          }
        }

        return Stack(children: cardWidgets);
      }),
    );
  }
}
