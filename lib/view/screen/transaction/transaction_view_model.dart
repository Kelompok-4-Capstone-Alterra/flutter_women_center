import 'package:capstone_project/model/service/transactions_ongoing_service.dart';
import 'package:capstone_project/model/transactions_ongoing_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/state/finite_state.dart';

class TransactionViewModel with ChangeNotifier {
  List<bool> counselorRate = [false, false, false, false, false];
  List<bool> history = [false, false, false, false, false, false];
  int counselorTotalRate = 0;
  bool ratingDone = false;

  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final TransactionsOngoingService _transactionsOngoingService =
      TransactionsOngoingService();
  List<TransactionsOngoingModel> _allTransactionsOngoingData =
      <TransactionsOngoingModel>[];

  MyState get state => _state;
  String get message => _message;
  List<TransactionsOngoingModel> get allTransactionsOngoingData =>
      _allTransactionsOngoingData;

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  void changeCounselorRate(int index) {
    if (counselorRate[index] == false) {
      for (int i = 0; i <= index; i++) {
        counselorRate[i] = true;
      }
    } else {
      for (int i = 0; i < counselorRate.length; i++) {
        if (counselorRate[i] == true) {
          counselorTotalRate++;
        }
      }
      for (int i = index + 1; i < counselorTotalRate; i++) {
        counselorRate[i] = false;
      }
    }
    counselorTotalRate = 0;
    notifyListeners();
  }

  void changeRatingStatus(int index) {
    history[index] = true;
    notifyListeners();
  }

  Future<void> showAllTransactionsOngoing() async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      _allTransactionsOngoingData = await _transactionsOngoingService
          .getAllTransactionsOngoing(token: token);
      print(_allTransactionsOngoingData);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      print(e.toString());
      changeState(MyState.failed);
    }
  }
}
