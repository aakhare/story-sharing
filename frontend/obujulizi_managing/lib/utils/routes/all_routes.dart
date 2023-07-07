import 'package:flutter/material.dart';
import 'package:obujulizi_managing/auth/pages/login.dart';
import 'package:obujulizi_managing/stories/pages/create_story.dart';
import 'package:obujulizi_managing/interviews/pages/home.dart';
import 'package:obujulizi_managing/interviews/pages/view_details.dart';
import 'package:obujulizi_managing/stories/pages/view_draft.dart';
import 'package:obujulizi_managing/interviews/services/interview_model.dart';
import 'package:obujulizi_managing/stories/services/draft_model.dart';
import 'package:obujulizi_managing/utils/error_handling/redirection.dart';
import 'route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RoutesName.viewInterviewDetails:
        if (args is IdInfo) {
          IdInfo interview = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => ViewInterviewDetailsPage(
                  profileId: interview.profileId,
                  interviewId: interview.interviewId));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.viewDraft:
        if (args is Draft) {
          Draft draft = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => ViewDraft(
                    storyCaption: draft.caption,
                    storyContent: draft.content,
                    storyId: draft.draftId,
                    storyStatus: draft.status,
                    storyTitle: draft.title,
                    tags: draft.tags,
                    interviewId: draft.interviewId,
                    profileId: draft.profileId,
                  ));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.createStory:
        if (args is IdInfo) {
          IdInfo interview = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => CreateStory(
                  profileId: interview.profileId,
                  interviewId: interview.interviewId));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
    }
  }
}
