import 'package:capstone_project/model/service/user_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordViewModel with ChangeNotifier {
  bool _currentPasswordVisibility = false;
  bool _newPasswordVisibility = false;
  MyState _state = MyState.initial;
  late SharedPreferences _loginData;
  final UserService _userService = UserService();

  bool get currentPasswordVisibility => _currentPasswordVisibility;
  bool get newPasswordVisibility => _newPasswordVisibility;
  MyState get state => _state;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void setCurrentPasswordVisibility() {
    _currentPasswordVisibility = !_currentPasswordVisibility;
    notifyListeners();
  }

  void setNewPasswordVisibility() {
    _newPasswordVisibility = !_newPasswordVisibility;
    notifyListeners();
  }

  void changePassword(String currentPassword, String newPassword) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _userService.changePassword(
        token: token,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }
}
