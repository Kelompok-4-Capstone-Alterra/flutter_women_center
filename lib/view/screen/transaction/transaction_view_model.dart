import 'package:flutter/material.dart';

class TransactionViewModel with ChangeNotifier {
  List<bool> counselorRate = [false, false, false, false, false];
  List<bool> history = [false, false, false, false, false, false];
  int counselorTotalRate = 0;
  bool ratingDone = false;

  void changeCounselorRate(int index) {
    if (counselorRate[index] == false) {
      for (int i = 0; i <= index; i++) {
        counselorRate[i] = true;
      }
    } else {
      for (int i = 0; i < counselorRate.length; i++) {
        if (counselorRate[i] == true) {
          counselorTotalRate++;
        }
      }
      for (int i = index; i < counselorTotalRate; i++) {
        counselorRate[i] = false;
      }
    }
    counselorTotalRate = 0;
    notifyListeners();
  }

  void changeRatingStatus(int index) {
    history[index] = true;
    notifyListeners();
  }
}
