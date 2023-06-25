import 'package:capstone_project/model/login_model.dart';
import 'package:capstone_project/model/service/auth_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  MyState _state = MyState.initial;
  final AuthService _authService = AuthService();
  String _email = '';

  MyState get state => _state;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void reuestOtp(String email) async {
    changeState(MyState.loading);
    try {
      await _authService.requestOtpForgotPassword(email: email);
      _email = email;
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }

  void requestNewPassword(String opt) async {
    changeState(MyState.loading);
    try {
      await _authService.requestNewPassword(email: _email, otp: opt);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }
}
