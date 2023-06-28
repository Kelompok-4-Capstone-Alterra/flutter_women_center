import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingViewModel with ChangeNotifier {
  bool isLastPage = false;
  late SharedPreferences loginData;

  void setIsLastPage(bool status) {
    isLastPage = status;
    notifyListeners();
  }

  void appStarted() async {
    loginData = await SharedPreferences.getInstance();
    loginData.setBool('first', false);
    notifyListeners();
  }
}
