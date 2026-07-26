import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controller/discover_controller.dart';
import '../model/discover_user_model.dart';
import 'discover_card_body.dart';

class DiscoverCard extends StatelessWidget {
  final DiscoverUserModel user;
  final bool isTopCard;
  final DiscoverController controller;

  const DiscoverCard({
    super.key,
    required this.user,
    required this.isTopCard,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.gray25,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DiscoverCardBody(user: user),
            if (isTopCard) _buildSwipeOverlays(),
          ],
        ),
      ),
    );

    if (!isTopCard) return cardContent;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        controller.onDragUpdate(details.delta.dx, details.delta.dy);
      },
      onHorizontalDragEnd: (details) {
        controller.onDragEnd(details.velocity.pixelsPerSecond.dx);
      },
      child: Obx(() {
        final double dx = controller.dragX.value;
        final double dy = controller.dragY.value;
        final bool dragging = controller.isDragging.value;
        final double angle = dx / 1200.0;
        final double scale = 1.0 - (dx.abs() / 4000.0).clamp(0.0, 0.04);

        return AnimatedContainer(
          duration: dragging
              ? Duration.zero
              : const Duration(milliseconds: 320),
          curve: Curves.easeOutBack,
          transform: Matrix4.translationValues(dx, dy, 0)
            ..rotateZ(angle)
            ..multiply(Matrix4.diagonal3Values(scale, scale, 1.0)),
          alignment: Alignment.center,
          child: cardContent,
        );
      }),
    );
  }

  Widget _buildSwipeOverlays() {
    return Obx(() {
      final double dx = controller.dragX.value;
      if (dx.abs() < 15) return const SizedBox.shrink();

      final bool isLike = dx > 0;
      final double opacity = (dx.abs() / 100.0).clamp(0.0, 1.0);

      return Stack(
        fit: StackFit.expand,
        children: [
          // Tinted overlay
          AnimatedOpacity(
            duration: Duration.zero,
            opacity: opacity * 0.15,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: isLike ? AppColor.success500 : AppColor.error500,
              ),
            ),
          ),
          // Icon positioned at bottom corner
          Positioned(
            bottom: 80.h,
            left: isLike ? null : 24.w,
            right: isLike ? 24.w : null,
            child: Opacity(
              opacity: opacity,
              child: Image.asset(
                isLike ? AppIcons.mark : AppIcons.reject,
                width: 80.w,
                height: 80.w,
                color: isLike ? AppColor.success500 : AppColor.error500,
              ),
            ),
          ),
        ],
      );
    });
  }
}
