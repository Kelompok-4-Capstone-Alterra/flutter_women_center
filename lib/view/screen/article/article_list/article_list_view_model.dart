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
  String message = '';
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
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    changeState(MyState.loading);
    _loginData = await SharedPreferences.getInstance();
    changeState(MyState.loaded);
  }

  bool isLoggedIn() {
    return _loginData.containsKey('token') &&
        _loginData.getString('token')!.isNotEmpty;
  }

  Future<void> fetchTopicsAndArticles() async {
    try {
      if (isLoggedIn() == true) {
        await getTopics();
        await getArticles();
      } else {
        await getTopics();
        await getArticlesNoLogin();
      }
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
    }
  }

  List<Tab> getListTopic() {
    tabTopics = topics.map((topic) => Tab(text: topic.name)).toList();
    return tabTopics;
  }

  Future<void> getTopics() async {
    try {
      topics = await _articleService.getAllTopic();
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }

  Articles? getArticleById(String articleId) {
    return listArticles.firstWhere(
      (article) => article.id == articleId,
    );
  }

  Future<void> getArticles() async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        changeState(MyState.failed);
      } else {
        listArticles = await _articleService.getAllArticles(token);
        changeState(MyState.loaded);
      }
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }

  Future<void> getArticlesNoLogin() async {
    try {
      changeState(MyState.loading);
      listArticles = await _articleService.getAllArticlesNoLogin();
      changeState(MyState.loaded);
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
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
        changeState(MyState.failed);
      }
      listArticles = await _articleService.searchArticles(token, searchText);
      changeState(MyState.loaded);
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }

  Future<void> searchArticlesNoLogin(String searchText) async {
    try {
      listArticles = await _articleService.searchArticlesNonLogin(searchText);
      changeState(MyState.loaded);
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }

  Future<void> sortArticles(String sortValue) async {
    try {
      sortValues = sortValue;
      changeState(MyState.loaded);

      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        changeState(MyState.failed);
      }
      listArticles = await _articleService.sortArticles(token, sortValue);
      changeState(MyState.loaded);
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }

  Future<void> sortArticlesNoLogin(String sortValue) async {
    try {
      sortValues = sortValue;
      changeState(MyState.loaded);

      changeState(MyState.loading);
      listArticles = await _articleService.sortArticlesNoLogin(sortValue);
      changeState(MyState.loaded);
    } catch (e) {
      message = e.toString();
      changeState(MyState.failed);
      rethrow;
    }
  }
}
