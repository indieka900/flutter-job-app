import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/models/request/auth/signup_model.dart';
import 'package:flutter_nodejs_app/services/helpers/auth_helper.dart';
import 'package:flutter_nodejs_app/views/ui/auth/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/common/exports.dart';

class SignUpNotifier extends ChangeNotifier {
// trigger to hide and unhide the password
  bool _isObsecure = true;

  bool get isObsecure => _isObsecure;

  set isObsecure(bool obsecure) {
    _isObsecure = obsecure;
    notifyListeners();
  }

// triggered when the login button is clicked to show the loading widget
  bool _processing = false;

  bool get processing => _processing;

  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

// triggered when the fist time when user login to be prompted to the update profile page
  bool _firstTime = false;

  bool get firstTime => _firstTime;

  set firstTime(bool newValue) {
    _firstTime = newValue;
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
    loading = prefs.getBool('loading') ?? false;
  }

  final signupFormKey = GlobalKey<FormState>();

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signUP(SignupModel model) {
    AuthHelper.signUp(model).then((value) {
      if (value) {
        Get.offAll(
          () => const LoginPage(),
          transition: Transition.fade,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Sign Up Failed',
          'Please check your credentials and internet',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
