import 'package:flutter/material.dart';
import 'package:obujulizi_interview/services/all.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile = Profile(profileId: '', contactInfo: '', name: '');

  Profile get profile => _profile;

  void setProfile(String profile) {
    _profile = Profile.fromJson(profile);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _profile = profile;
    notifyListeners();
  }
}
