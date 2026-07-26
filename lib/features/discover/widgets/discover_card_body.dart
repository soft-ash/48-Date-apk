import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../model/discover_user_model.dart';
import 'discover_hero_header.dart';
import 'discover_indicator.dart';
import 'discover_interest_chip.dart';
import 'discover_photo_slider.dart';

class DiscoverCardBody extends StatelessWidget {
  final DiscoverUserModel user;

  const DiscoverCardBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DiscoverHeroHeader(user: user),
          SizedBox(height: 20.h),
          DiscoverIndicator(
            trustScore: user.trustScore,
            label: user.trustShieldLabel,
          ),
          SizedBox(height: 20.h),
          if (user.bio.isNotEmpty)
            _buildSectionCard('My Bio', Text(user.bio, style: _bodyStyle())),
          _buildSectionCard('About Me', _buildAboutMeGrid()),
          if (user.interests.isNotEmpty)
            _buildSectionCard(
              'My Interest',
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: user.interests
                    .map((e) => DiscoverInterestChip(interest: e))
                    .toList(),
              ),
            ),
          if (user.lookingFor.isNotEmpty)
            _buildSectionCard(
              "I'm Looking For",
              Text(user.lookingFor, style: _bodyStyle()),
            ),
          if (user.occupation.isNotEmpty)
            _buildSectionCard(
              'My Occupation',
              Text(user.occupation, style: _bodyStyle()),
            ),
          if (user.education.isNotEmpty)
            _buildSectionCard(
              'My Education',
              Text(user.education, style: _bodyStyle()),
            ),
          if (user.languages.isNotEmpty)
            _buildSectionCard(
              'Languages',
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: user.languages
                    .map((e) => _buildSimpleChip(e))
                    .toList(),
              ),
            ),
          if (user.location.isNotEmpty)
            _buildSectionCard(
              'Location',
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColor.primaryColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(user.location, style: _bodyStyle()),
                ],
              ),
            ),
          SizedBox(height: 8.h),
          DiscoverPhotoSlider(postImages: user.postImages),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.gray200.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.h6(
              weight: AppTextStyle.bold,
            ).copyWith(color: AppColor.gray900),
          ),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }

  Widget _buildAboutMeGrid() {
    final List<Map<String, String>> items = [
      if (user.height.isNotEmpty) {'icon': '📏', 'text': user.height},
      if (user.weight.isNotEmpty) {'icon': '⚖️', 'text': user.weight},
      if (user.smoking.isNotEmpty) {'icon': '🚬', 'text': user.smoking},
      if (user.drinking.isNotEmpty) {'icon': '🍸', 'text': user.drinking},
      if (user.identify.isNotEmpty) {'icon': '👤', 'text': user.identify},
      if (user.haveKids.isNotEmpty) {'icon': '👶', 'text': user.haveKids},
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items
          .map((item) => _buildIconTextChip(item['icon']!, item['text']!))
          .toList(),
    );
  }

  Widget _buildIconTextChip(String icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.gray50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.gray200.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 14.sp)),
          SizedBox(width: 6.w),
          Text(
            text,
            style: AppTextStyle.bodySmall(
              weight: AppTextStyle.medium,
            ).copyWith(color: AppColor.gray800),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.gray50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.gray200.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyle.bodySmall(
          weight: AppTextStyle.medium,
        ).copyWith(color: AppColor.gray800),
      ),
    );
  }

  TextStyle _bodyStyle() {
    return AppTextStyle.bodyMedium(
      weight: AppTextStyle.regular,
    ).copyWith(color: AppColor.gray700, height: 1.4);
  }
}
