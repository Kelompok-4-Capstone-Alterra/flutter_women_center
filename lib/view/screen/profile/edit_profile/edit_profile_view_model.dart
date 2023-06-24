import 'dart:io';

import 'package:capstone_project/model/service/user_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/user_model.dart';
import '../../../../utils/state/finite_state.dart';

class EditProfileViewModel with ChangeNotifier {
  MyState _state = MyState.initial;
  PlatformFile? _imageFile;
  late SharedPreferences _loginData;
  final UserService _userService = UserService();

  MyState get state => _state;
  PlatformFile? get imageFile => _imageFile;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void initImage() async {
    _imageFile = null;
    notifyListeners();
  }

  void setImageFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    _imageFile = result.files.first;
    notifyListeners();
  }

  void updateProfile(UserModel userData) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _userService.updateProfile(token, userData);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }
}
