import 'package:obujulizi_managing/interviews/services/interview_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_managing/utils/error_handling/http_errors.dart';

class InterviewCreation {
  static Future<List<Interview>> getAllInterviews(
      {required BuildContext context}) async {
    try {
      List<Interview> interviews = [];
      http.Response res = await http.get(
        Uri.parse(
            'https://fkoadnxjimanii62ylbdq6it240wglyd.lambda-url.us-west-1.on.aws/'),
      );
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      var mapInterviews = jsonDecode(res.body);
      for (var item in mapInterviews) {
        Interview interviewData = Interview(
            title: item["interview_title"],
            status: item["interview_status"],
            format: item["interview_format"],
            date: item["interview_date"],
            interviewId: item["interview_id"],
            profileId: item["profile_id"]);
        interviews.add(interviewData);
      }
      return interviews;
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }

  Future<Profile> getProfileDetails(
      {required BuildContext context,
      required String profileId,
      required String interviewId}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/profiles/profile-details'),
          body: jsonEncode(
              {'profile_id': profileId, 'interview_id': interviewId}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      Profile profile = Profile.fromJson(jsonDecode(res.body));
      return profile;
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }

  Future<InterviewStuff> getInterviewDetails(
      {required BuildContext context,
      required String profileId,
      required String interviewId}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/interviews/interview-details'),
          body: jsonEncode(
              {'profile_id': profileId, 'interview_id': interviewId}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }

      InterviewStuff interviewStuff =
          InterviewStuff.fromJson(jsonDecode(res.body));
      return interviewStuff;
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }

  void updateInterviewStatus(
      {required BuildContext context,
      required String interviewId,
      required String status}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/interviews/update-status'),
          body: jsonEncode(
              {'interview_status': status, 'interview_id': interviewId}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }

  void updateInterviewFlag(
      {required BuildContext context,
      required String interviewId,
      required bool? flag}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/interviews/update-flag'),
          body: jsonEncode({'flagged': flag, 'interview_id': interviewId}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }

  Future<String> getTextFile({required String key, required BuildContext context}) async {
    try {
      String content = '';
      String url = "https://testbucket63419.s3.us-west-1.amazonaws.com/$key";
      var res = await http.read(Uri.parse(url)).then((String fileContents) {
        content = fileContents;
      }).catchError((error) {});
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      return content;
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }
}
