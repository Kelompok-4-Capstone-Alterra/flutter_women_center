import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class CounselingAppointmentViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List counselorDetail = [];

  List availableTime = [];

  List voucher = [];

  int selectedVoucher = 0;

  List useVoucher = [];

  List counselorListData = [
    {
      'id': 1,
      'name': 'Dr. John Doe',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 3,
      'price': 100000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
    {
      'id': 2,
      'name': 'Gena Paulo',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4.5,
      'price': 150000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
    {
      'id': 3,
      'name': 'Zetas Chloe',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 3.5,
      'price': 125000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
    {
      'id': 4,
      'name': 'Andi Zoe',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'price': 150000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
    {
      'id': 5,
      'name': 'Timmoty Doe',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 5,
      'price': 160000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
    {
      'id': 6,
      'name': 'Gregori Yurie',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'price': 134000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
    {
      'id': 7,
      'name': 'Kira Nara',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 3.5,
      'price': 100000,
      'specialist': 'Depression',
      'description':
          'Dr John Doe is a psychologist who has been practicing for 10 years. He has helped many people with their problems. He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
    },
  ];

  List avaibleTimeData = [
    {
      'id': 1,
      'time': '09 : 00',
      'status': 'active',
    },
    {
      'id': 2,
      'time': '12 : 00',
      'status': 'active',
    },
    {
      'id': 3,
      'time': '14 : 00',
      'status': 'notActive',
    },
    {
      'id': 4,
      'time': '16 : 00',
      'status': 'active',
    },
    {
      'id': 5,
      'time': '18 : 00',
      'status': 'active',
    },
    {
      'id': 6,
      'time': '20 : 00',
      'status': 'active',
    },
  ];

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
      'name': 'Counseling Discount Rp 50.000',
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

  num total = 0;

  void getCounselorDetail(int id) {
    myState = MyState.loading;
    notifyListeners();
    try {
      counselorDetail.clear();
      counselorDetail
          .addAll(counselorListData.where((element) => element['id'] == id));
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  void getAvailableTime(int id) {
    myState = MyState.loading;
    notifyListeners();
    try {
      availableTime.clear();
      availableTime.addAll(
          avaibleTimeData.where((element) => element['id'] == id).toList());
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  void setVoucher(int id) {
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
    print(data);
    myState = MyState.loading;
    notifyListeners();
    try {
      if (data['decide'] == 'choose') {
        selectedVoucher = data['id'];
      } else if (data['decide'] == 'cancel') {
        selectedVoucher = 0;
      }
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  void countTotal({
    required int id,
    required int price,
  }) {
    try {
      useVoucher.clear();
      useVoucher
          .addAll(voucherData.where((element) => element['id'] == id).toList());
      if (useVoucher.isNotEmpty) {
        total = price - useVoucher[0]['discount'];
      } else {
        total = price;
      }
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }
}