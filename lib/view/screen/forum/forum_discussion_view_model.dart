import 'package:capstone_project/service/forum_service.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../model/forum_model.dart';

class ForumDiscussionViewModel extends ChangeNotifier {
  MyState _topicState = MyState.initial;
  MyState _forumState = MyState.initial;
  final ForumService _forumService = ForumService();
  List<ForumModel> _forumData = <ForumModel>[];
  late SharedPreferences _loginData;
  List<TopicModel> _topicData = <TopicModel>[];
  String _sortBy = 'newest';
  String _topic = '';
  int _categoryId = 0;
  int _tabId = 0;
  bool _isLogin = false;

  MyState get topicState => _topicState;
  MyState get forumState => _forumState;
  List<TopicModel> get topicData => _topicData;
  List<ForumModel> get forumData => _forumData;
  String get sortBy => _sortBy;
  int get tabId => _tabId;
  bool get isLogin => _isLogin;
  int get categoryId => _categoryId;

  void changeTopicState(MyState state) {
    _topicState = state;
    notifyListeners();
  }

  void changeForumState(MyState state) {
    _forumState = state;
    notifyListeners();
  }

  void init() async {
    changeTopicState(MyState.initial);
    _topicData = await _forumService.getTopics();
    _loginData = await SharedPreferences.getInstance();
    final token = _loginData.getString('token') ?? '';
    if (token != '') {
      _isLogin = true;
      _sortBy = 'newest';
    } else {
      _isLogin = false;
      _categoryId = topicData[0].id!;
      _sortBy = 'newest';
    }
  }

  void changeSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  void changeTabId(int tabId) async {
    _loginData = await SharedPreferences.getInstance();
    final token = _loginData.getString('token') ?? '';
    _tabId = tabId;
    if (token != '') {
      if (_tabId != 0) {
        _categoryId = topicData[tabId - 1].id!;
      } else {
        _categoryId = 0;
      }
    } else {
      _categoryId = topicData[tabId].id!;
    }
    notifyListeners();
  }

  void joinForum(String forumId, String url) async {
    try {
      changeForumState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _forumService.joinForum(token: token, forumId: forumId);
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
      _forumData = await _forumService.getAllForum(
          topic: _topic, sortBy: _sortBy, categoryId: _categoryId);
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
      rethrow;
    }
  }

  void createForum(ForumModel data) async {
    try {
      changeForumState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _forumService.createForum(token: token, forumData: data);
      _forumData = await _forumService.getMyForum(token: token);
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
      rethrow;
    }
  }

  void deleteForum(String forumId) async {
    try {
      changeForumState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _forumService.deleteForum(token: token, forumId: forumId);
      _forumData = await _forumService.getMyForum(token: token);
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
      rethrow;
    }
  }

  void updateForum(String forumId, ForumModel data) async {
    try {
      changeForumState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _forumService.updateForum(
          token: token, forumId: forumId, forumData: data);
      _forumData = await _forumService.getMyForum(token: token);
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
      rethrow;
    }
  }

  void fetchForum() async {
    try {
      changeForumState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      if (_categoryId == 0) {
        final token = _loginData.getString('token') ?? '';
        _forumData = await _forumService.getMyForum(
          token: token,
          sortBy: _sortBy,
          topic: _topic,
        );
      } else {
        _forumData = await _forumService.getAllForum(
          categoryId: _categoryId,
          sortBy: _sortBy,
          topic: _topic,
        );
      }
      changeForumState(MyState.loaded);
    } catch (e) {
      changeForumState(MyState.failed);
      rethrow;
    }
  }

  void searchForum(String search) async {
    _topic = search;
    fetchForum();
  }
}
