import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final RxInt currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Obx(() {
          final bool isSelected = currentIndex.value == index;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(
                    begin: AppColor.gray800,
                    end: isSelected ? AppColor.primary500 : AppColor.gray800,
                  ),
                  duration: const Duration(milliseconds: 250),
                  builder: (context, color, child) {
                    return Image.asset(
                      icon,
                      width: 24.w,
                      height: 24.w,
                      color: color,
                    );
                  },
                ),
              ),
              SizedBox(height: 4.h),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                style:
                    AppTextStyle.bodySmall(
                      weight: isSelected
                          ? AppTextStyle.semiBold
                          : AppTextStyle.medium,
                    ).copyWith(
                      color: isSelected
                          ? AppColor.primary500
                          : AppColor.gray800,
                    ),
                child: Text(label),
              ),
            ],
          );
        }),
      ),
    );
  }
}
