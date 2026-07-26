import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';

class DiscoverFullImageView extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const DiscoverFullImageView({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  static void show(List<String> images, {int initialIndex = 0}) {
    if (images.isEmpty) return;
    Get.to(
      () => DiscoverFullImageView(images: images, initialIndex: initialIndex),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = initialIndex.obs;
    final PageController pageController = PageController(
      initialPage: initialIndex,
    );

    return BaseScreen(
      useSafeArea: false,
      body: Stack(
        children: [
          // Photo Viewer with Zoom & Pan
          PageView.builder(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.0,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.whiteColor,
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          color: AppColor.gray500,
                          size: 50,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Failed to load image',
                          style: TextStyle(color: AppColor.gray500),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Top Navigation Bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Close Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: AppColor.blackColor.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.whiteColor.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        color: AppColor.whiteColor,
                        size: 22.sp,
                      ),
                    ),
                  ),

                  // Image Counter Badge
                  if (images.length > 1)
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.blackColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColor.whiteColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${currentIndex.value + 1} / ${images.length}',
                          style: AppTextStyle.bodySmall(
                            weight: AppTextStyle.semiBold,
                          ).copyWith(color: AppColor.whiteColor),
                        ),
                      ),
                    ),

                  // Spacer to balance layout
                  SizedBox(width: 44.w),
                ],
              ),
            ),
          ),

          // Bottom Dot Indicators for multiple images
          if (images.length > 1)
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    final bool isSelected = currentIndex.value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: isSelected ? 24.w : 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.whiteColor
                            : AppColor.whiteColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
