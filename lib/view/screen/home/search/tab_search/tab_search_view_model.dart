import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/model/mock_model.dart';
import 'package:capstone_project/model/service/article_service.dart';
import 'package:capstone_project/model/service/forum_service.dart';
import 'package:capstone_project/model/service/home_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';

import 'package:flutter/material.dart';

import '../../../../../model/forum_model.dart';

class TabSearchViewModel extends ChangeNotifier {
  MyState _state = MyState.initial;
  int _selectedTab = 0;
  List<Articles> _articles = [];
  List<CounselorMock> _counselors = [];
  List<CareerMock> _careers = [];
  List<ForumModel> _forums = [];
  final ArticleService _articleService = ArticleService();
  final HomeService _homeService = HomeService();
  final ForumService _forumService = ForumService();

  MyState get state => _state;
  int get selectedTab => _selectedTab;
  List<Articles> get articles => _articles;
  List<CounselorMock> get counselors => _counselors;
  List<CareerMock> get careers => _careers;
  List<ForumModel> get forums => _forums;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void init() {
    changeState(MyState.initial);
  }

  void changeSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void searchData(String query) async {
    try {
      changeState(MyState.loading);
      _articles = await _articleService.getAllArticlesNoLogin();
      _counselors = await _homeService.getCounselor();
      _careers = await _homeService.getCareer();
      _forums = await _forumService.getAllForum(topic: query);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
    }
  }
}
