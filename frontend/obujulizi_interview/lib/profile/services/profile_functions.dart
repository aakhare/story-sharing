import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_interview_final/core/home.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';
import 'profile_model.dart';

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
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            });
      }
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  static Future<List<Profile>> getAllProfiles(
      {required BuildContext context}) async {
    try {
      bool success = false;
      List<Profile> profiles = [];
      http.Response res =
          await http.get(Uri.parse('${EndPoints.url}/getallprofiles'));
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              success = true;
            });
      }
      if (success) {
        var mapProfiles = jsonDecode(jsonDecode(res.body));
        for (var item in mapProfiles) {
          Profile profile = Profile(
              profileId: item['profile_id'],
              contactInfo: item['contact_info'],
              name: item["name"]);
          profiles.add(profile);
        }
        return profiles;
      }
      throw Exception('Unable to get profile data');
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }
}
