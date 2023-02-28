import 'dart:convert';

class InterviewContent {
  final String profileId;
  final String interviewContentType;
  final String interviewFileFormat;
  final String digitalSignatureFileFormat;

  InterviewContent({
      required this.profileId,
      required this.interviewContentType,
      required this.interviewFileFormat,
      required this.digitalSignatureFileFormat
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': profileId,
      'interviewContent_type': interviewContentType,
      'interviewFile_format': interviewFileFormat,
      'digitalSignatureFile_format': digitalSignatureFileFormat,
    };
  }

  factory InterviewContent.fromMap(Map<String, dynamic> map) {
    return InterviewContent(
      profileId: map['profile_id'] ?? '',
      interviewContentType: map['interviewContent_type'] ?? '',
      interviewFileFormat: map['interviewFile_format'] ?? '',
      digitalSignatureFileFormat: map['digitalSignatureFile_format'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory InterviewContent.fromJson(String source) =>
      InterviewContent.fromMap(json.decode(source));
}
