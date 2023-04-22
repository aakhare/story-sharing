import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';
import 'package:obujulizi_interview_final/interview/all.dart';

class InterviewCreation {
  Future<UploadInfo> getUrlsAndKeys({
    required BuildContext context,
    required String profileId,
    required String interviewContentType,
    required String interviewFileFormat,
    required String digitalSignatureFileFormat,
  }) async {
    try {
      bool success = false;
      ContentInfo contentInfo = ContentInfo(
          profileId: profileId,
          interviewContentType: interviewContentType,
          interviewFileFormat: interviewFileFormat,
          digitalSignatureFileFormat: digitalSignatureFileFormat);
      http.Response res = await http
          .post(Uri.parse('${EndPoints.s3bucket}/$interviewContentType'),
              body: contentInfo.toJson(),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              success = true;
            });
      }
      if (success) {
        UploadInfo localInfo = UploadInfo.fromMap(jsonDecode(res.body));
        return localInfo;
      }
      throw Exception('Unable to connect to server');
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }

  void uploadDigitalSignature(
      {required BuildContext context,
      required XFile? signatureFile,
      required String uploadUrl}) async {
    try {
      http.Response res = await http.put(Uri.parse(uploadUrl),
          body: await signatureFile?.readAsBytes(),
          headers: {"Content-Type": "audio/wav; charset=UTF-64"});
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
            });
      }
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }

  void uploadTextFile(
      {required BuildContext context,
      required File? textFile,
      required String uploadUrl}) async {
    try {
      http.Response res = await http.put(Uri.parse(uploadUrl),
          body: await textFile?.readAsBytes(),
          headers: {'Content-Type': 'text/txt'});
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
            });
      }
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }

  void uploadAudioFile(
      {required BuildContext context,
      required File? audioFile,
      required String uploadUrl}) async {
    try {
      http.Response res = await http.put(Uri.parse(uploadUrl),
          body: await audioFile?.readAsBytes(),
          headers: {'Content-Type': 'audio/m4a'});

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
            });
      }
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }

  void uploadVideoFile(
      {required BuildContext context,
      required XFile? videoFile,
      required String uploadUrl}) async {
    try {
      http.Response res = await http.put(Uri.parse(uploadUrl),
          body: await videoFile?.readAsBytes(),
          headers: {'Content-Type': 'video/mp4'});

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
            });
      }
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }

  void createInterview({
    required BuildContext context,
    required String profileId,
    required String format,
    required String title,
    required String description,
    required String? signatureKey,
    required String? contentKey,
    required bool isAnonymous,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse('${EndPoints.url}/interviews'),
              body: jsonEncode({
                'profile_id': profileId,
                'digital_signature': signatureKey,
                'interview_format': format,
                'interview_title': title,
                'interview_content': contentKey,
                'interview_description': description,
                'is_anonymous': isAnonymous
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              Navigator.pushNamed(context, RoutesName.home);
            });
      }
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  static Future<List<InfoRow>> getAllInterviews(
      {required BuildContext context, required String profileId}) async {
    try {
      List<InfoRow> interviews = [];
      http.Response res = await http.post(
          Uri.parse(
              'https://2jlh65iaqhaadnumtxsdjtahcq0yhjoi.lambda-url.us-west-1.on.aws/'),
          body: jsonEncode({
            'profile_id': profileId,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
      var mapInterviews = jsonDecode(res.body);
      for (var item in mapInterviews) {
        InfoRow interviewData = InfoRow(
            title: item['interview_title'],
            format: item['interview_format'],
            date: item['interview_date']);
        interviews.add(interviewData);
      }
      return interviews;
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }
}
