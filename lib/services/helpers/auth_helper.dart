import 'dart:convert';

import 'package:flutter_nodejs_app/models/request/auth/login_model.dart';
import 'package:flutter_nodejs_app/services/config.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/auth/login_res_model.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    await prefs.setBool('loading', true);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    await prefs.setBool('loading', false);
    if (response.statusCode == 200) {
      String token = userResponseFromJson(response.body).token;
      String userId = userResponseFromJson(response.body).user.id;
      String profile = userResponseFromJson(response.body).user.profile;
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('profile', profile);
      await prefs.setBool('loggedIn', true);
      return true;
    } else {
      return false;
    }
  }
}
