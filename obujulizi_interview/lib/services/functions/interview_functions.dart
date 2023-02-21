import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_interview/services/all.dart';
import 'package:obujulizi_interview/utils/all.dart';
import 'package:obujulizi_interview/widgets/all.dart';
import 'dart:async';

class InterviewCreation {
  String signatureKey = 'key';
  String contentKey = 'key';
  String format = 'format';

  void uploadFiles({
    required BuildContext context,
    required String profileId,
    required String interviewContentType,
    required String interviewFile,
    required String digitalSignatureFile,
  }) async {
    try {
      InterviewContent interviewContent = InterviewContent(
          profileId: profileId,
          interviewContentType: interviewContentType,
          interviewFile: interviewFile,
          digitalSignatureFile: digitalSignatureFile);

      if (interviewContentType == 'video') {
        format = 'mp4';
      } else if (interviewContentType == 'audio') {
        format = 'mp3';
      } else {
        format = 'txt';
      }

      http.Response res = await http.post(
          Uri.parse('${EndPoints.s3bucket}/$format'),
          body: interviewContent.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showMessageSnackBar(context, 'Content uploaded');
            InterviewUrl interviewUrl =
                InterviewUrl.fromJson(jsonDecode(res.body));
            createData(context, interviewUrl);
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void createData(BuildContext context, InterviewUrl interviewUrl) {
    String signatureUrl = interviewUrl.digitalSignatureSignedURL;
    String contentUrl = interviewUrl.interviewSignedURL;
    signatureKey = interviewUrl.digitalSignatureFileKey;
    contentKey = interviewUrl.interviewFileKey;
    uploadMedia(context, signatureUrl, 'Digital signature uploaded');
    uploadMedia(context, contentUrl, 'Content uploaded');
  }

  void uploadMedia(BuildContext context, String url, String message) async {
    final resOne = await http.put(Uri.parse(url));
    httpErrorHandle(
        response: resOne,
        context: context,
        onSuccess: () {
          showMessageSnackBar(context, message);
        });
  }

  void createInterview({
    required BuildContext context,
    required String profileId,
    required String format,
    required String title,
    required String description,
    required bool isAnonymous,
  }) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res =
          await http.post(Uri.parse('${EndPoints.url}/interviews'),
              body: jsonEncode({
                'profile_id': profileId,
                'digital_signature': signatureKey,
                'format': format,
                'title': title,
                'content': contentKey,
                'description': description,
                'is_anonymous': isAnonymous
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF8',
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

  Future<List<InterviewTile>> getAllInterviews({required BuildContext context}) async {
    try {
      http.Response res =
          await http.get(Uri.parse('${EndPoints.url}/getallinterviews'));
      httpErrorHandle(response: res, context: context, onSuccess: () {});
      List mapInterviews = jsonDecode(res.body);
      List<InterviewTile> allInterviews =
          mapInterviews.map((interviewTile) => InterviewTile.fromJson(interviewTile)).toList();
      return allInterviews;
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }
}
