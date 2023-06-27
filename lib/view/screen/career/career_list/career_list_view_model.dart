import 'package:capstone_project/model/career_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../service/career_service.dart';
import '../../../../../utils/state/finite_state.dart';

class CareerListViewModel extends ChangeNotifier {
  bool newestCheckStatus = true;
  bool sortingByNewest = true;
  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  final CareerService _careerService = CareerService();
  late List<CareerModel> careerList = [];

  MyState get state => _state;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void fetchAllCareer() async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';

      careerList = await _careerService.getAllCareer(token: token);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  void searchCareer({required String keyword}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';

      careerList =
          await _careerService.searchCareer(token: token, keywords: keyword);
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }

  void checkHighestSalary() {
    _state = MyState.loading;
    notifyListeners();
    newestCheckStatus = false;
    _state = MyState.loaded;
    notifyListeners();
  }

  void checkNewest() {
    _state = MyState.loading;
    notifyListeners();
    newestCheckStatus = true;
    _state = MyState.loaded;
    notifyListeners();
  }

  void saveSortByNewest() {
    _state = MyState.loading;
    notifyListeners();

    sortingByNewest = true;

    _state = MyState.loaded;
    notifyListeners();
  }

  void saveSortByHighestSalary() {
    _state = MyState.loading;
    notifyListeners();

    sortingByNewest = false;

    _state = MyState.loaded;
    notifyListeners();
  }

  Future<void> fetchCareerSortBy({required bool sortByCareer}) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';

      careerList = await _careerService.getCareerSortBy(
        token: token,
        sortBy: sortByCareer,
      );
      changeState(MyState.loaded);
    } catch (e) {
      changeState(MyState.failed);
      rethrow;
    }
  }
}
