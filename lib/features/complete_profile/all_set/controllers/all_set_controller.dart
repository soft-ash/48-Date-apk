import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class AllSetController extends GetxController {
  void startDiscovering() {
    AppLogger.consoleInfo(
      title: "startDiscovering",
      subtitle: "User completed profile onboarding and entered discovery mode",
    );
    // Navigate to Bottom Navbar (Discovery mode)
    Get.offAllNamed(AppRoutes.bottomNavbar);
  }
}
