import 'package:flutter/material.dart';

class OnboardingViewModel with ChangeNotifier {
  bool isLastPage = false;

  void setIsLastPage(bool status) {
    isLastPage = status;
    notifyListeners();
  }
}
