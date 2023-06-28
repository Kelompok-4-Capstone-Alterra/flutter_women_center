import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingViewModel with ChangeNotifier {
  late SharedPreferences loginData;
  bool _isFistTime = true;

  bool get isFistTime => _isFistTime;

  void checkFirstTime() async {
    loginData = await SharedPreferences.getInstance();
    _isFistTime = loginData.getBool('first') ?? true;
    notifyListeners();
  }
}
