import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/core/constant/colors.dart';
import 'package:donnymaestro/core/utils/background.dart';
import 'package:donnymaestro/core/utils/screen_utils.dart';
import '../controllers/matches_controller.dart';
import '../widgets/match_card.dart';
import '../widgets/matches_empty_view.dart';
import '../widgets/matches_filter_tabs.dart';
import '../widgets/matches_header.dart';
import '../widgets/matches_loading_view.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();

    return BaseScreen(
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      body: Column(
        children: [
          const MatchesHeader(),
          const MatchesFilterTabs(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const MatchesLoadingView();
              }

              final matches = controller.filteredMatches;

              if (matches.isEmpty) {
                return MatchesEmptyView(onRefresh: controller.refreshMatches);
              }

              return RefreshIndicator(
                onRefresh: controller.refreshMatches,
                color: AppColor.primary500,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemCount: matches.length,
                  itemBuilder: (context, index) => MatchCard(
                    match: matches[index],
                    index: index,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
