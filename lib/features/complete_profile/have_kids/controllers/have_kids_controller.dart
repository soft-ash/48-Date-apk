import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class HaveKidsController extends GetxController {
  final RxnString selectedKidsOption = RxnString();
  final RxnString selectedFuturePlanOption = RxnString();
  final RxnString errorText = RxnString();

  final List<String> kidsOptions = ['I have Kids', 'Don’t have kids'];

  final List<String> futurePlanOptions = [
    'Yes Definitely i want kids.',
    'No, I don’t see children in my future',
  ];

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void selectKidsOption(String option) {
    selectedKidsOption.value = option;
    errorText.value = null;
  }

  void selectFuturePlanOption(String option) {
    selectedFuturePlanOption.value = option;
    errorText.value = null;
  }

  void onContinuePressed() {
    if (selectedKidsOption.value == null ||
        selectedFuturePlanOption.value == null) {
      errorText.value = 'Please answer both questions to continue';
      AppLogger.warning('Missing kids or future plan selection');
      return;
    }

    commonController.setKidsInfo(
      kids: selectedKidsOption.value!,
      plan: selectedFuturePlanOption.value!,
    );
    Get.toNamed(AppRoutes.whoToMeet);
  }
}
