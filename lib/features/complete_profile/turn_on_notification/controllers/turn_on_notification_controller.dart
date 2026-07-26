import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';

class TurnOnNotificationController extends GetxController {
  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  Future<void> enableNotifications() async {
    try {
      final status = await Permission.notification.request();
      final isGranted = status.isGranted || status.isProvisional;
      commonController.setNotifications(isGranted);
      AppLogger.consoleInfo(
        title: "enableNotifications",
        subtitle: "Notification permission status: $status (Granted: $isGranted)",
      );
    } catch (e) {
      AppLogger.error("Failed to request notification permission: $e");
      // On emulator/desktop or if permission handler fails, still record as true for demo
      commonController.setNotifications(true);
    }

    // This is the final step of onboarding! Submit the complete profile payload!
    commonController.submitCompleteProfile();
  }
}
