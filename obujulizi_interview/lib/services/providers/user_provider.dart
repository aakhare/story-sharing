import 'package:flutter/material.dart';
import 'package:obujulizi_interview/services/all.dart';

class UserProvider extends ChangeNotifier {
  User _user =
      User(email: '', password: '', firstName: '', lastName: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
