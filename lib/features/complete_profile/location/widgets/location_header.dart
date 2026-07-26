import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/font/style/text_style.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../../core/widgets/custom_header.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: AppColor.primary500, size: 48.sp),
        SizedBox(height: 20.h),
        CustomHeader(
          title: 'Set Your Location',
          subtitle:
              'We use your location to show you potential matches near you.',
          gap: 16.h,
          subtitleStyle: AppTextStyle.bodyMedium(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray600, height: 1.5),
        ),
      ],
    );
  }
}
