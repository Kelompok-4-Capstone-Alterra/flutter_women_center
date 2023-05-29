import 'package:capstone_project/model/login_model.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  void sendLink(String email) async {
    print('send link, $email');
    notifyListeners();
  }
}
