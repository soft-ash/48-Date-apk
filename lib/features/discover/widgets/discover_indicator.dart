import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';

class DiscoverIndicator extends StatelessWidget {
  final double trustScore;
  final String label;

  const DiscoverIndicator({
    super.key,
    required this.trustScore,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.whiteColor,
          border: Border.all(
            color: AppColor.primaryColor.withValues(alpha: 0.3),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: 0.1),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield, color: AppColor.primaryColor, size: 24.sp),
            SizedBox(height: 2.h),
            Text(
              trustScore.toStringAsFixed(1),
              style: AppTextStyle.h6(
                weight: AppTextStyle.bold,
              ).copyWith(color: AppColor.gray900),
            ),
            Text(
              label,
              style: AppTextStyle.caption(
                weight: AppTextStyle.medium,
              ).copyWith(color: AppColor.gray500, fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}
