import 'package:capstone_project/service/transactions_service.dart';
import 'package:capstone_project/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/state/finite_state.dart';

class SearchTransactionsViewModel with ChangeNotifier {
  List<bool> counselorRate = [false, false, false, false, false];
  int counselorTotalRate = 0;

  late SharedPreferences _loginData;
  MyState _state = MyState.initial;
  String _message = '';
  final TransactionsService _transactionsService = TransactionsService();
  List<TransactionsModel> _allTransactionsDataOngoing = <TransactionsModel>[];
  List<TransactionsModel> _allTransactionsDataHistory = <TransactionsModel>[];

  MyState get state => _state;
  String get message => _message;
  List<TransactionsModel> get allTransactionsDataOngoing =>
      _allTransactionsDataOngoing;
  List<TransactionsModel> get allTransactionsDataHistory =>
      _allTransactionsDataHistory;

  List<String> chipLabel = ['Ongoing', 'History'];
  int? value;

  changeChoiceChip(int index) {
    value = index;
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

  void changeState(MyState state) {
    _state = state;
    notifyListeners();
  }

  ///menampilkan semua transaksi berdasarkan "search" dan status "waiting" serta "completed" dari service transactions
  Future<void> showAllTransactionsBySearch({
    required bool statusOngoing,
    required String search,
  }) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';

      if (statusOngoing == true) {
        _allTransactionsDataOngoing =
            await _transactionsService.getAllTransactionsBySearch(
          token: token,
          statusOngoing: true,
          search: search,
        );
      }
      if (statusOngoing == false) {
        _allTransactionsDataHistory =
            await _transactionsService.getAllTransactionsBySearch(
          token: token,
          statusOngoing: false,
          search: search,
        );
      }
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  ///melakukan rating dan review counseling ke service transactions
  Future<void> createRateAndReviewCounselor({
    required String counselorId,
    required String transactionsId,
    required int rating,
    required String review,
  }) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _transactionsService.postReviewCounselor(
          token: token,
          counselorId: counselorId,
          transactionId: transactionsId,
          rating: rating,
          review: review);
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  ///mengarahkan user berdasarkan tombol link dari service transactions
  Future<void> linkToCounseling({
    required String? userId,
    required String? transactionId,
  }) async {
    try {
      changeState(MyState.loading);
      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      await _transactionsService.postUserJoinTransaction(
        token: token,
        userId: userId ?? '',
        transactionId: transactionId ?? '',
      );
      changeState(MyState.loaded);
    } catch (e) {
      _message = e.toString();
      changeState(MyState.failed);
    }
  }

  void emptySearch() {
    changeState(MyState.loading);
    allTransactionsDataOngoing.clear();
    allTransactionsDataHistory.clear();
    changeState(MyState.loaded);
  }
}
