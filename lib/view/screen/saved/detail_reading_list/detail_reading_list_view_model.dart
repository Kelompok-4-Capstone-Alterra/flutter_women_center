import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../model/reading_list_model.dart';
import '../../../../service/reading_list_service.dart';
import '../../../../utils/state/finite_state.dart';

class DetailReadingListViewmodel with ChangeNotifier {
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  final ReadingListService _readingListService = ReadingListService();
  ReadingListModel _readingListData = ReadingListModel();

  MyState get state => _state;
  ReadingListModel get readingListData => _readingListData;

  late String? id;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  ///menampilkan detail reading list beserta artikel-artikelnya dari service reading list
  Future<void> showReadingList({required String? id}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      _readingListData = await _readingListService.getReadingList(
        token: token,
        id: id ?? '',
      );
      if (_readingListData.id != null &&
          _readingListData.name != null &&
          _readingListData.userId != null &&
          _readingListData.description != null &&
          _readingListData.articleTotal != null &&
          _readingListData.createdAt != null) {
        changeState(MyState.loaded);
      }
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  ///mengubah informasi reading list dari service reading list
  Future<void> updateReadingList(
      {required String? id,
      required String? name,
      required String? description}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.putReadingList(
        token: token,
        id: id ?? '',
        name: name ?? '',
        description: description ?? '',
      );
      showReadingList(id: id);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  ///menghapus reading list dari service reading list
  Future<void> removeReadingList({required String? id}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.deleteReadingList(
        token: token,
        id: id ?? '',
      );
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  ///menghapus artikel yang tersimpan pada reading list dari service reading list
  Future<void> removeArticleFromReadingList({required String? id}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.deleteArticleFromReadingList(
        token: token,
        id: id ?? '',
      );
      showReadingList(id: id);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }
}
