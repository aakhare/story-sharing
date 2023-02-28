import 'dart:convert';

class Urls {
  final String interviewSignedURL;
  final String digitalSignatureSignedURL;
  final String interviewFileKey;
  final String digitalSignatureFileKey;

 Urls({
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

  factory Urls.fromMap(Map<String, dynamic> map) {
    return Urls(
      interviewSignedURL: map['interviewSignedURL'] ?? '',
      digitalSignatureSignedURL: map['digitalSignatureSignedURL'] ?? '',
      interviewFileKey: map['interviewFileKey'] ?? '',
      digitalSignatureFileKey: map['digitalSignatureFileKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Urls.fromJson(String source) =>
      Urls.fromMap(json.decode(source));
}
