import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:flutter_nodejs_app/models/request/auth/login_model.dart';
import 'package:flutter_nodejs_app/services/helpers/auth_helper.dart';
import 'package:flutter_nodejs_app/views/ui/auth/update_user.dart';
import 'package:flutter_nodejs_app/views/ui/mainscreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entryPoint;

  bool get entryPoint => _entryPoint ?? false;

  set entryPoint(bool newState) {
    _entryPoint = newState;
    notifyListeners();
  }

  bool? _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn ?? false;

  set isLoggedIn(bool newState) {
    _isLoggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entryPoint = prefs.getBool('entrypoint') ?? false;
    isLoggedIn = prefs.getBool('loggedIn') ?? false;
  }

  //final loginFormKey = GlobalKey<FormState>();

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool validateAndSave(GlobalKey<FormState> loginFormKey) {
    final form = loginFormKey.currentState;
    print(form);
    if (form != null && form.validate()) {
      form.save();
      return true;
    } else {
      return true;
    }
  }

  userLogin(LoginModel model) {
    AuthHelper.login(model).then((value) {
      print(value);
      if (value && firstTime) {
        Get.off(() => const PersonalDetails());
      } else if (value && !firstTime) {
        Get.off(() => const MainScreen());
      } else if (!value) {
        Get.snackbar(
          'Sign In Failed',
          'Please check your credentials and internet',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  loginOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool("loggedIn", false);
    _firstTime = false;
  }
}
