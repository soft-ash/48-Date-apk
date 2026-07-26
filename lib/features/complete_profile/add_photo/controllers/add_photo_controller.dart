import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class AddPhotoController extends GetxController {
  // Exactly 6 slots for photos
  final RxList<String?> photoSlots = RxList<String?>.filled(6, null);
  final RxnString errorText = RxnString();
  final ImagePicker _picker = ImagePicker();

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  Future<void> pickPhoto(int index) async {
    try {
      // User specifically requested: "add picture from only gallery open"
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        photoSlots[index] = image.path;
        errorText.value = null;
        AppLogger.consoleInfo(
          title: "pickPhoto",
          subtitle: "Added photo to slot $index: ${image.path}",
        );
      }
    } catch (e) {
      AppLogger.error("Failed to pick photo from gallery: $e");
    }
  }

  void removePhoto(int index) {
    photoSlots[index] = null;
    AppLogger.consoleInfo(
      title: "removePhoto",
      subtitle: "Removed photo from slot $index",
    );
  }

  void onContinuePressed() {
    final selectedPhotos = photoSlots.whereType<String>().toList();
    if (selectedPhotos.length < 2) {
      errorText.value = 'Please add at least 2 photos to continue.';
      AppLogger.warning('Attempted to continue with less than 2 photos');
      return;
    }

    commonController.setPhotos(selectedPhotos);
    Get.toNamed(AppRoutes.takeSelfie);
  }
}
