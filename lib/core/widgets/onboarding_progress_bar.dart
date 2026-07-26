import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../utils/screen_utils.dart';

class OnboardingProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const OnboardingProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          height: 6.h,
          decoration: BoxDecoration(
            color: AppColor.gray200,
            borderRadius: BorderRadius.circular(100.r),
          ),
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progress.clamp(0.0, 1.0)),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, _) {
              return Container(
                width: constraints.maxWidth * value,
                height: 6.h,
                decoration: BoxDecoration(
                  color: AppColor.primary500,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
