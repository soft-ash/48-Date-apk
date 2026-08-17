import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../font/style/text_style.dart';
import '../utils/screen_utils.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? gap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextAlign? textAlign;
  final CrossAxisAlignment? crossAxisAlignment;

  const CustomHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.gap,
    this.titleStyle,
    this.subtitleStyle,
    this.textAlign,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final hasSubtitle = subtitle != null && subtitle!.isNotEmpty;
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              AppTextStyle.h5(
                weight: AppTextStyle.bold,
              ).copyWith(color: AppColor.gray900),
          textAlign: textAlign,
        ),
        if (hasSubtitle) ...[
          SizedBox(height: gap ?? 12.h),
          Text(
            subtitle!,
            style:
                subtitleStyle ??
                AppTextStyle.bodySmall(
                  weight: AppTextStyle.regular,
                ).copyWith(color: AppColor.gray700, height: 1.5),
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}
