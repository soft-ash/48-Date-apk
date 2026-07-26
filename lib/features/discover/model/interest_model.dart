class InterestModel {
  final String name;
  final String? icon;

  const InterestModel({required this.name, this.icon});

  factory InterestModel.fromJson(dynamic json) {
    if (json is String) {
      return InterestModel(name: json);
    } else if (json is Map<String, dynamic>) {
      return InterestModel(
        name: json['name']?.toString() ?? '',
        icon: json['icon']?.toString(),
      );
    }
    return const InterestModel(name: '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, if (icon != null) 'icon': icon};
  }

  InterestModel copyWith({String? name, String? icon}) {
    return InterestModel(name: name ?? this.name, icon: icon ?? this.icon);
  }
}
