import 'package:flutter/material.dart';

class SavedViewModel with ChangeNotifier {
  List<String> readingList = [];
  bool buttonIsActive = false;

  void newList(String judulList) {
    readingList.add(judulList);

    notifyListeners();
  }

  void activateButton() {
    buttonIsActive = true;
    notifyListeners();
  }

  void deactivateButton() {
    buttonIsActive = false;
    notifyListeners();
  }
}
