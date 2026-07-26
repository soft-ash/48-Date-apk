import 'package:get/get.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/features/complete_profile/location/controllers/location_controller.dart';
import 'package:donnymaestro/features/complete_profile/nickname/controllers/nickname_controller.dart';
import 'package:donnymaestro/features/complete_profile/real_name/controllers/real_name_controller.dart';
import 'package:donnymaestro/features/complete_profile/birthday_&_ocupation/controllers/birthday_occupation_controller.dart';
import 'package:donnymaestro/features/complete_profile/did_smoke/controllers/did_smoke_controller.dart';
import 'package:donnymaestro/features/complete_profile/did_drink/controllers/did_drink_controller.dart';
import 'package:donnymaestro/features/complete_profile/identify/controllers/identify_controller.dart';
import 'package:donnymaestro/features/complete_profile/have_kids/controllers/have_kids_controller.dart';
import 'package:donnymaestro/features/complete_profile/who_to_meet/controllers/who_to_meet_controller.dart';
import 'package:donnymaestro/features/complete_profile/interest/controllers/interest_controller.dart';
import 'package:donnymaestro/features/complete_profile/height/controllers/height_controller.dart';
import 'package:donnymaestro/features/complete_profile/weight/controllers/weight_controller.dart';
import 'package:donnymaestro/features/complete_profile/looking_for/controllers/looking_for_controller.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Shared single source of truth for profile completion (must remain in memory across screens)
    Get.put(CompleteProfileController(), permanent: true);

    // 2. Lazy load individual step controllers only when their screen is opened
    Get.lazyPut(() => LocationController(), fenix: true);
    Get.lazyPut(() => NicknameController(), fenix: true);
    Get.lazyPut(() => RealNameController(), fenix: true);
    Get.lazyPut(() => BirthdayOccupationController(), fenix: true);
    Get.lazyPut(() => DidSmokeController(), fenix: true);
    Get.lazyPut(() => DidDrinkController(), fenix: true);
    Get.lazyPut(() => IdentifyController(), fenix: true);
    Get.lazyPut(() => HaveKidsController(), fenix: true);
    Get.lazyPut(() => WhoToMeetController(), fenix: true);
    Get.lazyPut(() => InterestController(), fenix: true);
    Get.lazyPut(() => HeightController(), fenix: true);
    Get.lazyPut(() => WeightController(), fenix: true);
    Get.lazyPut(() => LookingForController(), fenix: true);
  }
}
