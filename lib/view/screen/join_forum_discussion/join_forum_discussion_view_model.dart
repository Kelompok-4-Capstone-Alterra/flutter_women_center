import 'package:flutter/foundation.dart';

class SortByForumProvider extends ChangeNotifier {
  String? selectedOption;

  void setSelectedOption(String option) {
    selectedOption = option;
    notifyListeners();
  }
}
