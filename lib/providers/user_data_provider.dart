import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  late String _username = '';
  late String _bio = '';

  String get username => _username;
  String get bio => _bio;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setBio(String bio) {
    _bio = bio;
    notifyListeners();
  }
}
