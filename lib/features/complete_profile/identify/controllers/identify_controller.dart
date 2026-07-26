import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class IdentifyController extends GetxController {
  final RxnString selectedOption = RxnString();
  final RxnString errorText = RxnString();

  final List<String> options = [
    'Women',
    'Man',
    'Not prefer to say',
  ];

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void selectOption(String option) {
    selectedOption.value = option;
    errorText.value = null;
  }

  void onContinuePressed() {
    if (selectedOption.value == null) {
      errorText.value = 'Please select your identity to continue';
      AppLogger.warning('No gender identity selected');
      return;
    }

    commonController.setGenderIdentity(selectedOption.value!);
    Get.toNamed(AppRoutes.haveKids);
  }
}
