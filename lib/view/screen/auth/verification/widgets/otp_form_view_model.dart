import 'dart:async';

import 'package:flutter/material.dart';

class OtpFormViewModel with ChangeNotifier {
  Duration _duration = const Duration(seconds: 60);
  Timer _timer = Timer.periodic(const Duration(seconds: 1), (_) {});

  Duration get duration => _duration;

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
    notifyListeners();
  }
}
