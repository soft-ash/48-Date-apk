import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';

class MatchesEmptyView extends StatelessWidget {
  final VoidCallback onRefresh;

  const MatchesEmptyView({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColor.primary50,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 40.sp,
                  color: AppColor.primary500,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "No Matches Yet",
                style: AppTextStyle.h6(
                  weight: AppTextStyle.bold,
                ).copyWith(color: AppColor.gray900),
              ),
              SizedBox(height: 8.h),
              Text(
                "When you match with someone or complete dates, they will show up here.",
                style: AppTextStyle.bodySmall().copyWith(
                  color: AppColor.gray600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              CustomButton(
                text: "Refresh Matches",
                width: 200,
                height: 44,
                onPressed: onRefresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
