import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_button.dart';
import '../controllers/matches_controller.dart';
import '../models/match_model.dart';

class MatchDetailBottomSheet extends StatelessWidget {
  final MatchModel match;
  final MatchesController controller;

  const MatchDetailBottomSheet({
    super.key,
    required this.match,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final details =
        match.dateDetails ??
        const DateDetailsModel(
          whereName: 'Amber & Oak Coffee',
          whenTime: 'Tomorrow 4:00 PM',
          gettingThere: '12 min • Directions available',
          matchPartnerHandle: 'GoldenHour',
          matchPartnerAvatar:
              'https://picsum.photos/seed/partner_amber/400/400',
        );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.gray50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Drag Handle ---
            Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColor.gray300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),

            // --- Double Overlapping Avatars (Frame 2147228356) ---
            SizedBox(
              height: 80.w,
              width: 136.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 8.w,
                    child: _buildAvatar(match.profileImage),
                  ),
                  Positioned(
                    left: 56.w,
                    child: _buildAvatar(details.matchPartnerAvatar),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),

            // --- Title ---
            Text(
              "Date with ${details.matchPartnerHandle}",
              style: AppTextStyle.h6(
                weight: AppTextStyle.bold,
              ).copyWith(color: AppColor.gray900),
            ),
            SizedBox(height: 20.h),

            // --- Details Card ---
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColor.gray200),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.gray950.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.location_on,
                    label: "WHERE",
                    value: details.whereName,
                  ),
                  _buildCardDivider(),
                  _buildDetailRow(
                    icon: Icons.calendar_month,
                    label: "WHEN",
                    value: details.whenTime,
                  ),
                  _buildCardDivider(),
                  _buildDetailRow(
                    icon: Icons.navigation,
                    label: "GETTING THERE",
                    value: details.gettingThere,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // --- Action Buttons ---
            CustomButton(
              text: "Get Directions",
              onPressed: () {
                Get.back();
                controller.openMessage(match);
              },
            ),
            SizedBox(height: 12.h),
            CustomButton.outlined(
              text: "Message Partner",
              onPressed: () {
                Get.back();
                controller.openMessage(match);
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.primary500, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray900.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(color: AppColor.gray200),
          errorWidget: (context, url, error) => Container(
            color: AppColor.gray200,
            child: Icon(Icons.person, color: AppColor.gray500, size: 36.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildCardDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Divider(color: AppColor.gray100, height: 1),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColor.primary50,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColor.primary500, size: 20.sp),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.caption(
                  weight: AppTextStyle.bold,
                ).copyWith(color: AppColor.gray500, letterSpacing: 0.5),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTextStyle.bodyMedium(
                  weight: AppTextStyle.bold,
                ).copyWith(color: AppColor.gray900),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
