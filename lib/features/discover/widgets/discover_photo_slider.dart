import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'discover_full_image_view.dart';

class DiscoverPhotoSlider extends StatelessWidget {
  final List<String> postImages;

  const DiscoverPhotoSlider({super.key, required this.postImages});

  @override
  Widget build(BuildContext context) {
    if (postImages.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (int i = 0; i < postImages.length; i++) ...[
          GestureDetector(
            onTap: () =>
                DiscoverFullImageView.show(postImages, initialIndex: i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: CachedNetworkImage(
                  imageUrl: postImages[i],
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
                      Icons.image,
                      color: AppColor.gray400,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (i < postImages.length - 1) SizedBox(height: 16.h),
        ],
      ],
    );
  }
}
