import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/services/all.dart';

class InterviewProvider extends ChangeNotifier {
  Urls _urls = Urls(
      interviewSignedURL: '',
      digitalSignatureSignedURL: '',
      interviewFileKey: '',
      digitalSignatureFileKey: '');

  Urls get urls => _urls;

  void setUrls(String urls) {
    _urls = Urls.fromJson(urls);
    notifyListeners();
  }

  void setUserFromModel(Urls urls) {
    _urls = urls;
    notifyListeners();
  }
}
