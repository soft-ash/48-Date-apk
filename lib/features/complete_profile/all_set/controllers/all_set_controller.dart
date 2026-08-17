import 'package:get/get.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:logger_barta/logger_barta.dart';

class AllSetController extends GetxController {
  void startDiscovering() {
    BartaLog.debug(
      "User completed profile onboarding and entered discovery mode",
      tag: "startDiscovering",
    );
    // Navigate to Bottom Navbar (Discovery mode)
    Get.offAllNamed(AppRoutes.bottomNavbar);
  }
}
