import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class DidSmokeController extends GetxController {
  final RxnString selectedOption = RxnString();
  final RxnString errorText = RxnString();

  final List<String> options = [
    'Yes, I’m a regular smoker',
    'I smoke occasionally',
    'I don’t smoke at all',
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
      AppLogger.warning('No smoking habit selected');
      return;
    }

    commonController.setSmokingHabit(selectedOption.value!);
    Get.toNamed(AppRoutes.didDrink);
  }
}
