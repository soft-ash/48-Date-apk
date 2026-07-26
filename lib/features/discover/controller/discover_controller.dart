import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import '../model/discover_user_model.dart';
import 'discover_worker.dart';

class DiscoverController extends GetxController {
  final RxList<DiscoverUserModel> users = <DiscoverUserModel>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isMoreLoading = false.obs;
  final RxInt currentPage = 0.obs;

  final RxDouble dragX = 0.0.obs;
  final RxDouble dragY = 0.0.obs;
  final RxBool isDragging = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialUsers();
  }

  Future<void> loadInitialUsers() async {
    try {
      isLoading.value = true;
      final rawMaps = await compute(
        generateDummyUsersInIsolate,
        currentPage.value,
      );
      final newUsers = await compute(parseUsersInIsolate, rawMaps);
      users.assignAll(newUsers);
      _precacheImages(newUsers);
    } catch (e) {
      AppLogger.consoleInfo(title: "Discover Error", subtitle: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreUsers() async {
    if (isMoreLoading.value) return;
    try {
      isMoreLoading.value = true;
      currentPage.value++;
      final rawMaps = await compute(
        generateDummyUsersInIsolate,
        currentPage.value,
      );
      final newUsers = await compute(parseUsersInIsolate, rawMaps);
      users.addAll(newUsers);
      _precacheImages(newUsers);
    } catch (e) {
      AppLogger.consoleInfo(title: "Pagination Error", subtitle: e.toString());
    } finally {
      isMoreLoading.value = false;
    }
  }

  void _precacheImages(List<DiscoverUserModel> newUsers) {
    for (final user in newUsers) {
      if (user.profileImage.isNotEmpty) {
        CachedNetworkImageProvider(
          user.profileImage,
        ).resolve(ImageConfiguration.empty);
      }
      for (final img in user.postImages) {
        if (img.isNotEmpty) {
          CachedNetworkImageProvider(
            img,
          ).resolve(ImageConfiguration.empty);
        }
      }
    }
    AppLogger.consoleInfo(
      title: "Image Prefetch",
      subtitle: "Precached images for ${newUsers.length} users",
    );
  }

  void onDragUpdate(double dx, double dy) {
    isDragging.value = true;
    dragX.value += dx;
    dragY.value += dy;
  }

  void onDragEnd(double velocityX) {
    isDragging.value = false;
    if (dragX.value > 110 || velocityX > 700) {
      onLike();
    } else if (dragX.value < -110 || velocityX < -700) {
      onReject();
    } else {
      resetDrag();
    }
  }

  void resetDrag() {
    isDragging.value = false;
    dragX.value = 0.0;
    dragY.value = 0.0;
  }

  void onLike() {
    if (users.isEmpty || currentIndex.value >= users.length) return;
    HapticFeedback.mediumImpact();
    isDragging.value = false;
    dragX.value = 600.0;
    dragY.value = 40.0;
    AppLogger.consoleInfo(
      title: "Like Profile",
      subtitle: "Liked ${users[currentIndex.value].name}",
    );
    Future.delayed(const Duration(milliseconds: 280), _nextCard);
  }

  void onReject() {
    if (users.isEmpty || currentIndex.value >= users.length) return;
    HapticFeedback.lightImpact();
    isDragging.value = false;
    dragX.value = -600.0;
    dragY.value = 40.0;
    AppLogger.consoleInfo(
      title: "Reject Profile",
      subtitle: "Rejected ${users[currentIndex.value].name}",
    );
    Future.delayed(const Duration(milliseconds: 280), _nextCard);
  }

  void _nextCard() {
    currentIndex.value++;
    dragX.value = 0.0;
    dragY.value = 0.0;
    if (users.length - currentIndex.value <= 2) {
      loadMoreUsers();
    }
  }
}
