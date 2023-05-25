import 'package:capstone_project/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool passwordVisibility = false;
  late SharedPreferences loginData;

  void setPasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  void login(LoginModel inputCredential) async {
    loginData = await SharedPreferences.getInstance();
    notifyListeners();
  }
}
