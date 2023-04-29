import 'package:flutter/material.dart';

class InterviewStateProvider extends ChangeNotifier {
  bool _saved = false;

  bool get saved => _saved;

  void updateSaved(bool saved) {
    _saved = saved;
    notifyListeners();
  }
}
