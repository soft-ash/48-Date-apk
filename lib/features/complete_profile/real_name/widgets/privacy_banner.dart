import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../core/constant/icons.dart';

class PrivacyBanner extends StatelessWidget {
  const PrivacyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppIcons.lock, color: AppColor.primary500, width: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'Your real name is encrypted and hidden. Others only ever see your nickname.',
            style: AppTextStyle.bodyExtraSmall(
              weight: AppTextStyle.regular,
            ).copyWith(color: AppColor.gray700, height: 1.4),
          ),
        ),
      ],
    );
  }
}
