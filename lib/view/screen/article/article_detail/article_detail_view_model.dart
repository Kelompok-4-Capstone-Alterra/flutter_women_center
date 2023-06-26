import 'package:capstone_project/model/comment_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleDetailProvider extends ChangeNotifier {
  MyState myState = MyState.initial;
  late SharedPreferences _loginData;
  List<Comment> comments = [];
  String message = '';
  List<String> savedArticleIds = [];
  final ReadingListService _readingListService = ReadingListService();

  ArticleDetailProvider() {
    initializeSharedPreferences(); // Pindahkan pemanggilan ke dalam konstruktor
  }

  void initializeSharedPreferences() async {
    changeState(MyState.loading);
    _loginData = await SharedPreferences.getInstance();
    changeState(MyState.loaded);
  }

  void changeState(MyState state) {
    myState = state;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _loginData.containsKey('token') &&
        _loginData.getString('token')!.isNotEmpty;
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
}
