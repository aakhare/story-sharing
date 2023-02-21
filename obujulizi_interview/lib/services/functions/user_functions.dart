import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_interview/pages/core/home_page.dart';
import 'package:obujulizi_interview/services/all.dart';
import 'package:obujulizi_interview/utils/all.dart';
import 'package:obujulizi_interview/widgets/all.dart';

class UserAuthentication {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      User user = User(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      http.Response res = await http.post(Uri.parse('${EndPoints.url}/users'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showActionSnackBar(
                context,
                'Account created!',
                SnackBarAction(
                    label: "Login",
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    }));
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(Uri.parse('${EndPoints.url}/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void updateUserPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${EndPoints.url}/updatepassword'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showActionSnackBar(
                context,
                'Password updated!',
                SnackBarAction(
                    label: "Login",
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    }));
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }
}
