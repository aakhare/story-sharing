import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_managing/stories/services/draft_model.dart';
import 'package:obujulizi_managing/utils/error_handling/http_errors.dart';
import 'package:obujulizi_managing/utils/routes/route_names.dart';

class DraftFunction {
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
            storyId: item["story_id"],
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
            'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/stories/get-drafts'),
      );
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      var mapDrafts = jsonDecode(jsonDecode(res.body));
      for (var item in mapDrafts) {
        Draft draftData = Draft(
          draftId: item["story_id"],
          interviewId: item["interview_id"],
          profileId: item["profile_id"],
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

  void updateDraft(
      {required BuildContext context,
      required String title,
      required String caption,
      required String tag,
      required String content,
      required String interviewId,
      required String profileId,
      required String draftId,
      required String status}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/stories/update'),
          body: jsonEncode({
            'interview_id': interviewId,
            'profile_id': profileId,
            'story_id': draftId,
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
            response: res,
            context: context,
            onSuccess: () async {
              Navigator.pop(context);
            });
      }
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
    }
  }

  void createStoryFromDraft(
      {required BuildContext context,
      required String title,
      required String caption,
      required String tag,
      required String content,
      required String interviewId,
      required String profileId,
      required String draftId,
      required String status}) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/stories/update'),
          body: jsonEncode({
            'interview_id': interviewId,
            'profile_id': profileId,
            'story_id': draftId,
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
            response: res, context: context, onSuccess: () async {
              Navigator.pop(context);
            });
      }
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
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
              'https://0qwamyy66l.execute-api.us-west-1.amazonaws.com/dev/stories/create'),
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
            response: res,
            context: context,
            onSuccess: () async {
              Navigator.pushNamed(context, RoutesName.home);
            });
      }
    } catch (e) {
      AlertDialog(content: Text(e.toString()));
    }
  }
}
