import 'package:flutter/material.dart';
import 'package:obujulizi_interview/pages/all.dart';
import 'package:obujulizi_interview/services/all.dart';
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
              builder: (BuildContext context) =>
                  ViewProfilePage());
        }
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
      case RoutesName.questionsGuide:
        return MaterialPageRoute(
            builder: (BuildContext context) => const QuestionsGuidePage());
      case RoutesName.createTextInterview:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateTextInterviewPage());
      case RoutesName.createAudioInterview:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const CreateAudioInterviewPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorPage());
    }
  }
}
