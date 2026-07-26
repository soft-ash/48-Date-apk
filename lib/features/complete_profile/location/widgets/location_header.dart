import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: AppColor.primary500, size: 48.sp),
        SizedBox(height: 20.h),
        Text(
          'Set Your Location',
          style: AppTextStyle.h5(weight: AppTextStyle.bold),
        ),
        SizedBox(height: 16.h),
        Text(
          'We use your location to show you potential matches near you.',
          style: AppTextStyle.bodyMedium(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray600, height: 1.5),
        ),
      ],
    );
  }
}
