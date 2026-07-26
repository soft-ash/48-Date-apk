import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';

class WhoToMeetController extends GetxController {
  final RxnString selectedOption = RxnString();
  final RxnString errorText = RxnString();

  final List<String> options = [
    'Women',
    'Man',
    'Everyone',
  ];

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void selectOption(String option) {
    selectedOption.value = option;
    errorText.value = null;
  }

  void onContinuePressed() {
    if (selectedOption.value == null) {
      errorText.value = 'Please select who you are here to meet';
      AppLogger.warning('No preference selected for who to meet');
      return;
    }

    commonController.setWhoToMeet(selectedOption.value!);
    // TODO: Navigate to next onboarding screen when created
  }
}
