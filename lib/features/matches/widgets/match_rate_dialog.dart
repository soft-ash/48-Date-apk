import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import '../models/match_model.dart';

class MatchRateDialog extends StatefulWidget {
  final MatchModel match;
  final Function(MatchModel match, int stars, String feedback) onSubmit;

  const MatchRateDialog({
    super.key,
    required this.match,
    required this.onSubmit,
  });

  @override
  State<MatchRateDialog> createState() => _MatchRateDialogState();
}

class _MatchRateDialogState extends State<MatchRateDialog> {
  int _selectedStars = 5;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.match.profileImage,
                width: 64.w,
                height: 64.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              "Rate Your Date",
              style: AppTextStyle.h6(
                weight: AppTextStyle.bold,
              ).copyWith(color: AppColor.gray900),
            ),
            SizedBox(height: 4.h),
            Text(
              "How was your time with ${widget.match.name}?",
              style: AppTextStyle.bodySmall().copyWith(color: AppColor.gray600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),

            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starNum = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStars = starNum;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Icon(
                      Icons.star_rounded,
                      size: 36.sp,
                      color: starNum <= _selectedStars
                          ? AppColor.warning500
                          : AppColor.gray300,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.h),

            // Feedback field
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Add optional feedback...",
                hintStyle: AppTextStyle.bodySmall().copyWith(
                  color: AppColor.gray400,
                ),
                filled: true,
                fillColor: AppColor.gray50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColor.gray200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColor.gray200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColor.primary500),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton.outlined(
                    text: "Cancel",
                    height: 44,
                    onPressed: () => Get.back(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    text: "Submit",
                    height: 44,
                    onPressed: () {
                      Get.back();
                      widget.onSubmit(
                        widget.match,
                        _selectedStars,
                        _feedbackController.text.trim(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
