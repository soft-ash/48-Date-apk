import 'package:donnymaestro/features/auth/phone/screen/phone_screen.dart';
import 'package:donnymaestro/features/complete_profile/location/screen/location_screen.dart';
import 'package:donnymaestro/features/complete_profile/nickname/screen/nickname_screen.dart';
import 'package:donnymaestro/features/complete_profile/real_name/screen/real_name_screen.dart';
import 'package:donnymaestro/features/complete_profile/birthday_&_ocupation/screen/birthday_occupation_screen.dart';
import 'package:donnymaestro/features/complete_profile/did_smoke/screen/did_smoke_screen.dart';
import 'package:donnymaestro/features/complete_profile/did_drink/screen/did_drink_screen.dart';
import 'package:donnymaestro/features/complete_profile/identify/screen/identify_screen.dart';
import 'package:donnymaestro/features/complete_profile/have_kids/screen/have_kids_screen.dart';
import 'package:donnymaestro/features/complete_profile/who_to_meet/screen/who_to_meet_screen.dart';
import 'package:donnymaestro/features/complete_profile/binding/complete_profile_binding.dart';
import 'package:donnymaestro/features/welcome/screen/welcome.dart';
import 'package:donnymaestro/features/splash/screens/splash_screen.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:get/get.dart';

abstract final class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage<dynamic>(name: AppRoutes.welcome, page: () => const Welcome()),
    GetPage<dynamic>(name: AppRoutes.phone, page: () => const PhoneScreen()),
    GetPage<dynamic>(
      name: AppRoutes.location,
      page: () => const LocationScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.nickname,
      page: () => const NicknameScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.realName,
      page: () => const RealNameScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.birthdayOccupation,
      page: () => const BirthdayOccupationScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.didSmoke,
      page: () => const DidSmokeScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.didDrink,
      page: () => const DidDrinkScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.identify,
      page: () => const IdentifyScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.haveKids,
      page: () => const HaveKidsScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.whoToMeet,
      page: () => const WhoToMeetScreen(),
      binding: CompleteProfileBinding(),
    ),
  ];
}
