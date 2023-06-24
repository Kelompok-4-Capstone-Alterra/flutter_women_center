import 'package:capstone_project/model/comment_model.dart';
import 'package:capstone_project/model/service/article_service.dart';
import 'package:capstone_project/utils/decoder/jwt_decoder.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentProvider extends ChangeNotifier {
  MyState myState = MyState.initial;
  late SharedPreferences _loginData;
  String _message = '';
  List<Comment> comments = [];
  Map<String, dynamic> decodeToken = {};
  final ArticleService _articleService = ArticleService();
  String currentUserId = '';

  CommentProvider() {
    initializeSharedPreferences(); // Pindahkan pemanggilan ke dalam konstruktor
  }

  void initializeSharedPreferences() async {
    changeState(MyState.loading);
    _loginData = await SharedPreferences.getInstance();
    changeState(MyState.loaded);
  }

  void changeState(MyState state) {
    myState = state;
  }

  void setCurrentUserId(String userId) {
    currentUserId = userId;
    notifyListeners();
  }

  bool getCurrentUserId(String anotherId) {
    if (currentUserId == anotherId) {
      print(anotherId);
      return true;
    } else {
      print(anotherId);
      return false;
    }
  }

  Future<void> getComments(String articleId) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      decodeToken = JwtDecoder.decode(token);
      if (token.isEmpty) {
        changeState(MyState.failed);
        return;
      } else {
        setCurrentUserId(decodeToken[
            'id']); // Set nilai currentUserId sebelum memanggil changeState
        comments = await _articleService.getAllComments(token, articleId);
        changeState(MyState.loaded);
        notifyListeners();
      }
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> createComments(String articleId, Comment comment) async {
    try {
      changeState(MyState.loading);

      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      decodeToken = JwtDecoder.decode(token);
      if (token.isEmpty) {
        changeState(MyState.failed);
        return;
      } else {
        setCurrentUserId(decodeToken['id']);
        await _articleService.createComment(token, articleId, comment);
        changeState(MyState.loaded);
        notifyListeners();
      }
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  Future<void> deleteComments(String articleId, String commentId) async {
    try {
      changeState(MyState.loading);

      _loginData = await SharedPreferences.getInstance();

      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        changeState(MyState.failed);
        return;
      }
      await _articleService.deleteComments(token, articleId, commentId);
      await getComments(articleId);

      changeState(MyState.loaded);
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  void submitComment(String commentText, String articleId) async {
    if (commentText.isNotEmpty) {
      Comment newComment = Comment(
        articleId: articleId,
        comment: commentText,
      );
      await createComments(articleId, newComment);
      await getComments(articleId);
      notifyListeners();
    }
  }
}
