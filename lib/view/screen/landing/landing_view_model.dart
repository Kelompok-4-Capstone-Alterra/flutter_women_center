import 'package:flutter/material.dart';

class LandingViewModel with ChangeNotifier {
  bool modalBottomSheetStatus = false;

  void activateModalBottomSheet(bool status) {
    modalBottomSheetStatus = status;
    notifyListeners();
  }
}
