import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/model/service/article_service.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleListProvider extends ChangeNotifier {
  String searchText = '';
  MyState myState = MyState.initial;
  late SharedPreferences _loginData;
  List<TopicModel> topics = [];
  List<Tab> tabTopics = [];
  String _message = '';
  List<Articles> listArticles = [];
  List<ReadingListModel> readingList = [];
  final ArticleService _articleService = ArticleService();
  final Dio dio = Dio();
  String sortValues = 'most_viewed';

  void changeState(MyState state) {
    myState = state;
    notifyListeners();
  }

  ArticleListProvider() {
    initializeSharedPreferences(); // Pindahkan pemanggilan ke dalam konstruktor
  }

  void initializeSharedPreferences() async {
    changeState(MyState.loading);
    _loginData = await SharedPreferences.getInstance();
    changeState(MyState.loaded);
  }

  Future<void> fetchTopicsAndArticles() async {
    try {
      changeState(MyState.loading);
      await getTopics();
      await getArticles();
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  List<Tab> getListTopic() {
    tabTopics =
        topics.map((topic) => Tab(text: topic.name?.toUpperCase())).toList();
    return tabTopics;
  }

  Articles? getArticleById(String articleId) {
    return listArticles.firstWhere(
      (article) => article.id == articleId,
    );
  }

  Future<void> getTopics() async {
    try {
      topics = await _articleService.getAllTopic();
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> getArticles() async {
    try {
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        listArticles = await _articleService.getAllArticlesNoLogin();
        changeState(MyState.loaded);
      } else {
        listArticles = await _articleService.getAllArticles(token);
        changeState(MyState.loaded);
      }
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  void updateSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  Future<void> searchArticles(String searchText) async {
    try {
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        changeState(MyState.loading);
        listArticles = await _articleService.searchArticlesNonLogin(searchText);
        changeState(MyState.loaded);
      }
      listArticles = await _articleService.searchArticles(token, searchText);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> sortArticles(String sortValue) async {
    try {
      sortValues = sortValue;
      changeState(MyState.loaded);

      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        changeState(MyState.loading);
        listArticles = await _articleService.sortArticlesNoLogin(sortValue);
        changeState(MyState.loaded);
      }
      listArticles = await _articleService.sortArticles(token, sortValue);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  void filterMostViewed() {
    myState = MyState.loading;
    notifyListeners();

    sortValues = 'Most Viewed';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterNewest() {
    myState = MyState.loading;
    notifyListeners();

    listArticles.sort((a, b) =>
        DateTime.parse(b.date ?? '').compareTo(DateTime.parse(a.date ?? '')));

    sortValues = 'Newest';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterOldest() {
    myState = MyState.loading;
    notifyListeners();

    listArticles.sort((a, b) =>
        DateTime.parse(a.date ?? '').compareTo(DateTime.parse(b.date ?? '')));

    sortValues = 'Oldest';

    myState = MyState.loaded;
    notifyListeners();
  }
}
