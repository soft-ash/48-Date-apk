import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class WeightController extends GetxController {
  final List<String> weightOptions = List.generate(
    55,
    (index) => '${80 + index * 5} lbs',
  );

  late final FixedExtentScrollController scrollController;
  final RxInt selectedIndex = 16.obs; // Default to 160 lbs
  final RxString selectedWeight = '160 lbs'.obs;

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  @override
  void onInit() {
    super.onInit();
    scrollController = FixedExtentScrollController(
      initialItem: selectedIndex.value,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void onWeightChanged(int index) {
    selectedIndex.value = index;
    selectedWeight.value = weightOptions[index];
  }

  void onContinuePressed() {
    commonController.setWeight(selectedWeight.value);
    Get.toNamed(AppRoutes.lookingFor);
  }
}
