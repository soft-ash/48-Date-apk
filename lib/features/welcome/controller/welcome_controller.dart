import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final RxBool isLoginMode = false.obs;

  void showLoginMode() {
    isLoginMode.value = true;
  }

  void showSplashMode() {
    isLoginMode.value = false;
  }
}
