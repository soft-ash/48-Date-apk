import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/constant/icons.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../model/discover_user_model.dart';
import 'discover_full_image_view.dart';

class DiscoverHeroHeader extends StatelessWidget {
  final DiscoverUserModel user;

  const DiscoverHeroHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final List<String> allImages = [
          user.profileImage,
          ...user.postImages,
        ];
        DiscoverFullImageView.show(allImages, initialIndex: 0);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            AspectRatio(
            aspectRatio: 3 / 4,
            child: CachedNetworkImage(
              imageUrl: user.profileImage,
              fit: BoxFit.cover,
              memCacheWidth: 800,
              placeholder: (context, url) => Container(
                color: AppColor.gray100,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColor.gray100,
                child: const Icon(
                  Icons.person,
                  color: AppColor.gray400,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.5, 0.75, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${user.name}, ${user.age}',
                        style: AppTextStyle.h4(
                          weight: AppTextStyle.bold,
                        ).copyWith(color: AppColor.whiteColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (user.isVerified) ...[
                      SizedBox(width: 6.w),
                      Image.asset(AppIcons.badge, width: 20.sp, height: 20.sp),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Image.asset(
                      AppIcons.location,
                      color: AppColor.whiteColor.withValues(alpha: 0.8),
                      width: 14.sp,
                      height: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      user.distanceText,
                      style: AppTextStyle.bodySmall(weight: AppTextStyle.medium)
                          .copyWith(
                            color: AppColor.whiteColor.withValues(alpha: 0.9),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: [
                    for (final tag in user.personalityTags) _buildTagChip(tag),
                    _buildTrustBadge(user.trustScore),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildTagChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: AppTextStyle.caption(
          weight: AppTextStyle.medium,
        ).copyWith(color: AppColor.whiteColor),
      ),
    );
  }

  Widget _buildTrustBadge(double score) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.shade600.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppIcons.badge,
            color: AppColor.whiteColor,
            width: 12.sp,
            height: 12.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            '$score Trust Score',
            style: AppTextStyle.caption(
              weight: AppTextStyle.bold,
            ).copyWith(color: AppColor.whiteColor),
          ),
        ],
      ),
    );
  }
}
