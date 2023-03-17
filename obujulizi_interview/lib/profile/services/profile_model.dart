class Profile {
  final String profileId;
  final String contactInfo;
  final String name;

  Profile(
      {required this.profileId, required this.contactInfo, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_id': profileId,
      'contact_info': contactInfo,
    };
  }
}
