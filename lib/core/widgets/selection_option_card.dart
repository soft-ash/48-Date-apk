import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../font/style/text_style.dart';
import '../utils/screen_utils.dart';

class SelectionOptionCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionOptionCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary50 : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColor.primary500 : AppColor.gray200,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.bodyMedium(
                  weight: isSelected ? AppTextStyle.medium : AppTextStyle.regular,
                ).copyWith(
                  color: isSelected ? AppColor.primary500 : AppColor.gray800,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColor.primary500,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
