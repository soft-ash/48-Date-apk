import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/add_photo_controller.dart';

class PhotoGrid extends GetView<AddPhotoController> {
  const PhotoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Your Photos',
          style: AppTextStyle.h5(
            weight: AppTextStyle.bold,
          ).copyWith(color: AppColor.gray900),
        ),
        SizedBox(height: 12.h),
        Text(
          'Add at least 2. Clear, recent, and unmistakably you works best.',
          style: AppTextStyle.bodySmall(
            weight: AppTextStyle.regular,
          ).copyWith(color: AppColor.gray700, height: 1.5),
        ),
        SizedBox(height: 24.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Obx(() {
              final path = controller.photoSlots[index];
              final isFilled = path != null && path.isNotEmpty;

              if (isFilled) {
                return GestureDetector(
                  onTap: () => controller.pickPhoto(index),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColor.primary500, width: 2.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        path.startsWith('http')
                            ? Image.network(path, fit: BoxFit.cover)
                            : Image.file(File(path), fit: BoxFit.cover),
                        if (index == 0)
                          Positioned(
                            top: 8.h,
                            left: 8.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary500,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                'Main',
                                style: AppTextStyle.bodySmall(
                                  weight: AppTextStyle.bold,
                                ).copyWith(color: Colors.white, fontSize: 10.sp),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 6.h,
                          right: 6.w,
                          child: GestureDetector(
                            onTap: () => controller.removePhoto(index),
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 14.sp,
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
                child: Container(
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
            });
          },
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
}
