import 'package:get/get.dart';
import 'package:donnymaestro/features/discover/controller/discover_controller.dart';
import '../controllers/bottom_navbar_controller.dart';

class BottomNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavbarController>(() => BottomNavbarController());
    Get.lazyPut<DiscoverController>(() => DiscoverController());
  }
}
