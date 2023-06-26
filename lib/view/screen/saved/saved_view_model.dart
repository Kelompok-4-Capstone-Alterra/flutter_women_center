import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/state/finite_state.dart';

class SavedViewModel with ChangeNotifier {
  MyState myState = MyState.initial;
  bool oldestCheckStatus = false;
  bool sortingByOldest = false;

  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final ReadingListService _readingListService = ReadingListService();
  List<ReadingListModel> _allReadingListData = <ReadingListModel>[];

  MyState get state => _state;
  String get message => _message;
  List<ReadingListModel> get allReadingListData => _allReadingListData;

  void checkNewest() {
    changeState(MyState.loading);
    notifyListeners();
    oldestCheckStatus = false;
    changeState(MyState.loaded);
    notifyListeners();
  }

  void checkOldest() {
    changeState(MyState.loading);
    notifyListeners();
    oldestCheckStatus = true;
    changeState(MyState.loaded);
    notifyListeners();
  }

  void saveSortByOldest() {
    changeState(MyState.loading);
    notifyListeners();

    sortingByOldest = true;

    changeState(MyState.loaded);
    notifyListeners();
  }

  void saveSortByNewest() {
    changeState(MyState.loading);
    notifyListeners();

    sortingByOldest = false;

    changeState(MyState.loaded);
    notifyListeners();
  }

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  ///menampilkan semua data reading list berdasarkan sort by "oldest" atau "newest" dari servce reading list
  Future<void> showReadingListSortByOldestOrNewest(
      {required bool? sortByOldest}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      _allReadingListData =
          await _readingListService.getReadingListSortByOldestOrNewest(
        token: token,
        sortByOldest: sortByOldest ?? false,
      );
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  ///membuat reading list baru ke service reading list
  Future<void> createReadingList(
      {required String? name, required String? description}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _readingListService.postReadingList(
        token: token,
        name: name ?? '',
        description: description ?? '',
      );
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  ///mengubah informasi reading list ke service reading list
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
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
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
      _message = e.toString();
      changeState(MyState.failed);
    }
  }
}
