import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';

class RealNameHeader extends StatelessWidget {
  const RealNameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Real Name',
          style: AppTextStyle.h5(
            weight: AppTextStyle.bold,
          ).copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 12.h),
        Text(
          'Kept 100% private. Used only for verification and your safety never shown to other users.',
          style: AppTextStyle.bodySmall(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray700, height: 1.5),
        ),
      ],
    );
  }
}
