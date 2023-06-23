import 'package:capstone_project/utils/state/finite_state.dart';

import 'package:flutter/material.dart';

class TabSearchViewModel extends ChangeNotifier {
  MyState _state = MyState.initial;
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  MyState get state => _state;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void init() {
    changeState(MyState.initial);
  }

  void changeSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}
