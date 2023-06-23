import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/model/service/reading_list_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleListPostProvider extends ChangeNotifier {
  MyState myState = MyState.initial;

  ReadingListModel dataReadingList = ReadingListModel();
  List<ReadingListModel> readingList = [];
  ValueNotifier<bool> isButtonPressed = ValueNotifier<bool>(false);
  String selectedReadingListId = '';
  final ReadingListService _readingListService = ReadingListService();
  late SharedPreferences _loginData;
  String _message = '';
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
    return _loginData.containsKey('token') &&
        _loginData.getString('token')!.isNotEmpty;
  }

  Future<void> saveArticleStatus(String articleId, bool isSaved) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(articleId, isSaved);
  }

  Future<void> showAllReadingList() async {
    try {
      myState = MyState.loading;
      notifyListeners();
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      readingList = (await _readingListService.getAllReadingList(token: token));
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      myState = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> removeArticleFromReadingList(String articleId) async {
    try {
      myState = MyState.loading;
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.deleteReadingList(token: token, id: articleId);
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      myState = MyState.failed;
    }
  }

  void toggleArticleSaved(String articleId) {
    if (savedArticleIds.contains(articleId)) {
      savedArticleIds.remove(articleId);
      saveArticleStatus(articleId,
          false); // Menyimpan status false ke dalam SharedPreferences
    } else {
      savedArticleIds.add(articleId);
      saveArticleStatus(
          articleId, true); // Menyimpan status true ke dalam SharedPreferences
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
          token, articleId, readingListId);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }
}
