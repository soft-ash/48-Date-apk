import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class TakeSelfieController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  /// Captured selfie path — stored for future backend submission.
  final Rxn<String> capturedImagePath = Rxn<String>();

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  void skipSelfie() {
    commonController.skipSelfie();
    Get.toNamed(AppRoutes.turnOnNotification);
  }

  void openPoseCamera() {
    Get.toNamed(AppRoutes.poseCamera);
  }

  Future<void> takePictureAndVerify() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );
      capturedImagePath.value = photo?.path ?? 'demo_selfie_verified.jpg';
    } catch (e) {
      AppLogger.error('Failed to capture selfie: $e');
      capturedImagePath.value = 'demo_selfie_verified.jpg';
    }

    commonController.setSelfie(
      capturedImagePath.value ?? 'demo_selfie_verified.jpg',
    );
    Get.toNamed(AppRoutes.complete);
  }
}
