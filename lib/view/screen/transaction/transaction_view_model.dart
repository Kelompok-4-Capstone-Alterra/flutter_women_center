import 'package:flutter/material.dart';

class TransactionViewModel with ChangeNotifier {
  List<bool> counselingSessionRate = [false, false, false, false, false];
  List<bool> counselorRate = [false, false, false, false, false];
  int counselingSessionTotalRate = 0;
  int counselorTotalRate = 0;

  void changeCounselingSessionRate({required int index}) {
    if (counselingSessionRate[index] == false) {
      for (int i = 0; i <= index; i++) {
        counselingSessionRate[i] = true;
      }
    } else {
      for (int i = 0; i < counselingSessionRate.length; i++) {
        if (counselingSessionRate[i] == true) {
          counselingSessionTotalRate++;
        }
      }
      for (int i = index; i < counselingSessionTotalRate; i++) {
        counselingSessionRate[i] = false;
      }
    }
    counselingSessionTotalRate = 0;
    notifyListeners();
  }

  void changeCounselorRate({required int index}) {
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
}
