import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../models/match_model.dart';

class MatchBadge extends StatelessWidget {
  final MatchStatus status;
  final String text;

  const MatchBadge({
    super.key,
    required this.status,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    IconData? icon;

    switch (status) {
      case MatchStatus.active:
        bgColor = AppColor.warning50;
        textColor = AppColor.warning600;
        icon = Icons.access_time_rounded;
        break;
      case MatchStatus.expiringSoon:
        bgColor = AppColor.primary500;
        textColor = Colors.white;
        icon = Icons.access_time_filled_rounded;
        break;
      case MatchStatus.dateSet:
        bgColor = AppColor.success50;
        textColor = AppColor.success700;
        icon = Icons.check_circle_outline_rounded;
        break;
      case MatchStatus.dateComplete:
        bgColor = AppColor.success50;
        textColor = AppColor.success700;
        icon = Icons.check_circle_rounded;
        break;
      case MatchStatus.cancelled:
        bgColor = AppColor.primary50;
        textColor = AppColor.primary500;
        icon = null;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13.sp,
              color: textColor,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: AppTextStyle.caption(weight: AppTextStyle.bold).copyWith(
              color: textColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
