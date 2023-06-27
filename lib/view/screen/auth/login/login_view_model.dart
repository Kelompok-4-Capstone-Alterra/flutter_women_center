import 'package:capstone_project/model/login_model.dart';
import 'package:capstone_project/service/auth_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool _passwordVisibility = false;
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final _authService = AuthService();

  MyState get state => _state;
  String get message => _message;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void init() async {
    _state = MyState.initial;
  }

  bool get passwordVisibility => _passwordVisibility;

  void setPasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void login(LoginModel inputCredential) async {
    try {
      changeState(MyState.loading);
      final token = await _authService.login(loginData: inputCredential);
      _loginData = await SharedPreferences.getInstance();
      _loginData.setString('token', token);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }
}
