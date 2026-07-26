import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/font/style/text_style.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import 'package:donnymaestro/core/widgets/fade_in_up.dart';
import '../controllers/matches_controller.dart';

class MatchesFilterTabs extends StatelessWidget {
  const MatchesFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();
    final tabs = ['ALL', 'Cancelled', 'Complete'];

    return FadeInUp(
      delay: const Duration(milliseconds: 100),
      duration: const Duration(milliseconds: 450),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: tabs.map((tab) => _buildTabItem(tab, controller)).toList(),
        ),
      ),
    );
  }

  Widget _buildTabItem(String tab, MatchesController controller) {
    return Obx(() {
      final bool isSelected = controller.selectedFilter.value.toUpperCase() == tab.toUpperCase();

      return GestureDetector(
        onTap: () => controller.changeFilter(tab),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary500 : Colors.transparent,
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColor.primary500.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            tab,
            style: AppTextStyle.bodyMedium(
              weight: isSelected ? AppTextStyle.bold : AppTextStyle.medium,
            ).copyWith(
              color: isSelected ? Colors.white : AppColor.gray600,
            ),
          ),
        ),
      );
    });
  }
}
