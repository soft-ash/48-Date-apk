import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';

class LookingForController extends GetxController {
  final RxnString selectedOption = RxnString();
  final RxnString errorText = RxnString();

  final List<Map<String, String>> options = [
    {
      'title': 'A real relationship',
      'subtitle': 'Ready for something serious',
    },
    {
      'title': 'Something meaningful',
      'subtitle': 'Open, but taking it seriously',
    },
    {
      'title': 'See where it goes',
      'subtitle': 'No pressure, real connection',
    },
    {
      'title': 'New friends first',
      'subtitle': 'Building a genuine bond',
    },
  ];

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void selectOption(String title) {
    selectedOption.value = title;
    errorText.value = null;
  }

  void onContinuePressed() {
    if (selectedOption.value == null) {
      errorText.value = 'Please select what you are looking for';
      AppLogger.warning('No preference selected for looking for');
      return;
    }

    commonController.setLookingFor(selectedOption.value!);
    // Submit the complete profile or navigate to next onboarding screen when added
    commonController.submitCompleteProfile();
  }
}
