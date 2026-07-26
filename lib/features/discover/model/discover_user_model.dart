import 'interest_model.dart';

class DiscoverUserModel {
  final String id;
  final String name;
  final int age;
  final bool isVerified;
  final String profileImage;
  final List<String> postImages;
  final String distanceText;
  final int distanceInMiles;
  final List<String> personalityTags;
  final bool isOnline;
  final String lastSeen;
  final double trustScore;
  final String trustScoreLabel;
  final String trustShieldLabel;
  final String bio;
  final String height;
  final String weight;
  final String smoking;
  final String drinking;
  final String identify;
  final String haveKids;
  final String zodiac;
  final String workout;
  final List<InterestModel> interests;
  final String lookingFor;
  final String relationshipGoal;
  final String occupation;
  final String workplace;
  final String education;
  final String graduationYear;
  final List<String> languages;
  final String location;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;
  final bool isLiked;
  final bool isPassed;
  final bool isSuperLiked;

  const DiscoverUserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.isVerified,
    required this.profileImage,
    required this.postImages,
    required this.distanceText,
    required this.distanceInMiles,
    required this.personalityTags,
    required this.isOnline,
    required this.lastSeen,
    required this.trustScore,
    required this.trustScoreLabel,
    required this.trustShieldLabel,
    required this.bio,
    required this.height,
    required this.weight,
    required this.smoking,
    required this.drinking,
    required this.identify,
    required this.haveKids,
    required this.zodiac,
    required this.workout,
    required this.interests,
    required this.lookingFor,
    required this.relationshipGoal,
    required this.occupation,
    required this.workplace,
    required this.education,
    required this.graduationYear,
    required this.languages,
    required this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isLiked,
    required this.isPassed,
    required this.isSuperLiked,
  });

  factory DiscoverUserModel.fromJson(Map<String, dynamic> json) {
    return DiscoverUserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      age: int.tryParse(json['age']?.toString() ?? '') ?? 18,
      isVerified: json['isVerified'] == true || json['isVerified'] == 'true',
      profileImage: json['profileImage']?.toString() ?? '',
      postImages:
          (json['postImages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      distanceText: json['distanceText']?.toString() ?? '',
      distanceInMiles:
          int.tryParse(json['distanceInMiles']?.toString() ?? '') ?? 0,
      personalityTags:
          (json['personalityTags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isOnline: json['isOnline'] == true || json['isOnline'] == 'true',
      lastSeen: json['lastSeen']?.toString() ?? '',
      trustScore: double.tryParse(json['trustScore']?.toString() ?? '') ?? 0.0,
      trustScoreLabel: json['trustScoreLabel']?.toString() ?? 'Trust Score',
      trustShieldLabel: json['trustShieldLabel']?.toString() ?? 'Trust Shield',
      bio: json['bio']?.toString() ?? '',
      height: json['height']?.toString() ?? '',
      weight: json['weight']?.toString() ?? '',
      smoking:
          json['smoking']?.toString() ?? json['didSmoke']?.toString() ?? '',
      drinking:
          json['drinking']?.toString() ?? json['didDrink']?.toString() ?? '',
      identify: json['identify']?.toString() ?? '',
      haveKids: json['haveKids']?.toString() ?? '',
      zodiac: json['zodiac']?.toString() ?? '',
      workout: json['workout']?.toString() ?? '',
      interests:
          (json['interests'] as List<dynamic>?)
              ?.map((e) => InterestModel.fromJson(e))
              .toList() ??
          const [],
      lookingFor: json['lookingFor']?.toString() ?? '',
      relationshipGoal: json['relationshipGoal']?.toString() ?? '',
      occupation: json['occupation']?.toString() ?? '',
      workplace: json['workplace']?.toString() ?? '',
      education: json['education']?.toString() ?? '',
      graduationYear: json['graduationYear']?.toString() ?? '',
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      location: json['location']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      latitude: double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,
      isLiked: json['isLiked'] == true || json['isLiked'] == 'true',
      isPassed: json['isPassed'] == true || json['isPassed'] == 'true',
      isSuperLiked:
          json['isSuperLiked'] == true || json['isSuperLiked'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'isVerified': isVerified,
      'profileImage': profileImage,
      'postImages': postImages,
      'distanceText': distanceText,
      'distanceInMiles': distanceInMiles,
      'personalityTags': personalityTags,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'trustScore': trustScore,
      'trustScoreLabel': trustScoreLabel,
      'trustShieldLabel': trustShieldLabel,
      'bio': bio,
      'height': height,
      'weight': weight,
      'smoking': smoking,
      'drinking': drinking,
      'identify': identify,
      'haveKids': haveKids,
      'zodiac': zodiac,
      'workout': workout,
      'interests': interests.map((e) => e.toJson()).toList(),
      'lookingFor': lookingFor,
      'relationshipGoal': relationshipGoal,
      'occupation': occupation,
      'workplace': workplace,
      'education': education,
      'graduationYear': graduationYear,
      'languages': languages,
      'location': location,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'isLiked': isLiked,
      'isPassed': isPassed,
      'isSuperLiked': isSuperLiked,
    };
  }

  DiscoverUserModel copyWith({
    String? id,
    String? name,
    int? age,
    bool? isVerified,
    String? profileImage,
    List<String>? postImages,
    String? distanceText,
    int? distanceInMiles,
    List<String>? personalityTags,
    bool? isOnline,
    String? lastSeen,
    double? trustScore,
    String? trustScoreLabel,
    String? trustShieldLabel,
    String? bio,
    String? height,
    String? weight,
    String? smoking,
    String? drinking,
    String? identify,
    String? haveKids,
    String? zodiac,
    String? workout,
    List<InterestModel>? interests,
    String? lookingFor,
    String? relationshipGoal,
    String? occupation,
    String? workplace,
    String? education,
    String? graduationYear,
    List<String>? languages,
    String? location,
    String? city,
    String? state,
    String? country,
    double? latitude,
    double? longitude,
    bool? isLiked,
    bool? isPassed,
    bool? isSuperLiked,
  }) {
    return DiscoverUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      isVerified: isVerified ?? this.isVerified,
      profileImage: profileImage ?? this.profileImage,
      postImages: postImages ?? this.postImages,
      distanceText: distanceText ?? this.distanceText,
      distanceInMiles: distanceInMiles ?? this.distanceInMiles,
      personalityTags: personalityTags ?? this.personalityTags,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      trustScore: trustScore ?? this.trustScore,
      trustScoreLabel: trustScoreLabel ?? this.trustScoreLabel,
      trustShieldLabel: trustShieldLabel ?? this.trustShieldLabel,
      bio: bio ?? this.bio,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      smoking: smoking ?? this.smoking,
      drinking: drinking ?? this.drinking,
      identify: identify ?? this.identify,
      haveKids: haveKids ?? this.haveKids,
      zodiac: zodiac ?? this.zodiac,
      workout: workout ?? this.workout,
      interests: interests ?? this.interests,
      lookingFor: lookingFor ?? this.lookingFor,
      relationshipGoal: relationshipGoal ?? this.relationshipGoal,
      occupation: occupation ?? this.occupation,
      workplace: workplace ?? this.workplace,
      education: education ?? this.education,
      graduationYear: graduationYear ?? this.graduationYear,
      languages: languages ?? this.languages,
      location: location ?? this.location,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isLiked: isLiked ?? this.isLiked,
      isPassed: isPassed ?? this.isPassed,
      isSuperLiked: isSuperLiked ?? this.isSuperLiked,
    );
  }
}
