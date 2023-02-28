import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_interview_final/pages/main/home_page.dart';
import 'package:obujulizi_interview_final/services/errors/error_handling.dart';
import 'package:obujulizi_interview_final/services/models/profile_model.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';


class ProfileSetUp {
  void createProfile(
      {required BuildContext context,
      required String contactInfo,
      required String name}) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
          Uri.parse('${EndPoints.url}/profiles'),
          body: jsonEncode({'name': name, 'contact_info': contactInfo}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void updateProfile({
    required BuildContext context,
    required String contactInfo,
    required String name,
  }) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
          Uri.parse('${EndPoints.url}/updateprofile'),
          body: jsonEncode({'name': name, 'contact_info': contactInfo}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            navigator.pop(context);
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  static Future<List<Profile>> getAllProfiles({required BuildContext context}) async {
    try {
      http.Response res =
          await http.get(Uri.parse('${EndPoints.url}/getallprofiles'));
      httpErrorHandle(response: res, context: context, onSuccess: () {});
      List mapProfiles = jsonDecode(res.body);
      List<Profile> allProfiles =
          mapProfiles.map((movie) => Profile.fromJson(movie)).toList();
      return allProfiles;
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }
}