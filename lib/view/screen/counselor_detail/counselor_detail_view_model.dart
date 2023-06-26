import 'package:capstone_project/model/avaible_time_model.dart';
import 'package:capstone_project/model/counselor_detail_model.dart';
import 'package:capstone_project/model/counselor_review_model.dart';
import 'package:capstone_project/model/service/avaible_time_service.dart';
import 'package:capstone_project/model/service/counselor_detail_service.dart';
import 'package:capstone_project/model/service/counselor_review_service.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounselorDetailViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  late CounselorDetailModel counselorDetail;

  late AvaibleTimeModel avaibleTime;
  late CounselorReviewModel counselorReview;
  late CounselorReviewModel counselorReviewLoadMore;

  String selectedTime = '';
  String dateId = '';
  String timeStart = '';
  String timeId = '';
  int currentPages = 1;
  bool? isLogin;

  late SharedPreferences _loginData;
  final CounselorDetailService _counselorDetailService =
      CounselorDetailService();
  final AvaibleTimeService _avaibleTimeService = AvaibleTimeService();
  final CounselorReviewService _counselorReviewService =
      CounselorReviewService();

  Future<void> getCounselorDetail(String id) async {
    try {
      myState = MyState.loading;
      notifyListeners();

      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;

      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        counselorDetail = await _counselorDetailService.getCounselorDetail(
            token: token, id: id);
        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getAvaibleTime(String id) async {
    try {
      myState = MyState.loading;
      notifyListeners();

      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;

      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        avaibleTime =
            await _avaibleTimeService.getAvaibleTime(token: token, id: id);
        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void setSelectedTime(
      {String? id, String? dateID, String? timeID, String? timeStart}) {
    try {
      myState = MyState.loading;
      selectedTime = id ?? '';
      dateId = dateID ?? '';
      timeId = timeID ?? '';
      timeStart = timeStart ?? '';
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getCustomerReview(String id) async {
    try {
      myState = MyState.loading;
      notifyListeners();
      currentPages = 1;
      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;
      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        counselorReview = await _counselorReviewService.getCounselorReview(
          token: token,
          id: id,
          currentPage: currentPages,
        );
        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadMoreCustomerReview(String id) async {
    try {
      myState = MyState.loading;
      notifyListeners();
      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;
      currentPages++;
      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        counselorReviewLoadMore =
            await _counselorReviewService.getCounselorReview(
          token: token,
          id: id,
          currentPage: currentPages,
        );

        counselorReview.reviews?.addAll(counselorReviewLoadMore.reviews!);

        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> checkedIsUserLogin() async {
    _loginData = await SharedPreferences.getInstance();
    String token = _loginData.getString('token') ?? 'notLogged';
    if (token == 'notLogged') {
      isLogin = false;
      myState = MyState.failed;
    } else {
      isLogin = true;
      myState = MyState.loaded;
    }
    notifyListeners();
  }
}
