import 'dart:convert';

class Profile {
  final String profileId;
  final String contactInfo;
  final String name;

  Profile({required this.profileId, required this.contactInfo, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'user_id': profileId,
      'contact_info': contactInfo,
      'name': name,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      profileId: map['profile_id'] ?? '',
      contactInfo: map['contact_info'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}