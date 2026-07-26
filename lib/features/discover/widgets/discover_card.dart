import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
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
    final Widget cardContent = Container(
      decoration: BoxDecoration(
        color: AppColor.gray50,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          DiscoverCardBody(user: user),
          if (isTopCard) _buildSwipeOverlays(),
        ],
      ),
    );

    if (!isTopCard) {
      return cardContent;
    }

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
          duration:
              dragging ? Duration.zero : const Duration(milliseconds: 320),
          curve: Curves.easeOutBack,
          transform:
              Matrix4.translationValues(dx, dy, 0)
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
      final double opacity = (dx.abs() / 120.0).clamp(0.0, 1.0);

      return Positioned(
        top: 40.h,
        left: isLike ? 24.w : null,
        right: isLike ? null : 24.w,
        child: Transform.rotate(
          angle: isLike ? -0.25 : 0.25,
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color:
                    isLike
                        ? Colors.green.shade600.withValues(alpha: 0.9)
                        : Colors.red.shade600.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.whiteColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isLike ? Icons.favorite : Icons.close,
                    color: AppColor.whiteColor,
                    size: 28.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    isLike ? 'LIKE' : 'NOPE',
                    style: AppTextStyle.h4(
                      weight: AppTextStyle.bold,
                    ).copyWith(color: AppColor.whiteColor, letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
