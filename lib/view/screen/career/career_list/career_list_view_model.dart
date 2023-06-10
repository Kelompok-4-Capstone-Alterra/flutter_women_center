import 'package:flutter/material.dart';

class CareerListViewModel extends ChangeNotifier {
  String? selectedSortBy;

  void setSelectedSortBy(String option) {
    selectedSortBy = option;
    notifyListeners();
  }
}
