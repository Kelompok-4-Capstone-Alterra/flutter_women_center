import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/model/service/article_service.dart';
import 'package:capstone_project/model/service/reading_list_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveContentProvider extends ChangeNotifier {
  MyState myState = MyState.initial;
  List<ReadingListModel> readingList = [];
  String selectedReadingListId = '';
  ValueNotifier<bool> isButtonPressed = ValueNotifier<bool>(false);
  int checkedIndex = -1;
  final ArticleService _articleService = ArticleService();
  final ReadingListService _readingListService = ReadingListService();
  late SharedPreferences _loginData;
  String _message = '';

  void changeState(MyState state) {
    myState = state;
    notifyListeners();
  }

  SaveContentProvider() {
    initializeSharedPreferences();
    loadSavedArticleIds(); // Menambahkan method ini
  }

  void loadSavedArticleIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedArticleIds = prefs.getKeys().whereType<String>().toList();
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
      readingList = await _readingListService.getAllReadingList(token: token);
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      _message = e.toString();
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
          token, articleId, readingListId);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> removeArticleFromReadingList(String articleId) async {
    try {
      myState = MyState.loading;
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.deleteArticleFromReadingList(
          token: token, id: articleId);
      savedArticleIds.remove(articleId);
      saveArticleStatus(articleId, false);
      myState = MyState.loaded;
    } catch (e) {
      _message = e.toString();
      myState = MyState.failed;
    }
  }

  Future<void> toggleCheck(int index) async {
    if (checkedIndex == index) {
      checkedIndex =
          -1; // Batal mengcentang item jika sudah dicentang sebelumnya
    } else {
      checkedIndex = index; // Mengcentang item yang dipilih
    }
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
      if (context != null && context.findRenderObject() != null) {
        Navigator.pop(context); // Tutup bottom sheet jika masih ada
      }
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  List<String> savedArticleIds = [];

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
}
