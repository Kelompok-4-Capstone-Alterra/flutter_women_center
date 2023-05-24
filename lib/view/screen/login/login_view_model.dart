import 'package:capstone_project/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool passwordVisibility = false;
  bool rememberMe = false;
  LoginModel rememberMeData = LoginModel(username: '', password: '');
  late SharedPreferences loginData;

  void setPasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  void setRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void loadRememberMe() async {
    loginData = await SharedPreferences.getInstance();
    rememberMe = loginData.getBool('rememberMe') ?? false;
    final username = loginData.getString('username') ?? '';
    final password = loginData.getString('password') ?? '';
    rememberMeData = LoginModel(username: username, password: password);
    notifyListeners();
  }

  void login(LoginModel inputCredential) async {
    loginData = await SharedPreferences.getInstance();
    loginData.setBool('rememberMe', rememberMe);
    if (rememberMe) {
      loginData.setString('username', inputCredential.username);
      loginData.setString('password', inputCredential.password);
    } else {
      loginData.remove('username');
      loginData.remove('password');
    }
    notifyListeners();
  }
}
