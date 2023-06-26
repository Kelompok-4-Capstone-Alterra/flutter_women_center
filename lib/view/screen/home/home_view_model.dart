import 'package:capstone_project/model/counselor_list_model.dart';
import 'package:capstone_project/model/forum_model.dart';
import 'package:capstone_project/service/home_service.dart';
import 'package:capstone_project/service/user_service.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/article_model.dart';
import '../../../model/career_model.dart';

class HomeViewModel with ChangeNotifier {
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final UserService _userService = UserService();
  final HomeService _homeService = HomeService();
  String _username = 'user';
  bool _isLogin = false;
  List<Articles> _articlesData = [];
  MyState _articlesState = MyState.initial;
  List<CounselorListModel> _counselorData = [];
  MyState _counselorState = MyState.initial;
  List<CareerModel> _careerData = [];
  MyState _careerState = MyState.initial;
  List<ForumModel> _forumData = [];
  MyState _forumState = MyState.initial;

  MyState get state => _state;
  String get message => _message;
  String get username => _username;
  List<Articles> get articlesData => _articlesData;
  MyState get articlesState => _articlesState;
  List<CounselorListModel> get counselorData => _counselorData;
  MyState get counselorState => _counselorState;
  List<CareerModel> get careerData => _careerData;
  MyState get careerState => _careerState;
  List<ForumModel> get forumData => _forumData;
  MyState get forumState => _forumState;
  bool get isLogin => _isLogin;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void changeArticlesState(MyState state) {
    _articlesState = state;
    notifyListeners();
  }

  void changeCounselorState(MyState state) {
    _counselorState = state;
    notifyListeners();
  }

  void changeCareerState(MyState state) {
    _careerState = state;
    notifyListeners();
  }

  void changeForumState(MyState state) {
    _forumState = state;
    notifyListeners();
  }

  void initUser() async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isNotEmpty) {
        final UserModel data = await _userService.getProfile(token: token);
        _username = data.username ?? 'user';
        _isLogin = true;
      } else {
        _username = 'user';
        _isLogin = false;
      }
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  void initArticleaData() async {
    try {
      changeArticlesState(MyState.loading);
      _articlesData = await _homeService.getArticles();
      changeArticlesState(MyState.loaded);
    } catch (e) {
      changeArticlesState(MyState.failed);
    }
  }

  void initCounselorData() async {
    try {
      changeCounselorState(MyState.loading);
      _counselorData = await _homeService.getCounselor();
      changeCounselorState(MyState.loaded);
    } catch (e) {
      changeCounselorState(MyState.failed);
    }
  }

  void initCareerData() async {
    try {
      changeCareerState(MyState.loading);
      _careerData = await _homeService.getCareer();
      changeCareerState(MyState.loaded);
    } catch (e) {
      changeCareerState(MyState.failed);
    }
  }

  void initForumData() async {
    try {
      changeForumState(MyState.loading);
      _forumData = await _homeService.getForum();
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
    }
  }
}
