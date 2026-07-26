import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/utils/background.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/fade_in_up.dart';
import '../controllers/location_controller.dart';
import '../widgets/location_actions.dart';
import '../widgets/location_header.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenUtil.init(context);
    Get.put(LocationController());

    return BaseScreen(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.gray700),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      child: const LocationHeader(),
                    ),
                    const Spacer(),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: const LocationActions(),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
