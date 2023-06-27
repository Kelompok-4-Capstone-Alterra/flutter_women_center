import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/model/career_model.dart';
import 'package:capstone_project/service/article_service.dart';
import 'package:capstone_project/service/career_service.dart';
import 'package:capstone_project/service/counselor_list_service.dart';
import 'package:capstone_project/service/forum_service.dart';
import 'package:capstone_project/model/counselor_list_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';

import 'package:flutter/material.dart';

import '../../../../../model/forum_model.dart';

class TabSearchViewModel extends ChangeNotifier {
  MyState _state = MyState.initial;
  int _selectedTab = 0;
  List<Articles> _articles = [];
  List<CounselorListModel> _counselors = [];
  List<CareerModel> _careers = [];
  List<ForumModel> _forums = [];
  final ArticleService _articleService = ArticleService();
  final ForumService _forumService = ForumService();
  final CareerService _careerService = CareerService();
  final CounselorListService _counselorListService = CounselorListService();

  MyState get state => _state;
  int get selectedTab => _selectedTab;
  List<Articles> get articles => _articles;
  List<CounselorListModel> get counselors => _counselors;
  List<CareerModel> get careers => _careers;
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
      _articles = await _articleService.getAllArticlesNoLogin(search: query);
      _counselors =
          await _counselorListService.getCounselorList(topic: 0, search: query);
      _careers = await _careerService.searchCareer(token: '', keywords: query);
      _forums = await _forumService.getAllForum(topic: query);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }
}
