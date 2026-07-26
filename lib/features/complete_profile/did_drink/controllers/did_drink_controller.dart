import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class DidDrinkController extends GetxController {
  final RxnString selectedOption = RxnString();
  final RxnString errorText = RxnString();

  final List<String> options = [
    'Yes, I enjoy it regularly',
    'Occasionally, with friends',
    'I don’t drink at all',
  ];

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void selectOption(String option) {
    selectedOption.value = option;
    errorText.value = null;
  }

  void onContinuePressed() {
    if (selectedOption.value == null) {
      errorText.value = 'Please select an option to continue';
      AppLogger.warning('No drinking habit selected');
      return;
    }

    commonController.setDrinkingHabit(selectedOption.value!);
    Get.toNamed(AppRoutes.identify);
  }
}
