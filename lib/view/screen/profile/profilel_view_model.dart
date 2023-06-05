import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel with ChangeNotifier {
  bool _showAboutUs = false;
  bool _showFaq = false;
  bool _showTermAndConditions = false;
  late SharedPreferences _loginData;

  bool get showAboutUs => _showAboutUs;
  bool get showFaq => _showFaq;
  bool get showTermAndConditions => _showTermAndConditions;

  void setShowAboutUs() {
    _showAboutUs = !_showAboutUs;
    notifyListeners();
  }

  void setShowFaq() {
    _showFaq = !_showFaq;
    notifyListeners();
  }

  void setShowTermAndConditions() {
    _showTermAndConditions = !_showTermAndConditions;
    notifyListeners();
  }

  void logout() async {
    _loginData = await SharedPreferences.getInstance();
    _loginData.remove('token');
    notifyListeners();
  }

  void reset() {
    _showAboutUs = false;
    _showFaq = false;
    _showTermAndConditions = false;
  }
}
