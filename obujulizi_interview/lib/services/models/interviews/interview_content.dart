import 'dart:convert';

class InterviewContent {
  final String profileId;
  final String interviewContentType;
  final String interviewFile;
  final String digitalSignatureFile;

  InterviewContent({
      required this.profileId,
      required this.interviewContentType,
      required this.interviewFile,
      required this.digitalSignatureFile
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': profileId,
      'interviewContent_type': interviewContentType,
      'interviewFile': interviewFile,
      'digitalSignatureFile': digitalSignatureFile,
    };
  }

  factory InterviewContent.fromMap(Map<String, dynamic> map) {
    return InterviewContent(
      profileId: map['profile_id'] ?? '',
      interviewContentType: map['interviewContent_type'] ?? '',
      interviewFile: map['interviewFile'] ?? '',
      digitalSignatureFile: map['digitalSignatureFile'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory InterviewContent.fromJson(String source) =>
      InterviewContent.fromMap(json.decode(source));
}
