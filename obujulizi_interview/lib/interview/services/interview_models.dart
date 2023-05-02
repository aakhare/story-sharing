import 'dart:convert';

class ContentInfo {
  final String profileId;
  final String interviewContentType;
  final String interviewFileFormat;
  final String digitalSignatureFileFormat;

  ContentInfo(
      {required this.profileId,
      required this.interviewContentType,
      required this.interviewFileFormat,
      required this.digitalSignatureFileFormat});
  Map<String, dynamic> toMap() {
    return {
      'profile_id': profileId,
      'interviewContent_type': interviewContentType,
      'interviewFile_format': interviewFileFormat,
      'digitalSignatureFile_format': digitalSignatureFileFormat,
    };
  }

  factory ContentInfo.fromMap(Map<String, dynamic> map) {
    return ContentInfo(
      profileId: map['profile_id'] ?? '',
      interviewContentType: map['interviewContent_type'] ?? '',
      interviewFileFormat: map['interviewFile_format'] ?? '',
      digitalSignatureFileFormat: map['digitalSignatureFile_format'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory ContentInfo.fromJson(String source) =>
      ContentInfo.fromMap(json.decode(source));
}

class UploadInfo {
  final String interviewSignedURL;
  final String digitalSignatureSignedURL;
  final String interviewFileKey;
  final String digitalSignatureFileKey;

  UploadInfo({
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

  factory UploadInfo.fromMap(Map<String, dynamic> map) {
    return UploadInfo(
      interviewSignedURL: map['interviewSignedURL'] ?? '',
      digitalSignatureSignedURL: map['digitalSignatureSignedURL'] ?? '',
      interviewFileKey: map['interviewFileKey'] ?? '',
      digitalSignatureFileKey: map['digitalSignatureFileKey'] ?? '',
    );
  }
}

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

  Interview(
      {required this.interviewId,
      required this.profileId,
      required this.digitalSignature,
      required this.format,
      required this.title,
      required this.description,
      required this.content,
      required this.date,
      required this.status,
      required this.flagged,
      required this.isAnonymous});
}

class InfoRow {
  final String title;
  final String format;
  final String date;

  InfoRow({
    required this.title,
    required this.format,
    required this.date,
  });
}

class FormatData {
  final String profileId;
  final String format;
  final String extension;

  FormatData(
      {required this.profileId, required this.format, required this.extension});
}
