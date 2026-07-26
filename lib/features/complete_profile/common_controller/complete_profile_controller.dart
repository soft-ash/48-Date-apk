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
  // 5. Unified API Submission
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
      // Future fields will be added here
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
