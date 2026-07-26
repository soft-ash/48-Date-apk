import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';

class DiscoverLoadingCard extends StatelessWidget {
  final bool isEmpty;
  final VoidCallback? onRefresh;

  const DiscoverLoadingCard({
    super.key,
    this.isEmpty = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isEmpty ? Icons.people_outline : Icons.travel_explore,
            size: 64.sp,
            color: AppColor.primaryColor,
          ),
          SizedBox(height: 16.h),
          Text(
            isEmpty ? 'No more profiles nearby' : 'Finding matches around you...',
            style: AppTextStyle.h5(weight: AppTextStyle.bold).copyWith(
              color: AppColor.gray900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            isEmpty
                ? 'Check back soon or expand your distance filter to see more people.'
                : 'Please wait while we prepare new profiles.',
            style: AppTextStyle.bodyMedium(weight: AppTextStyle.regular).copyWith(
              color: AppColor.gray500,
            ),
            textAlign: TextAlign.center,
          ),
          if (isEmpty && onRefresh != null) ...[
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: onRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text(
                'Refresh Profiles',
                style: AppTextStyle.bodyMedium(weight: AppTextStyle.bold).copyWith(
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
