import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_stories/utils/all.dart';
import 'package:obujulizi_stories/widgets/alerts/snack_bar.dart';

class UserAuthentication {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('${EndPoints.url}/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () async {
              Navigator.pushNamed(context, RoutesName.allStories);
            });
      }
    } catch (e) {
      log(e.toString());
      showMessageSnackBar(context, e.toString());
    }
  }
}
