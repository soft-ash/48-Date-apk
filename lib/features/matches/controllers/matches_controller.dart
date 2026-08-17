import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import '../models/match_model.dart';
import '../widgets/match_detail_bottom_sheet.dart';
import '../widgets/match_rate_dialog.dart';
import 'matches_worker.dart';
import 'package:logger_barta/logger_barta.dart';

class MatchesController extends GetxController {
  final RxList<MatchModel> allMatches = <MatchModel>[].obs;
  final RxString selectedFilter = 'ALL'.obs; // 'ALL', 'Cancelled', 'Complete'
  final RxBool isLoading = true.obs;
  final RxBool isRefreshing = false.obs;
  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialMatches();
  }

  /// Dynamic active count for header subtitle
  int get activeCount => allMatches
      .where(
        (m) =>
            m.status == MatchStatus.active ||
            m.status == MatchStatus.expiringSoon ||
            m.status == MatchStatus.dateSet,
      )
      .length;

  /// Filtered list based on selected tab
  List<MatchModel> get filteredMatches {
    final filter = selectedFilter.value.toUpperCase();
    if (filter == 'CANCELLED' || filter == 'CANCELED') {
      return allMatches
          .where((m) => m.status == MatchStatus.cancelled)
          .toList();
    } else if (filter == 'COMPLETE') {
      return allMatches
          .where((m) => m.status == MatchStatus.dateComplete)
          .toList();
    }
    // For 'ALL', show everything
    return allMatches;
  }

  Future<void> loadInitialMatches() async {
    try {
      isLoading.value = true;
      final rawMaps = await compute(
        generateDummyMatchesInIsolate,
        currentPage.value,
      );
      final newMatches = await compute(parseMatchesInIsolate, rawMaps);
      allMatches.assignAll(newMatches);
      _precacheImages(newMatches);
    } catch (e) {
      BartaLog.error(e.toString(), title: "Matches Load Error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshMatches() async {
    if (isRefreshing.value) return;
    try {
      isRefreshing.value = true;
      HapticFeedback.mediumImpact();
      currentPage.value = 0;
      final rawMaps = await compute(
        generateDummyMatchesInIsolate,
        currentPage.value,
      );
      final newMatches = await compute(parseMatchesInIsolate, rawMaps);
      allMatches.assignAll(newMatches);
      _precacheImages(newMatches);
      BartaLog.debug(
        "Loaded ${newMatches.length} matches",
        tag: "Matches Refreshed",
      );
    } catch (e) {
      BartaLog.error(e.toString(), title: "Refresh Error");
    } finally {
      isRefreshing.value = false;
    }
  }

  void _precacheImages(List<MatchModel> matches) {
    for (final match in matches) {
      if (match.profileImage.isNotEmpty) {
        CachedNetworkImageProvider(
          match.profileImage,
        ).resolve(ImageConfiguration.empty);
      }
      if (match.dateDetails?.matchPartnerAvatar != null &&
          match.dateDetails!.matchPartnerAvatar.isNotEmpty) {
        CachedNetworkImageProvider(
          match.dateDetails!.matchPartnerAvatar,
        ).resolve(ImageConfiguration.empty);
      }
    }
    BartaLog.debug(
      "Precached images for ${matches.length} matches",
      tag: "Matches Image Prefetch",
    );
  }

  void changeFilter(String tab) {
    if (selectedFilter.value == tab) return;
    HapticFeedback.lightImpact();
    selectedFilter.value = tab;
    BartaLog.debug("Switched to tab: $tab", tag: "Filter Changed");
  }

  // --- Action Button Handlers ---

  void openMessage(MatchModel match) {
    HapticFeedback.lightImpact();
    BartaLog.debug("Chat with ${match.name}", tag: "Open Message");
    EasyLoading.showToast(
      "Opening chat with ${match.name}...",
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }

  void planDate(MatchModel match) {
    HapticFeedback.lightImpact();
    BartaLog.debug("Planning date with ${match.name}", tag: "Plan Date");
    viewDetails(match);
  }

  void viewDetails(MatchModel match) {
    HapticFeedback.lightImpact();
    BartaLog.debug("Viewing details for ${match.name}", tag: "View Details");
    Get.bottomSheet(
      MatchDetailBottomSheet(match: match, controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void cancelDate(MatchModel match) {
    HapticFeedback.mediumImpact();
    Get.defaultDialog(
      title: "Cancel Date",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      middleText:
          "Are you sure you want to cancel your scheduled date with ${match.name}?",
      middleTextStyle: const TextStyle(fontSize: 14),
      textConfirm: "Yes, Cancel",
      textCancel: "Keep Date",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFE11D48),
      radius: 16,
      onConfirm: () {
        Get.back();
        _performCancelDate(match);
      },
    );
  }

  void _performCancelDate(MatchModel match) async {
    AppLogger.loading(status: "Cancelling date...");
    await Future.delayed(const Duration(milliseconds: 600));
    final index = allMatches.indexWhere((m) => m.id == match.id);
    if (index != -1) {
      allMatches[index] = match.copyWith(
        status: MatchStatus.cancelled,
        remainingTimeText: "Canceled",
        warningText: null,
      );
      allMatches.refresh();
    }
    AppLogger.dismiss();
    AppLogger.success("Date cancelled with ${match.name}");
  }

  void rateDate(MatchModel match) {
    HapticFeedback.lightImpact();
    Get.dialog(MatchRateDialog(match: match, onSubmit: _submitRating));
  }

  void _submitRating(MatchModel match, int stars, String feedback) async {
    AppLogger.loading(status: "Submitting rating...");
    await Future.delayed(const Duration(milliseconds: 600));
    AppLogger.dismiss();
    AppLogger.success("Thank you for rating your date!");
  }
}
