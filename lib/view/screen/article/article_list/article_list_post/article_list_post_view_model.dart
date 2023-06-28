import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleListPostProvider extends ChangeNotifier {
  MyState myState = MyState.initial;
  List<ReadingListModel> readingList = [];
  String selectedReadingListId = '';
  final ReadingListService _readingListService = ReadingListService();
  late SharedPreferences _loginData;
  String message = '';
  List<String> savedArticleIds = [];

  ArticleListPostProvider() {
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

  void changeState(MyState state) {
    myState = state;
    notifyListeners();
  }

  bool isLoggedIn() {
    initializeSharedPreferences();
    return _loginData.containsKey('token') &&
        _loginData.getString('token')!.isNotEmpty;
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
      rethrow;
    }
  }

  Future<void> removeArticleFromReadingList(String articleId) async {
    try {
      myState = MyState.loading;
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.deleteArticleFromReadingList(
          token: token, id: articleId);
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      myState = MyState.failed;
      rethrow;
    }
  }

  void toggleArticleSaved(String articleId, bool saved) async {
    if (saved) {
      savedArticleIds.add(articleId);
    } else {
      savedArticleIds.remove(articleId);
    }
    notifyListeners();
  }

  bool isArticleSaved(String articleId) {
    return savedArticleIds.contains(articleId);
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
      rethrow;
    }
  }
}
