import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/discover_user_model.dart';
import 'discover_worker.dart';
import 'package:logger_barta/logger_barta.dart';

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
      BartaLog.error(e.toString(), title: "Discover Error");
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
      BartaLog.error(e.toString(), title: "Pagination Error");
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
          CachedNetworkImageProvider(img).resolve(ImageConfiguration.empty);
        }
      }
    }
    BartaLog.debug(
      "Precached images for ${newUsers.length} users",
      tag: "Image Prefetch",
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
    BartaLog.debug(
      "Liked ${users[currentIndex.value].name}",
      tag: "Like Profile",
    );
    Future.delayed(const Duration(milliseconds: 280), _nextCard);
  }

  void onReject() {
    if (users.isEmpty || currentIndex.value >= users.length) return;
    HapticFeedback.lightImpact();
    isDragging.value = false;
    dragX.value = -600.0;
    dragY.value = 40.0;
    BartaLog.debug(
      "Rejected ${users[currentIndex.value].name}",
      tag: "Reject Profile",
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
