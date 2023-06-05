import 'package:capstone_project/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool _passwordVisibility = false;
  late SharedPreferences _loginData;

  bool get passwordVisibility => _passwordVisibility;

  void setPasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void login(LoginModel inputCredential) async {
    _loginData = await SharedPreferences.getInstance();
    if (inputCredential.username == 'user' &&
        inputCredential.password == 'user') {
      _loginData.setString('token', 'token');
    } else {
      _loginData.setString('token', '');
    }
    notifyListeners();
  }
}
