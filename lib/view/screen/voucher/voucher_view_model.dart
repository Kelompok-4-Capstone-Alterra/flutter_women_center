import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class VoucherViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  int selectedVoucher = 0;

  List voucher = [];

  List voucherData = [
    {
      'id': 1,
      'type': 'Refund Voucher',
      'name': 'Counseling Discount Rp 50.000',
      'paymentMethod': 'All payment method accepted',
      'discount': 50000,
    },
    {
      'id': 2,
      'type': 'Refund Voucher',
      'name': 'Counseling Discount Rp 50.000',
      'paymentMethod': 'All payment method accepted',
      'discount': 50000,
    },
    {
      'id': 3,
      'type': 'New User Voucher',
      'name': 'Counseling Discount Rp 80.000',
      'paymentMethod': 'All payment method accepted',
      'discount': 80000,
    },
    {
      'id': 4,
      'type': 'Refund Voucher',
      'name': 'Counseling Discount Rp 50.000',
      'paymentMethod': 'All payment method accepted',
      'discount': 50000,
    },
    {
      'id': 5,
      'type': 'Refund Voucher',
      'name': 'Counseling Discount Rp. 50.000',
      'paymentMethod': 'All payment method accepted',
      'discount': 50000,
    },
    {
      'id': 1,
      'type': 'Refund Voucher',
      'name': 'Counseling Discount Rp. 50.000',
      'paymentMethod': 'All payment method accepted',
      'discount': 50000,
    },
  ];
  void getVoucher() {
    myState = MyState.loading;
    notifyListeners();
    try {
      voucher = voucherData;
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void getVoucherById(int id) {
    myState = MyState.loading;
    notifyListeners();
    try {
      selectedVoucher = id;
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }
}
