import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import 'package:donnymaestro/core/widgets/custom_header.dart';

class PoseBottomCard extends StatelessWidget {
  final VoidCallback onContinue;
  const PoseBottomCard({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColor.primary50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray950.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(
              title: 'Pose',
              subtitle: 'Copy this pose as accurately as possible.',
            ),
            SizedBox(height: 24.h),
            CustomButton(text: 'Continue', onPressed: onContinue),
          ],
        ),
      ),
    );
  }
}
