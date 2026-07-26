import 'package:get/get.dart';
import 'package:donnymaestro/core/logger/logger.dart';

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
    AppLogger.consoleInfo(
      title: "setLocation",
      subtitle: "CommonController: Stored coordinates ($lat, $lng)",
    );
  }

  void skipLocation() {
    latitude.value = null;
    longitude.value = null;
    isLocationSkipped.value = true;
    AppLogger.consoleInfo(
      title: "skipLocation",
      subtitle: "CommonController: Marked location as skipped",
    );
  }

  // ==========================================
  // 2. Nickname Step Variables
  // ==========================================
  final RxString nickname = ''.obs;

  void setNickname(String name) {
    nickname.value = name;
    AppLogger.consoleInfo(
      title: "setNickname",
      subtitle: "CommonController: Stored nickname ($name)",
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
    AppLogger.consoleInfo(
      title: "setRealName",
      subtitle: "CommonController: Stored real name ($first $last)",
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
    AppLogger.consoleInfo(
      title: "setBirthdayAndOccupation",
      subtitle:
          "CommonController: Stored birthday ($month/$day/$year, Age: $age) & occupation ($job)",
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
    AppLogger.consoleInfo(title: "setSmokingHabit", subtitle: "Stored: $value");
  }

  void setDrinkingHabit(String value) {
    drinkingHabit.value = value;
    AppLogger.consoleInfo(title: "setDrinkingHabit", subtitle: "Stored: $value");
  }

  void setGenderIdentity(String value) {
    genderIdentity.value = value;
    AppLogger.consoleInfo(title: "setGenderIdentity", subtitle: "Stored: $value");
  }

  void setKidsInfo({required String kids, required String plan}) {
    haveKids.value = kids;
    futureKidsPlan.value = plan;
    AppLogger.consoleInfo(title: "setKidsInfo", subtitle: "Kids: $kids, Plan: $plan");
  }

  void setWhoToMeet(String value) {
    whoToMeet.value = value;
    AppLogger.consoleInfo(title: "setWhoToMeet", subtitle: "Stored: $value");
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
    AppLogger.consoleInfo(title: "setInterests", subtitle: "Stored: $values");
  }

  void setHeight(String value) {
    height.value = value;
    AppLogger.consoleInfo(title: "setHeight", subtitle: "Stored: $value");
  }

  void setWeight(String value) {
    weight.value = value;
    AppLogger.consoleInfo(title: "setWeight", subtitle: "Stored: $value");
  }

  void setLookingFor(String value) {
    lookingFor.value = value;
    AppLogger.consoleInfo(title: "setLookingFor", subtitle: "Stored: $value");
  }

  // ==========================================
  // 7. Unified API Submission
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
    };

    AppLogger.consoleInfo(
      title: "submitCompleteProfile",
      subtitle: "Submitting Complete Profile API Payload: $apiBody",
    );
    AppLogger.loading(status: 'Completing Profile...');

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      AppLogger.dismiss();
      AppLogger.success('Profile completed successfully!');

      // Navigate to Home or next onboarding module when ready
    } catch (e) {
      AppLogger.dismiss();
      AppLogger.error('Failed to complete profile: $e');
    }
  }
}
