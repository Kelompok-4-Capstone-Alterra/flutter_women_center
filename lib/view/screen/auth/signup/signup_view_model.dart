import 'package:capstone_project/service/auth_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

import '../../../../model/signup_model.dart';

class SignupViewModel with ChangeNotifier {
  MyState _state = MyState.initial;
  bool _passwordVisibility = false;
  final _authService = AuthService();
  String _signupMessage = '';

  SignupModel _signupData = SignupModel(
    name: '',
    email: '',
    username: '',
    password: '',
    otp: '',
  );

  bool get passwordVisibility => _passwordVisibility;
  SignupModel get signupModel => _signupData;
  MyState get state => _state;
  String get signupMessage => _signupMessage;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void setPasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  Future setData(SignupModel data) async {
    notifyListeners();
    try {
      changeState(MyState.loading);
      await _authService.checkUsernameEmail(
        email: data.email!,
        username: data.username!,
      );
      _signupData = data;
      await _authService.verify(email: data.email!);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }

  void signup(String otp) async {
    try {
      changeState(MyState.loading);
      _signupData.otp = otp;
      _signupMessage = await _authService.register(registerData: _signupData);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }
}
