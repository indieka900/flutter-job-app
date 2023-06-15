import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/services/helpers/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/auth/profile_model.dart';

class ProfileNotifier extends ChangeNotifier {
  String? _profileurl;

  String get profileurl =>
      _profileurl ??
      'https://res.cloudinary.com/diyhlasnt/image/upload/v1686647102/cld-sample.jpg';

  set profileurl(String newState) {
    _profileurl = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    profileurl = prefs.getString('profile') ??
        'https://res.cloudinary.com/diyhlasnt/image/upload/v1686647102/cld-sample.jpg';
    //print(profileurl);
  }

  Future<ProfileRes>? profile;
  getProfile() async {
    profile = AuthHelper.getUser();
  }
}
