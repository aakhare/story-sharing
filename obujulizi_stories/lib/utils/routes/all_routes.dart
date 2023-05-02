import 'package:flutter/material.dart';
import 'package:obujulizi_stories/auth/pages/login.dart';
import 'package:obujulizi_stories/auth/pages/splash.dart';
import 'package:obujulizi_stories/stories/pages/all_stories.dart';
import 'package:obujulizi_stories/stories/pages/view_story.dart';
import 'package:obujulizi_stories/stories/services/story_model.dart';
import 'package:obujulizi_stories/utils/error_handling/redirection.dart';
import 'package:obujulizi_stories/utils/routes/route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashPage());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      case RoutesName.allStories:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AllStories());
      case RoutesName.storyDetails:
        if (args is Story) {
          Story story = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => ViewStory(
                    storyId: story.storyId,
                    tags: story.tags,
                    caption: story.caption,
                    content: story.content,
                    status: story.status,
                    title: story.title,
                  ));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
    }
  }
}
