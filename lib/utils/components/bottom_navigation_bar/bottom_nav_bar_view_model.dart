import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarViewModel with ChangeNotifier {
  String _token = '';
  late SharedPreferences _loginData;

  String get token => _token;

  void init() async {
    _loginData = await SharedPreferences.getInstance();
    _token = _loginData.getString('token') ?? '';
    notifyListeners();
  }
}
