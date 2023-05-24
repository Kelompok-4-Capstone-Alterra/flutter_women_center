import 'package:flutter/material.dart';

import '../../../model/signup_model.dart';

class SignupViewModel with ChangeNotifier {
  bool passwordVisibility = false;

  void setPasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  void signup(SignupModel data) {}
}
