import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/auth/all.dart';
import 'package:obujulizi_interview_final/core/all.dart';
import 'package:obujulizi_interview_final/interview/all.dart';
import 'package:obujulizi_interview_final/profile/all.dart';
import 'package:obujulizi_interview_final/utils/error_handling/redirection.dart';
import 'route_names.dart';

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
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpPage());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordPage());
      case RoutesName.appTerms:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AppTermsPage());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RoutesName.addProfile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddProfilePage());
      case RoutesName.viewProfile:
        if (args is Profile) {
          Profile profile = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => ViewInterviewsPage(
                  profileId: profile.profileId,
                  contactInfo: profile.contactInfo,
                  name: profile.name));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.questionsGuide:
        if (args is String) {
          String profileId = args;
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  QuestionsGuidePage(profileId: profileId));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.interviewText:
        if (args is FormatData) {
          FormatData formatData = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => InterviewText(
                  profileId: formatData.profileId,
                  format: formatData.format,
                  extension: formatData.extension));
        }
         return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.createInterview:
        if (args is FormatData) {
          FormatData formatData = args;
          return MaterialPageRoute(
              builder: (BuildContext context) => CreateInterviewPage(
                  profileId: formatData.profileId,
                  format: formatData.format,
                  extension: formatData.extension));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
    }
  }
}
