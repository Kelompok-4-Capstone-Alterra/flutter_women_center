import 'package:capstone_project/utils/state/finite_state.dart';

import 'package:flutter/material.dart';

class HomeSearchViewModel extends ChangeNotifier {
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

  void search(String value) async {
    if (value.isEmpty) {
      changeState(MyState.initial);
    } else {
      changeState(MyState.loading);
      // add deley
      await Future.delayed(Duration(seconds: 2));
      changeState(MyState.loaded);
    }
  }

  void changeSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}
