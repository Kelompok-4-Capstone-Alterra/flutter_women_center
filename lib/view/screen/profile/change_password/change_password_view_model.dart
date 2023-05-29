import 'package:flutter/material.dart';

class ChangePasswordViewModel with ChangeNotifier {
  bool _currentPasswordVisibility = false;
  bool _newPasswordVisibility = false;

  bool get currentPasswordVisibility => _currentPasswordVisibility;
  bool get newPasswordVisibility => _newPasswordVisibility;

  void setCurrentPasswordVisibility() {
    _currentPasswordVisibility = !_currentPasswordVisibility;
    notifyListeners();
  }

  void setNewPasswordVisibility() {
    _newPasswordVisibility = !_newPasswordVisibility;
    notifyListeners();
  }
}
