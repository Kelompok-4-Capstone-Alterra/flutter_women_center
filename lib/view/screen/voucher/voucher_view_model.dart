import 'package:capstone_project/service/voucher_service.dart';
import 'package:capstone_project/model/voucher_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  int selectedVoucher = 0;

  List<VoucherModel> voucher = [];

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
}
