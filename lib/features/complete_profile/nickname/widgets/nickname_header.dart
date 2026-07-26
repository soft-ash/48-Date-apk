import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';

class NicknameHeader extends StatelessWidget {
  const NicknameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Nickname',
          style: AppTextStyle.h5(
            weight: AppTextStyle.bold,
          ).copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 12.h),
        Text(
          'This is the only name others will see. Make it mysterious, playful, memorable.',
          style: AppTextStyle.bodySmall(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray700, height: 1.5),
        ),
      ],
    );
  }
}
