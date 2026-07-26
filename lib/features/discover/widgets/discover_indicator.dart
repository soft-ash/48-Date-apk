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
    final double progress = (trustScore / 5.0).clamp(0.0, 1.0);

    return Center(
      child: SizedBox(
        width: 110.w,
        height: 110.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 5.w,
                strokeCap: StrokeCap.round,
                backgroundColor: AppColor.primaryColor.withValues(alpha: 0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColor.primaryColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_border_rounded,
                  color: AppColor.primaryColor,
                  size: 24.sp,
                ),
                SizedBox(height: 2.h),
                Text(
                  trustScore.toStringAsFixed(1),
                  style: AppTextStyle.h6(
                    weight: AppTextStyle.bold,
                  ).copyWith(color: AppColor.primaryColor),
                ),
                Text(
                  'Trust Score',
                  style: AppTextStyle.caption(
                    weight: AppTextStyle.medium,
                  ).copyWith(color: AppColor.gray600, fontSize: 11.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
