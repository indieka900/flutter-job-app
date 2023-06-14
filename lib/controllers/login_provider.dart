import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:flutter_nodejs_app/models/request/auth/login_model.dart';
import 'package:flutter_nodejs_app/services/helpers/auth_helper.dart';
import 'package:flutter_nodejs_app/views/ui/auth/update_user.dart';
import 'package:flutter_nodejs_app/views/ui/mainscreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/auth/profile_update_model.dart';

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

  bool? _loading;

  bool get loading => _loading ?? false;

  set loading(bool newState) {
    _loading = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entryPoint = prefs.getBool('entrypoint') ?? false;
    isLoggedIn = prefs.getBool('loggedIn') ?? false;
    loading = prefs.getBool('loading') ?? false;
  }

  final loginFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  // bool validateAndSave() {
  //   final form = loginFormKey.currentState;
  //   if (form != null && form.validate()) {
  //     form.save();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // bool profileValidation() {
  //   final form = updateFormKey.currentState;
  //   if (form != null && form.validate()) {
  //     form.save();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  userLogin(LoginModel model) {
    AuthHelper.login(model).then((value) {
      if (value && firstTime) {
        Get.offAll(() => const PersonalDetails());
      } else if (value && !firstTime) {
        Get.offAll(() => const MainScreen());
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

  updateProfile(ProfileUpdateReq model) {
    AuthHelper.update(model).then(
      (response) {
        if (response) {
          Get.snackbar(
            'Profile Update',
            'Updated Succesfully enjoy your job search',
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.add_alert),
          );
          Future.delayed(const Duration(seconds: 3)).then((value) {
            Get.offAll(() => const MainScreen());
          });
        } else {
          Get.snackbar(
            'Update Failed',
            'Please check your credentials and internet',
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert),
          );
        }
      },
    );
  }

  loginOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
    await prefs.setBool("loggedIn", false);
    _firstTime = false;
  }
}
