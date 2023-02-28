import 'dart:convert';

class  InterviewData {
  final String format;
  final String title;
  final String date;

  InterviewData({
      required this.format,
      required this.title,
      required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'format': format,
      'title': title,
      'date': date,
    };
  }

  factory InterviewData.fromMap(Map<String, dynamic> map) {
    return InterviewData(
      format: map['format'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory InterviewData.fromJson(String source) =>
      InterviewData.fromMap(json.decode(source));
}