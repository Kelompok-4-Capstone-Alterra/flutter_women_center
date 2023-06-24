import 'package:capstone_project/model/service/transaction_midtrans_service.dart';
import 'package:capstone_project/model/transaction_detail_model.dart';
import 'package:capstone_project/model/transaction_midtrans_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MidtransViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  late SharedPreferences _loginData;
  final TransactionMidtransService _transactionMidtransService =
      TransactionMidtransService();
  final TransactionMidtransService _getTransactionDetail =
      TransactionMidtransService();

  String consulMethod = '';
  int loadingPercentage = 0;

  TransactionMidtransModel transactionMidtrans = TransactionMidtransModel();
  TransactionDetailModel transactionDetail = TransactionDetailModel();

  Future<void> getMidtrans({
    required String counselorId,
    required int counselorTopicKey,
    required String consultationDateId,
    required String consultationTimeId,
    required String consultationTimeStart,
    required String consultationMethod,
    required String voucherId,
  }) async {
    try {
      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;
      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        myState = MyState.loading;
        notifyListeners();
        if (consultationMethod == "Chat") {
          consulMethod = 'chat';
        } else {
          consulMethod = 'video_call';
        }
        transactionMidtrans =
            await _transactionMidtransService.getTransactionMidtrans(
          token: token,
          counselorId: counselorId,
          counselorTopicKey: counselorTopicKey,
          consultationDateId: consultationDateId,
          consultationTimeId: consultationTimeId,
          consultationTimeStart: consultationTimeStart,
          consultationMethod: consulMethod,
          voucherId: voucherId,
        );
        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> getCounselorDetail({
    required String transactionID,
  }) async {
    try {
      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;
      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        myState = MyState.loading;
        notifyListeners();
        transactionDetail = await _getTransactionDetail.getTransactionDetail(
            token: token, transactionId: transactionID);
        // print(transactionDetail.meta?.message);
        // print(transactionDetail.meta?.status);
        // print(transactionDetail.data?.status);
        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }
}
