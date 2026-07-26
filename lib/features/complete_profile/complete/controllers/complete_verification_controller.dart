import 'package:get/get.dart';
import 'package:donnymaestro/routes/app_routes.dart';

class CompleteVerificationController extends GetxController {
  void onContinuePressed() {
    Get.toNamed(AppRoutes.turnOnNotification);
  }
}
