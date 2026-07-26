import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controller/discover_controller.dart';
import '../widgets/discover_card.dart';
import '../widgets/discover_loading_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscoverController>();

    return BaseScreen(
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildCardStack(controller)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppIcons.logo, height: 32.h, fit: BoxFit.contain),
          Row(
            children: [
              _buildHeaderIcon(AppIcons.notify),
              SizedBox(width: 12.w),
              _buildHeaderIcon(AppIcons.filter),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(String iconAsset) {
    return Container(
      width: 44.w,
      height: 44.w,
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
      alignment: Alignment.center,
      child: Image.asset(
        iconAsset,
        width: 22.w,
        height: 22.w,
        color: AppColor.gray800,
      ),
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
            // TOP card — drags freely, no overlay
            cardWidgets.add(
              DiscoverCard(user: user, isTopCard: true, controller: controller),
            );
          } else if (i == currentIndex + 1) {
            // BACKGROUND card — icon only (no tint — the TOP card gets the tint)
            cardWidgets.add(
              Obx(() {
                final double dx = controller.dragX.value;
                final double progress = (dx.abs() / 350.0).clamp(0.0, 1.0);
                final double scale = 0.96 + (0.04 * progress);
                final double verticalOffset = 14.0 - (14.0 * progress);

                final bool isDragging = dx.abs() > 20;
                final bool isLike = dx > 0;
                // Smooth ease-in opacity
                final double iconOpacity = (dx.abs() / 90.0).clamp(0.0, 1.0);
                // Spring scale: pops from 0.4 to 1.0
                final double iconScale =
                    0.4 + (0.6 * ((dx.abs() / 90.0).clamp(0.0, 1.0)));

                return Transform.translate(
                  offset: Offset(0, verticalOffset),
                  child: Transform.scale(
                    scale: scale,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        DiscoverCard(
                          user: user,
                          isTopCard: false,
                          controller: controller,
                        ),
                        if (isDragging)
                          Positioned(
                            bottom: 56.h,
                            left: isLike ? 24.w : null,
                            right: isLike ? null : 24.w,
                            child: Opacity(
                              opacity: iconOpacity,
                              child: Transform.scale(
                                scale: iconScale,
                                child: Image.asset(
                                  isLike ? AppIcons.mark : AppIcons.reject,
                                  width: 72.w,
                                  height: 72.w,
                                  color: isLike
                                      ? AppColor.success500
                                      : AppColor.error500,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (i == currentIndex + 2) {
            // Third card — scales behind second
            cardWidgets.add(
              Obx(() {
                final double progress = (controller.dragX.value.abs() / 350.0)
                    .clamp(0.0, 1.0);
                final double scale = 0.92 + (0.04 * progress);
                final double verticalOffset = 28.0 - (14.0 * progress);

                return Transform.translate(
                  offset: Offset(0, verticalOffset),
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

        return Stack(fit: StackFit.expand, children: cardWidgets);
      }),
    );
  }
}
