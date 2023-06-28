import 'package:capstone_project/model/voucher_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/voucher_service.dart';

class CounselingAppointmentViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List availableTime = [];

  List<VoucherModel> voucher = [];

  String selectedVoucher = '';

  List<VoucherModel> useVoucher = [];

  num total = 0;

  late SharedPreferences _loginData;
  final VoucherService _voucherService = VoucherService();

  Future<void> getVoucher(String id) async {
    myState = MyState.loading;
    notifyListeners();
    try {
      _loginData = await SharedPreferences.getInstance();
      final String token = _loginData.getString('token')!;
      if (token.isEmpty) {
        myState = MyState.failed;
      } else {
        voucher = await _voucherService.getVoucher(token: token, id: id);
        myState = MyState.loaded;
        notifyListeners();
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void setVoucher(String id) {
    myState = MyState.loading;
    notifyListeners();
    try {
      selectedVoucher = id;

      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  void decideVoucher(Map data) {
    myState = MyState.loading;
    notifyListeners();
    try {
      if (data['decide'] == 'choose') {
        selectedVoucher = data['id'];
      } else if (data['decide'] == 'cancel') {
        selectedVoucher = '';
      }
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  void countTotal({
    required String id,
    required int price,
  }) {
    try {
      useVoucher.clear();
      useVoucher.addAll(voucher.where((element) => element.id == id).toList());
      if (useVoucher.isNotEmpty) {
        total = price - useVoucher[0].value!;
        if (total < 0) {
          total = 0;
        }
      } else {
        total = price;
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }
}
