import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../utils/screen_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.height = 52,
    this.radius = 100,
    this.padding,
    this.gradient,
    this.color,
    this.border,
    this.textColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.elevation = 0,
    this.textStyle,
  });

  const CustomButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.height = 52,
    this.radius = 100,
    this.padding,
    this.textColor = AppColor.primary500,
    this.prefixIcon,
    this.suffixIcon,
    this.elevation = 0,
    this.textStyle,
    this.border = const Border.fromBorderSide(
      BorderSide(color: AppColor.primary500, width: 1.5),
    ),
  }) : color = Colors.transparent,
       gradient = null;

  final String text;
  final VoidCallback? onPressed;

  final double width;
  final double height;
  final double radius;
  final double elevation;

  final EdgeInsetsGeometry? padding;

  /// Solid background color
  final Color? color;

  /// Gradient background
  final Gradient? gradient;

  /// Optional border
  final Border? border;

  final Color textColor;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextStyle? textStyle;

  bool get _isDisabled => onPressed == null;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius.r);

    return SizedBox(
      width: width == double.infinity ? double.infinity : width.w,
      height: height.h,
      child: Material(
        color: Colors.transparent,
        elevation: elevation,
        borderRadius: borderRadius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border,
            color: _isDisabled
                ? AppColor.gray300
                : gradient == null
                ? (color ?? AppColor.primary500)
                : null,
            gradient: _isDisabled
                ? null
                : (gradient ??
                      const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [AppColor.primary500, AppColor.primary200],
                      )),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius,
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: _isDisabled ? AppColor.gray500 : textColor,
                        size: 20.sp,
                      ),
                      child: prefixIcon!,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style:
                          (textStyle ??
                                  TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ))
                              .copyWith(
                                color: _isDisabled
                                    ? AppColor.gray500
                                    : textColor,
                              ),
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: 8.w),
                    IconTheme(
                      data: IconThemeData(
                        color: _isDisabled ? AppColor.gray500 : textColor,
                        size: 20.sp,
                      ),
                      child: suffixIcon!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

