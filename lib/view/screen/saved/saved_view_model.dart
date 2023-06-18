import 'package:flutter/material.dart';

import '../../../utils/state/finite_state.dart';

class SavedViewModel with ChangeNotifier {
  List<String> readingList = [];
  bool buttonIsActive = false;
  MyState myState = MyState.initial;
  bool oldestCheckStatus = true;
  bool sortByOldest = true;

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

  void checkNewest() {
    myState = MyState.loading;
    notifyListeners();
    oldestCheckStatus = false;
    myState = MyState.loaded;
    notifyListeners();
  }

  void checkOldest() {
    myState = MyState.loading;
    notifyListeners();
    oldestCheckStatus = true;
    myState = MyState.loaded;
    notifyListeners();
  }

  void saveSortByOldest() {
    myState = MyState.loading;
    notifyListeners();

    sortByOldest = true;

    myState = MyState.loaded;
    notifyListeners();
  }

  void saveSortByNewest() {
    myState = MyState.loading;
    notifyListeners();

    sortByOldest = false;

    myState = MyState.loaded;
    notifyListeners();
  }
}
