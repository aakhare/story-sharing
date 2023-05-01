import 'dart:convert';

class Interview {
  final String interviewId;
  final String profileId;
  final String format;
  final String title;
  final String date;
  final String status;

  Interview(
      {required this.interviewId,
      required this.profileId,
      required this.format,
      required this.title,
      required this.date,
      required this.status});
}

class InterviewIdData {
  final String interviewId;
  final String profileId;

  InterviewIdData({required this.interviewId, required this.profileId});
}

class InterviewDetails {
  final Profile profile;
  final InterviewStuff interviewStuff;

  InterviewDetails({required this.profile, required this.interviewStuff});
}

class Profile {
  final String profileId;
  final String contactInfo;
  final String name;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        profileId: json['profile_id'],
        contactInfo: json['contact_info'],
        name: json["name"]);
  }

  Profile(
      {required this.profileId, required this.contactInfo, required this.name});
}

class InterviewStuff {
  final String title;
  final String content;
  final String description;
  final String date;
  final String status;
  final String format;
  final bool isAnonymous;
  final bool flagged;

  factory InterviewStuff.fromJson(Map<String, dynamic> json) {
    return InterviewStuff(
        title: json['interview_title'] ?? '',
        content: json['interview_content'] ?? '',
        description: json['interview_description'] ?? '',
        date: json['interview_date'] ?? '',
        status: json['interview_status'] ?? '',
        format: json['interview_format'] ?? '',
        isAnonymous: json['is_anonymous'] ?? '',
        flagged: json['flagged'] ?? '');
  }

  InterviewStuff(
      {required this.title,
      required this.content,
      required this.description,
      required this.date,
      required this.status,
      required this.format,
      required this.isAnonymous,
      required this.flagged});
}

class IdInfo {
  final String interviewId;
  final String profileId;

  Map<String, dynamic> toMap() {
    return {'profile_id': profileId, 'interview_id': interviewId};
  }

  factory IdInfo.fromMap(Map<String, dynamic> map) {
    return IdInfo(
        interviewId: map['interview_id'] ?? '',
        profileId: map['profile_id'] ?? '');
  }

  IdInfo({required this.interviewId, required this.profileId});
  String toJson() => json.encode(toMap());
  factory IdInfo.fromJson(String source) => IdInfo.fromMap(json.decode(source));
}

