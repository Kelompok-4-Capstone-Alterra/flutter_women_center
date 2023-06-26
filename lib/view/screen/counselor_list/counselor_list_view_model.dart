import 'package:capstone_project/model/counselor_list_model.dart';
import 'package:capstone_project/model/service/counselor_list_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class CounselorListViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List<CounselorListModel> counselorList = [];

  List<CounselorListModel> counselorListData = [];

  String sortValue = 'Highest Rating';

  final CounselorListService _counselorListService = CounselorListService();

  Future<void> getCounselorList({
    required int topic,
  }) async {
    try {
      myState = MyState.loading;
      notifyListeners();

      counselorList = await _counselorListService.getCounselorList(
        topic: topic,
      );
      counselorListData = counselorList;
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void filterHighestRating() {
    myState = MyState.loading;
    notifyListeners();

    counselorList = counselorListData;
    counselorList
        .sort((a, b) => b.rating.toString().compareTo(a.rating.toString()));
    sortValue = 'Highest Rating';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterHighestPrice() {
    myState = MyState.loading;
    notifyListeners();

    counselorList = counselorListData;
    counselorList
        .sort((a, b) => b.price.toString().compareTo(a.price.toString()));
    sortValue = 'Highest Price';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterLowestPrice() {
    myState = MyState.loading;
    notifyListeners();

    counselorList = counselorListData;
    counselorList
        .sort((a, b) => a.price.toString().compareTo(b.price.toString()));
    sortValue = 'Lowest Price';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterByName(String name) {
    myState = MyState.loading;
    notifyListeners();
    try {
      // filter counselorList from counselorListData
      counselorList = counselorListData
          .where(
              (element) => element.name.toString().toLowerCase().contains(name))
          .toList();

      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
