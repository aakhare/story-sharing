import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_stories/utils/error_handling/http_errors.dart';
import 'story_model.dart';

class StoryFunctions {
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
}