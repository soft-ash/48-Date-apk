import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:logger_barta/logger_barta.dart';

class LocationController extends GetxController {
  final RxBool isLoading = false.obs;

  CompleteProfileController get commonController =>
      Get.find<CompleteProfileController>();

  Future<void> onSetLocationServicesPressed() async {
    AppLogger.info("Requesting location services...");
    AppLogger.loading(status: 'Checking permission...');

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        AppLogger.dismiss();
        AppLogger.warning(
          'Location services are disabled. Opening settings...',
        );
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppLogger.dismiss();
          AppLogger.warning('Location permission denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AppLogger.dismiss();
        AppLogger.error(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
        await Geolocator.openAppSettings();
        return;
      }

      AppLogger.loading(status: 'Fetching location...');
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      AppLogger.dismiss();
      BartaLog.debug(
        'Coordinates obtained: ${position.latitude}, ${position.longitude}',
      );
      // Store in Common Controller for final API body
      commonController.setLocation(position.latitude, position.longitude);
      Get.toNamed(AppRoutes.nickname);
    } catch (e) {
      AppLogger.dismiss();
      AppLogger.error('Failed to get location: $e');
    }
  }

  void onNotNowPressed() {
    AppLogger.info("User skipped location setup");
    commonController.skipLocation();
    Get.toNamed(AppRoutes.nickname);
  }
}
