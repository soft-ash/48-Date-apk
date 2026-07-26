import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class HeightController extends GetxController {
  final List<String> heightOptions = [
    '4\'0" ft', '4\'1" ft', '4\'2" ft', '4\'3" ft', '4\'4" ft', '4\'5" ft',
    '4\'6" ft', '4\'7" ft', '4\'8" ft', '4\'9" ft', '4\'10" ft', '4\'11" ft',
    '5\'0" ft', '5\'1" ft', '5\'2" ft', '5\'3" ft', '5\'4" ft', '5\'5" ft',
    '5\'6" ft', '5\'7" ft', '5\'8" ft', '5\'9" ft', '5\'10" ft', '5\'11" ft',
    '6\'0" ft', '6\'1" ft', '6\'2" ft', '6\'3" ft', '6\'4" ft', '6\'5" ft',
    '6\'6" ft', '6\'7" ft', '6\'8" ft', '6\'9" ft', '6\'10" ft', '6\'11" ft',
    '7\'0" ft',
  ];

  late final FixedExtentScrollController scrollController;
  final RxInt selectedIndex = 21.obs; // Default to 5'9" ft
  final RxString selectedHeight = '5\'9" ft'.obs;

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  @override
  void onInit() {
    super.onInit();
    scrollController = FixedExtentScrollController(initialItem: selectedIndex.value);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void onHeightChanged(int index) {
    selectedIndex.value = index;
    selectedHeight.value = heightOptions[index];
  }

  void onContinuePressed() {
    commonController.setHeight(selectedHeight.value);
    Get.toNamed(AppRoutes.weight);
  }
}
