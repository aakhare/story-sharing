import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/pages/all.dart';
import 'package:obujulizi_interview_final/services/models/profile_model.dart';
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
      case RoutesName.updateAccount:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UpdateAccountPage());
      case RoutesName.addProfile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddProfilePage());
      case RoutesName.updateProfile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UpdateProfilePage());
      case RoutesName.viewProfile:
        if (args is Profile) {
          return MaterialPageRoute(
              builder: (BuildContext context) => const ViewProfilePage());
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.questionsGuide:
        if (args is String) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  QuestionsGuidePage(profileId: args));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.createTextInterview:
        if (args is String) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  CreateTextInterviewPage(profileId: args));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.createAudioInterview:
        if (args is String) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  CreateAudioInterviewPage(profileId: args));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.createVideoInterview:
        if (args is String) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  CreateVideoInterviewPage(profileId: args));
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
    }
  }
}
