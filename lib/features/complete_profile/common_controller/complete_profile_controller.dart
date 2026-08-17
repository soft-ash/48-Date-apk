import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';
import 'package:donnymaestro/routes/app_routes.dart';
import 'package:logger_barta/logger_barta.dart';

class CompleteProfileController extends GetxController {
  // ==========================================
  // 1. Location Step Variables
  // ==========================================
  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();
  final RxBool isLocationSkipped = false.obs;

  void setLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
    isLocationSkipped.value = false;
    BartaLog.debug(
      "CommonController: Stored coordinates ($lat, $lng)",
      tag: "setLocation",
    );
  }

  void skipLocation() {
    latitude.value = null;
    longitude.value = null;
    isLocationSkipped.value = true;
    BartaLog.debug(
      "CommonController: Marked location as skipped",
      tag: "skipLocation",
    );
  }

  // ==========================================
  // 2. Nickname Step Variables
  // ==========================================
  final RxString nickname = ''.obs;

  void setNickname(String name) {
    nickname.value = name;
    BartaLog.debug(
      "CommonController: Stored nickname ($name)",
      tag: "setNickname",
    );
  }

  // ==========================================
  // 3. Real Name Step Variables
  // ==========================================
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;

  void setRealName(String first, String last) {
    firstName.value = first;
    lastName.value = last;
    BartaLog.debug(
      "CommonController: Stored real name ($first $last)",
      tag: "setRealName",
    );
  }

  // ==========================================
  // 4. Birthday & Occupation Step Variables
  // ==========================================
  final RxnString birthMonth = RxnString();
  final RxnString birthDay = RxnString();
  final RxnString birthYear = RxnString();
  final RxInt calculatedAge = 0.obs;
  final RxString occupation = ''.obs;

  void setBirthdayAndOccupation({
    required String month,
    required String day,
    required String year,
    required int age,
    required String job,
  }) {
    birthMonth.value = month;
    birthDay.value = day;
    birthYear.value = year;
    calculatedAge.value = age;
    occupation.value = job;
    BartaLog.debug(
      "CommonController: Stored birthday ($month/$day/$year, Age: $age) & occupation ($job)",
      tag: "setBirthdayAndOccupation",
    );
  }

  // ==========================================
  // 5. Additional Onboarding Step Variables
  // ==========================================
  final RxnString smokingHabit = RxnString();
  final RxnString drinkingHabit = RxnString();
  final RxnString genderIdentity = RxnString();
  final RxnString haveKids = RxnString();
  final RxnString futureKidsPlan = RxnString();
  final RxnString whoToMeet = RxnString();

  void setSmokingHabit(String value) {
    smokingHabit.value = value;
    BartaLog.debug("Stored: $value", tag: "setSmokingHabit");
  }

  void setDrinkingHabit(String value) {
    drinkingHabit.value = value;
    BartaLog.debug("Stored: $value", tag: "setDrinkingHabit");
  }

  void setGenderIdentity(String value) {
    genderIdentity.value = value;
    BartaLog.debug("Stored: $value", tag: "setGenderIdentity");
  }

  void setKidsInfo({required String kids, required String plan}) {
    haveKids.value = kids;
    futureKidsPlan.value = plan;
    BartaLog.debug("Kids: $kids, Plan: $plan", tag: "setKidsInfo");
  }

  void setWhoToMeet(String value) {
    whoToMeet.value = value;
    BartaLog.debug("Stored: $value", tag: "setWhoToMeet");
  }

  // ==========================================
  // 6. Final Step Variables (Interests, Height, Weight, Looking For)
  // ==========================================
  final RxList<String> interests = <String>[].obs;
  final RxnString height = RxnString();
  final RxnString weight = RxnString();
  final RxnString lookingFor = RxnString();

  void setInterests(List<String> values) {
    interests.assignAll(values);
    BartaLog.debug("Stored: $values", tag: "setInterests");
  }

  void setHeight(String value) {
    height.value = value;
    BartaLog.debug("Stored: $value", tag: "setHeight");
  }

  void setWeight(String value) {
    weight.value = value;
    BartaLog.debug("Stored: $value", tag: "setWeight");
  }

  void setLookingFor(String value) {
    lookingFor.value = value;
    BartaLog.debug("Stored: $value", tag: "setLookingFor");
  }

  // ==========================================
  // 7. Add Photos Step Variables
  // ==========================================
  final RxList<String> photos = <String>[].obs;

  void setPhotos(List<String> values) {
    photos.assignAll(values);
    BartaLog.debug("Stored ${values.length} photos", tag: "setPhotos");
  }

  // ==========================================
  // 8. Selfie Verification Variables
  // ==========================================
  final RxnString selfiePath = RxnString();
  final RxBool isSelfieSkipped = false.obs;

  void setSelfie(String path) {
    selfiePath.value = path;
    isSelfieSkipped.value = false;
    BartaLog.debug("Stored selfie: $path", tag: "setSelfie");
  }

  void skipSelfie() {
    selfiePath.value = null;
    isSelfieSkipped.value = true;
    BartaLog.debug("Skipped selfie verification", tag: "skipSelfie");
  }

  // ==========================================
  // 9. Turn On Notifications Variables
  // ==========================================
  final RxBool notificationsEnabled = false.obs;

  void setNotifications(bool enabled) {
    notificationsEnabled.value = enabled;
    BartaLog.debug("Notifications enabled: $enabled", tag: "setNotifications");
  }

  // ==========================================
  // 10. Unified API Submission
  // ==========================================
  Future<void> submitCompleteProfile() async {
    final Map<String, dynamic> apiBody = {
      'latitude': latitude.value,
      'longitude': longitude.value,
      'is_location_skipped': isLocationSkipped.value,
      'nickname': nickname.value,
      'first_name': firstName.value,
      'last_name': lastName.value,
      'birth_month': birthMonth.value,
      'birth_day': birthDay.value,
      'birth_year': birthYear.value,
      'age': calculatedAge.value,
      'occupation': occupation.value,
      'smoking_habit': smokingHabit.value,
      'drinking_habit': drinkingHabit.value,
      'gender_identity': genderIdentity.value,
      'have_kids': haveKids.value,
      'future_kids_plan': futureKidsPlan.value,
      'who_to_meet': whoToMeet.value,
      'interests': interests.toList(),
      'height': height.value,
      'weight': weight.value,
      'looking_for': lookingFor.value,
      'photos': photos.toList(),
      'selfie_path': selfiePath.value,
      'is_selfie_skipped': isSelfieSkipped.value,
      'notifications_enabled': notificationsEnabled.value,
    };

    BartaLog.debug(
      "Submitting Complete Profile API Payload: $apiBody",
      tag: "submitCompleteProfile",
    );
    AppLogger.loading(status: 'Completing Profile...');

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      AppLogger.dismiss();
      AppLogger.success('Profile completed successfully!');

      Get.offAllNamed(AppRoutes.allSet);
    } catch (e) {
      AppLogger.dismiss();
      AppLogger.error('Failed to complete profile: $e');
    }
  }
}
