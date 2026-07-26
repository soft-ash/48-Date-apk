import 'package:get/get.dart';
import 'package:donnymaestro/features/complete_profile/common_controller/complete_profile_controller.dart';
import 'package:donnymaestro/features/complete_profile/location/controllers/location_controller.dart';
import 'package:donnymaestro/features/complete_profile/nickname/controllers/nickname_controller.dart';
import 'package:donnymaestro/features/complete_profile/real_name/controllers/real_name_controller.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Shared single source of truth for profile completion (must remain in memory across screens)
    Get.put(CompleteProfileController(), permanent: true);

    // 2. Lazy load individual step controllers only when their screen is opened
    Get.lazyPut(() => LocationController(), fenix: true);
    Get.lazyPut(() => NicknameController(), fenix: true);
    Get.lazyPut(() => RealNameController(), fenix: true);
  }
}
