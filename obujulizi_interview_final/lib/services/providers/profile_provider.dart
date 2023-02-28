import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/services/models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile = Profile(profileId: '', contactInfo: '', name: '');

  Profile get profile => _profile;

  void setProfile(String profile) {
    _profile = Profile.fromJson(profile);
    notifyListeners();
  }

  void setProfileFromModel(Profile profile) {
    _profile = profile;
    notifyListeners();
  }
}