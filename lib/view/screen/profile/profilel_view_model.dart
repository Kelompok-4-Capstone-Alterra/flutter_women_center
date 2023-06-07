import 'package:capstone_project/model/service/user_service.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel with ChangeNotifier {
  bool _showAboutUs = false;
  bool _showFaq = false;
  bool _showTermAndConditions = false;
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final UserService _userService = UserService();
  UserModel _userData = UserModel();

  bool get showAboutUs => _showAboutUs;
  bool get showFaq => _showFaq;
  bool get showTermAndConditions => _showTermAndConditions;
  MyState get state => _state;
  String get message => _message;
  UserModel get userData => _userData;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void initProfile() async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        _message = 'Token is empty';
        changeState(MyState.failed);
      }
      _userData = await _userService.getProfile(token);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

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
