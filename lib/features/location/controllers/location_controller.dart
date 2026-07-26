import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/logger/logger.dart';

class LocationController extends GetxController {
  final RxBool isLoading = false.obs;

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
      AppLogger.consoleInfo(
        title:
            'Coordinates obtained: ${position.latitude}, ${position.longitude}',
      );
      // AppLogger.success('Location obtained: ${position.latitude}, ${position.longitude}');
      AppLogger.success('Location set successfully!');

      // Navigate to next screen when ready
    } catch (e) {
      AppLogger.dismiss();
      AppLogger.error('Failed to get location: $e');
    }
  }

  void onNotNowPressed() {
    AppLogger.info("User skipped location setup");
    // Navigate to next screen when ready
  }
}
