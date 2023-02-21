import 'dart:convert';

class InterviewUrl {
  final String interviewSignedURL;
  final String digitalSignatureSignedURL;
  final String interviewFileKey;
  final String digitalSignatureFileKey;

  InterviewUrl({
    required this.interviewSignedURL,
    required this.digitalSignatureSignedURL,
    required this.interviewFileKey,
    required this.digitalSignatureFileKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'interviewSignedURL': interviewSignedURL,
      'digitalSignatureSignedURL': digitalSignatureSignedURL,
      'interviewFileKey': interviewFileKey,
      'digitalSignatureFileKey': digitalSignatureFileKey,
    };
  }

  factory InterviewUrl.fromMap(Map<String, dynamic> map) {
    return InterviewUrl(
      interviewSignedURL: map['interviewSignedURL'] ?? '',
      digitalSignatureSignedURL: map['digitalSignatureSignedURL'] ?? '',
      interviewFileKey: map['interviewFileKey'] ?? '',
      digitalSignatureFileKey: map['digitalSignatureFileKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory InterviewUrl.fromJson(String source) =>
      InterviewUrl.fromMap(json.decode(source));
}
