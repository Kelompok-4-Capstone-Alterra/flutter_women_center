import 'package:capstone_project/model/service/user_service.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel with ChangeNotifier {
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final UserService _userService = UserService();
  String _username = 'user';

  MyState get state => _state;
  String get message => _message;
  String get username => _username;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void initUser() async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isNotEmpty) {
        final UserModel data = await _userService.getProfile(token);
        _username = data.username ?? 'user';
      } else {
        _username = 'user';
      }
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }
}
