import 'dart:async';

import 'package:capstone_project/model/service/auth_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class VerificationViewModel with ChangeNotifier {
  MyState _state = MyState.initial;
  String _pin1 = '';
  String _pin2 = '';
  String _pin3 = '';
  String _pin4 = '';
  String _email = '';
  Duration _duration = const Duration(seconds: 60);
  Timer _timer = Timer.periodic(const Duration(seconds: 1), (_) {});

  Duration get duration => _duration;
  final _authService = AuthService();

  MyState get state => _state;
  String get otp => _pin1 + _pin2 + _pin3 + _pin4;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPin(String pin, int ref) {
    switch (ref) {
      case 1:
        _pin1 = pin;
        break;
      case 2:
        _pin2 = pin;
        break;
      case 3:
        _pin3 = pin;
        break;
      case 4:
        _pin4 = pin;
        break;
    }
    notifyListeners();
  }

  void clearPin() {
    _pin1 = '';
    _pin2 = '';
    _pin3 = '';
    _pin4 = '';
    notifyListeners();
  }

  Future requestOtp() async {
    try {
      changeState(MyState.loading);
      await _authService.verify(_email);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }

  void startTimer() {
    _duration = const Duration(seconds: 60);
    _timer.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_duration == const Duration(seconds: 0)) {
          _timer.cancel();
        } else {
          _duration -= const Duration(seconds: 1);
          notifyListeners();
        }
      },
    );
  }

  void resetTimer() {
    _duration = const Duration(seconds: 60);
    startTimer();
  }

  void stopTimer() {
    _duration = const Duration(seconds: 0);
    _timer.cancel();
  }
}
