import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class VerificationViewModel with ChangeNotifier {
  MyState _state = MyState.initial;
  String _pin1 = '';
  String _pin2 = '';
  String _pin3 = '';
  String _pin4 = '';

  bool newCode = false;

  MyState get state => _state;

  void requestNewCode() {
    newCode = !newCode;
    notifyListeners();
  }

  void changeState(MyState state) {
    _state = state;
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

  void verify() {
    changeState(MyState.loading);
    if ('$_pin1$_pin2$_pin3$_pin4' == '1234') {
      changeState(MyState.loaded);
    } else {
      changeState(MyState.failed);
    }
    notifyListeners();
  }

  void resendCode() {
    print('Resend');
  }
}
