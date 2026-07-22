import 'package:donnymaestro/features/auth/phone/screen/phone_screen.dart';
import 'package:donnymaestro/features/welcome/screen/welcome.dart';
import 'package:donnymaestro/features/splash/screens/splash_screen.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:get/get.dart';

abstract final class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage<dynamic>(name: AppRoutes.welcome, page: () => const Welcome()),
    GetPage<dynamic>(name: AppRoutes.phone, page: () => const PhoneScreen()),
  ];
}
