
import 'package:http/http.dart';
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

  static Future<List<Story>> getAllStories(
      {required BuildContext context}) async {
    try {
      List<Story> stories = [];
      http.Response res = await http.get(
        Uri.parse(
            'https://r3gf3sqwyq3um7s3lxg54w3woi0tdhgp.lambda-url.us-west-1.on.aws/'),
      );
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      var mapStories = jsonDecode(res.body);
      for (var item in mapStories) {
        Story storyData = Story(
            id: item["story_id"],
            title: item["story_title"],
            content: item["story_content"],
            caption: item["story_caption"],
            status: item["story_status"],
            tags: item["tags"]);
        stories.add(storyData);
      }
      return stories;
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
      rethrow;
    }
  }

  static Future<List<Draft>> getAllDrafts(
      {required BuildContext context}) async {
    try {
      List<Draft> drafts = [];
      http.Response res = await http.get(
        Uri.parse(
            'https://atofxysuihvyatot44tk5vhtuy0qlmtw.lambda-url.us-west-1.on.aws/'),
      );
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      var mapDrafts = jsonDecode(res.body);
      for (var item in mapDrafts) {
        Draft draftData = Draft(
          id: item["story_id"],
          title: item["story_title"],
          content: item["story_content"],
          caption: item["story_caption"],
          status: item["story_status"],
          tags: item["tags"],
        );
        drafts.add(draftData);
      }
      return drafts;
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
      required bool flag}) async {
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

  void createStory(
      {required BuildContext context,
      required String title,
      required String caption,
      required String tag,
      required String content,
      required String interviewId,
      required String profileId,
      required String status}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://ablaevqomwtjveizp2faflypp40khwop.lambda-url.us-west-1.on.aws/'),
          body: jsonEncode({
            'interview_id': interviewId,
            'profile_id': profileId,
            'story_title': title,
            'story_content': content,
            'story_caption': caption,
            'story_status': status,
            'tags': tag
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res, context: context, onSuccess: () async {});
      }
    } catch (e) {
      const AlertDialog(content: Text(" e.toString()"));
    }
  }


  Future<String> getTextFile({required String key}) async {
    String content = '';
    String url = "https://testbucket63419.s3.us-west-1.amazonaws.com/$key";
    var request = await http.read(Uri.parse(url)).then((String fileContents) {
      print(fileContents.length);
      print(fileContents);
      content = fileContents;
    }).catchError((Error error) {
      print(error.toString());
    });
    return content;
  }

  // Future<void> download({required String url}) async {
  //   var headers = {
  //     'Content-Type': 'audio/m4a',
  //   };

  //   String filename = 'lol';
  //   Response res = await http.get(Uri.parse(url), headers: headers);

  //   if (res.statusCode == 200) {
  //     final blob = html.Blob([res.bodyBytes]);
  //     final url = html.Url.createObjectUrlFromBlob(blob);
  //     final anchor = html.document.createElement('a') as html.AnchorElement
  //       ..href = url
  //       ..style.display = 'none'
  //       ..download = filename;
  //     html.document.body!.children.add(anchor);

  //     anchor.click();

  //     html.document.body!.children.remove(anchor);
  //     html.Url.revokeObjectUrl(url);
  //   }
  // }
}
