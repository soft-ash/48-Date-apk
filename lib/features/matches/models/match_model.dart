enum MatchStatus {
  active,
  expiringSoon,
  dateSet,
  dateComplete,
  cancelled;

  String toJson() => name;

  static MatchStatus fromJson(String value) {
    return MatchStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MatchStatus.active,
    );
  }
}

class DateDetailsModel {
  final String whereName;
  final String whenTime;
  final String gettingThere;
  final String matchPartnerHandle;
  final String matchPartnerAvatar;

  const DateDetailsModel({
    required this.whereName,
    required this.whenTime,
    required this.gettingThere,
    required this.matchPartnerHandle,
    required this.matchPartnerAvatar,
  });

  factory DateDetailsModel.fromJson(Map<String, dynamic> json) {
    return DateDetailsModel(
      whereName: json['whereName'] as String? ?? '',
      whenTime: json['whenTime'] as String? ?? '',
      gettingThere: json['gettingThere'] as String? ?? '',
      matchPartnerHandle: json['matchPartnerHandle'] as String? ?? '',
      matchPartnerAvatar: json['matchPartnerAvatar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'whereName': whereName,
      'whenTime': whenTime,
      'gettingThere': gettingThere,
      'matchPartnerHandle': matchPartnerHandle,
      'matchPartnerAvatar': matchPartnerAvatar,
    };
  }

  DateDetailsModel copyWith({
    String? whereName,
    String? whenTime,
    String? gettingThere,
    String? matchPartnerHandle,
    String? matchPartnerAvatar,
  }) {
    return DateDetailsModel(
      whereName: whereName ?? this.whereName,
      whenTime: whenTime ?? this.whenTime,
      gettingThere: gettingThere ?? this.gettingThere,
      matchPartnerHandle: matchPartnerHandle ?? this.matchPartnerHandle,
      matchPartnerAvatar: matchPartnerAvatar ?? this.matchPartnerAvatar,
    );
  }
}

class MatchModel {
  final String id;
  final String name;
  final int age;
  final String profileImage;
  final String lastMessage;
  final MatchStatus status;
  final String remainingTimeText;
  final String? warningText;
  final DateDetailsModel? dateDetails;
  final bool isOnline;
  final double trustScore;
  final String bio;

  const MatchModel({
    required this.id,
    required this.name,
    required this.age,
    required this.profileImage,
    required this.lastMessage,
    required this.status,
    required this.remainingTimeText,
    this.warningText,
    this.dateDetails,
    this.isOnline = false,
    this.trustScore = 9.5,
    this.bio = '',
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      age: json['age'] as int? ?? 25,
      profileImage: json['profileImage'] as String? ?? '',
      lastMessage: json['lastMessage'] as String? ?? '',
      status: MatchStatus.fromJson(json['status'] as String? ?? 'active'),
      remainingTimeText: json['remainingTimeText'] as String? ?? '',
      warningText: json['warningText'] as String?,
      dateDetails: json['dateDetails'] != null
          ? DateDetailsModel.fromJson(json['dateDetails'] as Map<String, dynamic>)
          : null,
      isOnline: json['isOnline'] as bool? ?? false,
      trustScore: (json['trustScore'] as num?)?.toDouble() ?? 9.5,
      bio: json['bio'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'profileImage': profileImage,
      'lastMessage': lastMessage,
      'status': status.toJson(),
      'remainingTimeText': remainingTimeText,
      'warningText': warningText,
      'dateDetails': dateDetails?.toJson(),
      'isOnline': isOnline,
      'trustScore': trustScore,
      'bio': bio,
    };
  }

  MatchModel copyWith({
    String? id,
    String? name,
    int? age,
    String? profileImage,
    String? lastMessage,
    MatchStatus? status,
    String? remainingTimeText,
    String? warningText,
    DateDetailsModel? dateDetails,
    bool? isOnline,
    double? trustScore,
    String? bio,
  }) {
    return MatchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      profileImage: profileImage ?? this.profileImage,
      lastMessage: lastMessage ?? this.lastMessage,
      status: status ?? this.status,
      remainingTimeText: remainingTimeText ?? this.remainingTimeText,
      warningText: warningText ?? this.warningText,
      dateDetails: dateDetails ?? this.dateDetails,
      isOnline: isOnline ?? this.isOnline,
      trustScore: trustScore ?? this.trustScore,
      bio: bio ?? this.bio,
    );
  }
}
