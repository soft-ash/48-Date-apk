import 'package:flutter/material.dart';
import '../constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final List<Color>? gradientColors;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.gradientColors,
    this.backgroundColor,
    this.textColor,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Determine State
    final bool isDisabled = onPressed == null;

    // 2. Set Default Colors (Now properly using AppColor!)
    final Color defaultColor = backgroundColor ?? AppColor.primary500;

    // Determine the color of the text and icon based on the button style
    final Color contentColor =
        textColor ?? (isOutlined ? defaultColor : Colors.white);

    // 3. Build Box Decoration
    BoxDecoration decoration;
    if (isOutlined) {
      decoration = BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isDisabled
              ? AppColor.gray400
              : defaultColor, // Using AppColor for disabled state too
          width: 1.5,
        ),
      );
    } else if (gradientColors != null) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          colors: isDisabled
              ? [AppColor.primary500, AppColor.primary400]
              : gradientColors!,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          if (!isDisabled)
            BoxShadow(
              color: gradientColors!.first.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: isDisabled ? AppColor.gray300 : defaultColor,
        borderRadius: BorderRadius.circular(100),
      );
    }

    // 4. Build the Widget
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: decoration,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isDisabled && !isOutlined
                        ? AppColor.gray500
                        : contentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (suffixIcon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    suffixIcon,
                    color: isDisabled && !isOutlined
                        ? AppColor.gray500
                        : contentColor,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
