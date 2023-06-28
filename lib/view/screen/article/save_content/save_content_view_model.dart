// ignore_for_file: use_build_context_synchronously

import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveContentProvider extends ChangeNotifier {
  MyState myState = MyState.initial;
  List<ReadingListModel> readingList = [];
  String selectedReadingListId = '';
  ValueNotifier<bool> isButtonPressed = ValueNotifier<bool>(false);
  int checkedIndex = -1;
  String? selectedArticleId;
  final ReadingListService _readingListService = ReadingListService();
  late SharedPreferences _loginData;
  String message = '';

  void changeState(MyState state) {
    myState = state;
    notifyListeners();
  }

  SaveContentProvider() {
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    changeState(MyState.loading);
    _loginData = await SharedPreferences.getInstance();
    changeState(MyState.loaded);
  }

  void setSelectedReadingListId(String readingListId) {
    selectedReadingListId = readingListId;
    notifyListeners();
  }

  Future<void> showAllReadingList() async {
    try {
      myState = MyState.loading;
      notifyListeners();
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      readingList = await _readingListService.getAllReadingList(token: token);
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      myState = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> saveToReadingList(String articleId, String readingListId) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.postArticleToReadingList(
          token: token, articleId: articleId, readingListId: readingListId);
      changeState(MyState.loaded);
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> toggleCheck(int index) async {
    if (checkedIndex == index) {
      checkedIndex = -1;
    } else {
      checkedIndex = index;
    }
    notifyListeners();
  }

  void clearCheckedItems() {
    checkedIndex = -1;
    notifyListeners();
  }

  bool isItemChecked(int index) {
    return checkedIndex == index;
  }

  Future<void> createReadingList(BuildContext context,
      {required String name, required String description}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.postReadingList(
          token: token, name: name, description: description);
      await showAllReadingList();
      if (context.findRenderObject() != null) {
        Navigator.pop(context); // Tutup bottom sheet jika masih ada
      }
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> refreshReadingList() async {
    try {
      myState = MyState.loading;
      final token = _loginData.getString('token') ?? '';
      await _readingListService.getAllReadingList(token: token);
      myState = MyState.loaded;
    } catch (e) {
      message = e.toString();
      myState = MyState.failed;
    }
  }
}
