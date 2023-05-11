class Draft {
  final String draftId;
  final String interviewId;
  final String profileId;
  final String title;
  final String content;
  final String caption;
  final String status;
  final String tags;

  Draft(
      {required this.draftId,
      required this.interviewId,
      required this.profileId,
      required this.title,
      required this.content,
      required this.caption,
      required this.status,
      required this.tags});
}

class Story {
  final String storyId;
  final String title;
  final String content;
  final String caption;
  final String status;
  final String tags;

  Story(
      {required this.storyId,
      required this.title,
      required this.content,
      required this.caption,
      required this.status,
      required this.tags});
}
