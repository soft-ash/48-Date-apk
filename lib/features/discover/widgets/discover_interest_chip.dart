import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../model/interest_model.dart';

class DiscoverInterestChip extends StatelessWidget {
  final InterestModel interest;

  const DiscoverInterestChip({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.gray50,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.gray200.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (interest.icon != null && interest.icon!.isNotEmpty) ...[
            Text(interest.icon!, style: TextStyle(fontSize: 14.sp)),
            SizedBox(width: 6.w),
          ],
          Text(
            interest.name,
            style: AppTextStyle.bodySmall(
              weight: AppTextStyle.medium,
            ).copyWith(color: AppColor.gray800),
          ),
        ],
      ),
    );
  }
}
