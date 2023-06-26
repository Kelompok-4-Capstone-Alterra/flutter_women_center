import 'package:capstone_project/model/forum_model.dart';
import 'package:capstone_project/model/mock_model.dart';
import 'package:capstone_project/model/service/home_service.dart';
import 'package:capstone_project/model/service/user_service.dart';
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/career_model.dart';

class HomeViewModel with ChangeNotifier {
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final UserService _userService = UserService();
  final HomeService _homeService = HomeService();
  String _username = 'user';
  bool _isLogin = false;
  List<ArticlesMock> _articlesMock = [];
  MyState _articlesState = MyState.initial;
  List<CounselorMock> _counselorMock = [];
  MyState _counselorState = MyState.initial;
  List<CareerModel> _careerMock = [];
  MyState _careerState = MyState.initial;
  List<ForumModel> _forumMock = [];
  MyState _forumState = MyState.initial;

  MyState get state => _state;
  String get message => _message;
  String get username => _username;
  List<ArticlesMock> get articlesMock => _articlesMock;
  MyState get articlesState => _articlesState;
  List<CounselorMock> get counselorMock => _counselorMock;
  MyState get counselorState => _counselorState;
  List<CareerModel> get careerMock => _careerMock;
  MyState get careerState => _careerState;
  List<ForumModel> get forumMock => _forumMock;
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
      _articlesMock = await _homeService.getArticles();
      changeArticlesState(MyState.loaded);
    } catch (e) {
      changeArticlesState(MyState.failed);
    }
  }

  void initCounselorData() async {
    try {
      changeCounselorState(MyState.loading);
      _counselorMock = await _homeService.getCounselor();
      changeCounselorState(MyState.loaded);
    } catch (e) {
      changeCounselorState(MyState.failed);
    }
  }

  void initCareerData() async {
    try {
      changeCareerState(MyState.loading);
      _careerMock = await _homeService.getCareer();
      changeCareerState(MyState.loaded);
    } catch (e) {
      changeCareerState(MyState.failed);
    }
  }

  void initForumData() async {
    try {
      changeForumState(MyState.loading);
      _forumMock = await _homeService.getForum();
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
    }
  }
}
