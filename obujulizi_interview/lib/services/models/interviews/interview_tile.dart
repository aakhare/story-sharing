import 'dart:convert';

class InterviewTile {
  final String format;
  final String title;
  final String date;

  InterviewTile({
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

  factory InterviewTile.fromMap(Map<String, dynamic> map) {
    return InterviewTile(
      format: map['format'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory InterviewTile.fromJson(String source) =>
      InterviewTile.fromMap(json.decode(source));
}