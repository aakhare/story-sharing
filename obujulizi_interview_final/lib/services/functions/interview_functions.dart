import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obujulizi_interview_final/services/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class InterviewCreation {
  String format = 'text';

  void getUrls({
    required BuildContext context,
    required String profileId,
    required String interviewContentType,
    required String interviewFileFormat,
    required String digitalSignatureFileFormat,
  }) async {
    try {
      var interviewInfoProvider =
          Provider.of<InterviewProvider>(context, listen: false);
      InterviewContent interviewContent = InterviewContent(
          profileId: profileId,
          interviewContentType: interviewContentType,
          interviewFileFormat: interviewFileFormat,
          digitalSignatureFileFormat: digitalSignatureFileFormat);

      if (interviewContentType == 'video') {
        format = 'mp4';
      } else if (interviewContentType == 'audio') {
        format = 'mp3';
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
            interviewInfoProvider.setUrls(res.body);
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void uploadDigitalSignature(
      {required BuildContext context, required XFile? signatureFile}) async {
    try {
      var interviewInfoProvider =
          Provider.of<InterviewProvider>(context, listen: false).urls;
      http.Response res = await http.put(
          Uri.parse(interviewInfoProvider.digitalSignatureSignedURL),
          body: signatureFile!.readAsBytes());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showMessageSnackBar(context, 'Digital signature uploaded');
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void uploadTextFile(
      {required BuildContext context, required File? textFile}) async {
    try {
      var interviewInfoProvider =
          Provider.of<InterviewProvider>(context, listen: false).urls;
      http.Response res = await http.put(
          Uri.parse(interviewInfoProvider.interviewSignedURL),
          body: textFile!.readAsBytes());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showMessageSnackBar(context, 'Text file uploaded');
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void uploadAudioFile(
      {required BuildContext context, required File? audioFile}) async {
    try {
      var interviewInfoProvider =
          Provider.of<InterviewProvider>(context, listen: false).urls;
      http.Response res = await http.put(
          Uri.parse(interviewInfoProvider.interviewSignedURL),
          body: audioFile!.readAsBytes());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showMessageSnackBar(context, 'Audio uploaded');
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
  }

  void uploadInterviewFile(
      {required BuildContext context, required XFile? interviewFile}) async {
    try {
      var interviewInfoProvider =
          Provider.of<InterviewProvider>(context, listen: false).urls;
      http.Response res = await http.put(
          Uri.parse(interviewInfoProvider.interviewSignedURL),
          body: interviewFile!.readAsBytes());
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showMessageSnackBar(context, 'Interview uploaded');
          });
    } catch (e) {
      showMessageSnackBar(context, e.toString());
    }
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
      final urls = Provider.of<InterviewProvider>(context).urls;
      final navigator = Navigator.of(context);
      http.Response res =
          await http.post(Uri.parse('${EndPoints.url}/interviews'),
              body: jsonEncode({
                'profile_id': profileId,
                'digital_signature': urls.digitalSignatureFileKey,
                'format': format,
                'title': title,
                'content': urls.interviewFileKey,
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

  static Future<List<InterviewData>> getAllInterviews(
      {required BuildContext context, required String? profileId}) async {
    try {
      http.Response res =
          await http.get(Uri.parse('${EndPoints.url}/interviews'));
      httpErrorHandle(response: res, context: context, onSuccess: () {});
      List mapInterviews = jsonDecode(res.body);
      List<InterviewData> allInterviews = mapInterviews
          .map((interviewTile) => InterviewData.fromJson(interviewTile))
          .toList();
      return allInterviews;
    } catch (e) {
      showMessageSnackBar(context, e.toString());
      rethrow;
    }
  }
}
