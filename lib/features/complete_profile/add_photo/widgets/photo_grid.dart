import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/custom_header.dart';
import '../controllers/add_photo_controller.dart';

class PhotoGrid extends GetView<AddPhotoController> {
  const PhotoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(
          title: 'Add Your Photos',
          subtitle:
              'Add at least 2. Clear, recent, and unmistakably you works best.',
        ),
        SizedBox(height: 24.h),
        Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildPhotoSlot(0)),
                SizedBox(width: 12.w),
                Expanded(child: _buildPhotoSlot(1)),
                SizedBox(width: 12.w),
                Expanded(child: _buildPhotoSlot(2)),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: _buildPhotoSlot(3)),
                SizedBox(width: 12.w),
                Expanded(child: _buildPhotoSlot(4)),
                SizedBox(width: 12.w),
                Expanded(child: _buildPhotoSlot(5)),
              ],
            ),
          ],
        ),
        Obx(() {
          if (controller.errorText.value != null) {
            return Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                controller.errorText.value!,
                style: AppTextStyle.bodySmall().copyWith(
                  color: AppColor.error500,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildPhotoSlot(int index) {
    return AspectRatio(
      aspectRatio: 0.72,
      child: Obx(() {
        final path = controller.photoSlots[index];
        final isFilled = path != null && path.isNotEmpty;

        if (isFilled) {
          return GestureDetector(
            onTap: () => controller.pickPhoto(index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(File(path), fit: BoxFit.cover),
                  if (index == 0)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColor.primary500,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          child: Text(
                            'Main',
                            style: AppTextStyle.bodySmall(
                              weight: AppTextStyle.bold,
                            ).copyWith(color: Colors.white, fontSize: 10.sp),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: GestureDetector(
                      onTap: () => controller.removePhoto(index),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColor.primary500,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () => controller.pickPhoto(index),
          behavior: HitTestBehavior.opaque,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.gray50,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.gray200, width: 1.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: AppColor.gray700, size: 24.sp),
                SizedBox(height: 6.h),
                Text(
                  'Add',
                  style: AppTextStyle.bodySmall(
                    weight: AppTextStyle.medium,
                  ).copyWith(color: AppColor.gray700),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
