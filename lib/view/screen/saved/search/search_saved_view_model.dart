import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/state/finite_state.dart';

class SearchSavedViewModel with ChangeNotifier {
  MyState myState = MyState.initial;
  bool oldestCheckStatus = true;
  bool sortingByOldest = true;

  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  final ReadingListService _readingListService = ReadingListService();
  List<ReadingListModel> _allReadingListData = <ReadingListModel>[];

  MyState get state => _state;
  List<ReadingListModel> get allReadingListData => _allReadingListData;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  ///menampilkan semua reading list berdasarkan "name" dari service reading lsit
  Future<void> showReadingListByName({required String? name}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      _allReadingListData = await _readingListService.getReadingListByName(
        token: token,
        name: name ?? '',
      );
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  ///mengubah informasi reading list dari service reading list
  Future<void> updateReadingList({
    required String? id,
    required String? name,
    required String? description,
  }) async {
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
      showReadingListByName(name: name);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  ///menghapus reading list dari service reading list
  Future<void> removeReadingList({
    required String? id,
    required String? name,
  }) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.deleteReadingList(
        token: token,
        id: id ?? '',
      );
      showReadingListByName(name: name);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }
}
