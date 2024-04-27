import 'package:flutter/material.dart';

class ProfileImageProvider extends ChangeNotifier {
  late String _profileImageUrl = '';

  String get profileImageUrl => _profileImageUrl;

  void setProfileImageUrl(String imageUrl) {
    _profileImageUrl = imageUrl;
    notifyListeners();
  }
}
