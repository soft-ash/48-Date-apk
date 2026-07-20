import 'package:donnymaestro/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxBool showLogo = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 350));
    showLogo.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.offAllNamed(AppRoutes.welcome);
  }
}
