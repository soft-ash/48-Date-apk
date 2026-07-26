import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class InterestController extends GetxController {
  final RxList<String> selectedInterests = <String>[].obs;
  final RxnString errorText = RxnString();

  final Map<String, List<Map<String, String>>> categorizedInterests = {
    'Creativity': [
      {'label': 'Art', 'emoji': '🎨'},
      {'label': 'Design', 'emoji': '✏️'},
      {'label': 'Makeup', 'emoji': '💄'},
      {'label': 'Photography', 'emoji': '📷'},
      {'label': 'Fashion', 'emoji': '👗'},
      {'label': 'Singing', 'emoji': '🎤'},
    ],
    'Sports': [
      {'label': 'Running', 'emoji': '🏃'},
      {'label': 'Gym', 'emoji': '🏋️'},
      {'label': 'Soccer', 'emoji': '⚽'},
      {'label': 'Cricket', 'emoji': '🏏'},
      {'label': 'Tennis', 'emoji': '🎾'},
      {'label': 'Basketball', 'emoji': '🏀'},
    ],
    'Movies & Dramas': [
      {'label': 'TV Shows', 'emoji': '📺'},
      {'label': 'Romance', 'emoji': '❤️'},
      {'label': 'Comedy', 'emoji': '😂'},
      {'label': 'K-Drama', 'emoji': '🌏'},
      {'label': 'Horror', 'emoji': '😱'},
      {'label': 'Thriller', 'emoji': '🕵️'},
      {'label': 'Sci-Fi', 'emoji': '🚀'},
      {'label': 'Fantasy', 'emoji': '🧙'},
      {'label': 'Anime', 'emoji': '🎇'},
      {'label': 'Zombie', 'emoji': '🧟'},
    ],
  };

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void toggleInterest(String label) {
    if (selectedInterests.contains(label)) {
      selectedInterests.remove(label);
      errorText.value = null;
    } else {
      if (selectedInterests.length < 5) {
        selectedInterests.add(label);
        errorText.value = null;
      } else {
        AppLogger.warning('You can select up to 5 interests only');
      }
    }
  }

  void onContinuePressed() {
    if (selectedInterests.isEmpty) {
      errorText.value = 'Please select at least 1 interest';
      AppLogger.warning('No interests selected');
      return;
    }

    commonController.setInterests(selectedInterests.toList());
    Get.toNamed(AppRoutes.height);
  }
}
