import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import '../models/match_model.dart';
import 'match_action_buttons.dart';
import 'match_badge.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;
  final int index;

  const MatchCard({super.key, required this.match, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final isExpiringSoon = match.status == MatchStatus.expiringSoon;

    return FadeInUp(
      delay: Duration(milliseconds: 60 * (index % 6)),
      duration: const Duration(milliseconds: 450),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: isExpiringSoon
              ? Border.all(color: AppColor.primary500, width: 1.5)
              : Border.all(color: AppColor.gray200, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.gray950.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // --- Top Content Section ---
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar with Online Badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl: match.profileImage,
                          width: 64.w,
                          height: 64.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColor.gray100,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColor.gray200,
                            child: Icon(
                              Icons.person,
                              color: AppColor.gray500,
                              size: 32.sp,
                            ),
                          ),
                        ),
                      ),
                      if (match.isOnline)
                        Positioned(
                          bottom: 4.w,
                          right: 4.w,
                          child: Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              color: AppColor.success500,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 14.w),

                  // Name, Age, Message, Warning
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${match.name}, ${match.age}",
                                style: AppTextStyle.bodyLarge(
                                  weight: AppTextStyle.bold,
                                ).copyWith(color: AppColor.gray900),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            MatchBadge(
                              status: match.status,
                              text: match.remainingTimeText,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          match.lastMessage,
                          style: AppTextStyle.bodySmall(
                            weight: AppTextStyle.regular,
                          ).copyWith(color: AppColor.gray600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (match.warningText != null) ...[
                          SizedBox(height: 6.h),
                          Text(
                            match.warningText!,
                            style: AppTextStyle.caption(
                              weight: AppTextStyle.semiBold,
                            ).copyWith(color: AppColor.primary500),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- Divider ---
            Divider(color: AppColor.gray200, height: 1),

            // --- Action Buttons ---
            MatchActionButtons(match: match),
          ],
        ),
      ),
    );
  }
}
