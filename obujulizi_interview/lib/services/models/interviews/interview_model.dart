import 'dart:convert';

class Interview {
  final String interviewId;
  final String profileId;
  final String digitalSignature;
  final String format;
  final String title;
  final String description;
  final String content;
  final String date;
  final String status;
  final bool flagged;
  final bool isAnonymous;

  Interview({
      required this.interviewId,
      required this.profileId,
      required this.digitalSignature,
      required this.format,
      required this.title,
      required this.description,
      required this.content,
      required this.date,
      required this.status,
      required this.flagged,
      required this.isAnonymous
  });

  Map<String, dynamic> toMap() {
    return {
      'interview_id': interviewId,
      'profile_id': profileId,
      'digital_signature': digitalSignature,
      'format': format,
      'title': title,
      'description': description,
      'content': content,
      'date': date,
      'status': status,
      'flagged': flagged,
      'is_anonymous': isAnonymous,
    };
  }

  factory Interview.fromMap(Map<String, dynamic> map) {
    return Interview(
      interviewId: map['interview_id'] ?? '',
      profileId: map['profile_id'] ?? '',
      digitalSignature: map['digital_signature'] ?? '',
      format: map['format'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
      flagged: map['flagged'] ?? '',
      isAnonymous: map['is_anonymous'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Interview.fromJson(String source) =>
      Interview.fromMap(json.decode(source));
}
