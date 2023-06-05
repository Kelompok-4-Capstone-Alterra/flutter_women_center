import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class CounselorDetailViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List counselorDetail = [];

  List avaibleTime = [];

  List customerReview = [];

  int selectedTime = 0;

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

  List customerReviewData = [
    {
      'id': 1,
      'counselorId': 1,
      'name': 'John Doe',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 5,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 2,
      'counselorId': 1,
      'name': 'Gerard Way',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 3,
      'counselorId': 2,
      'name': 'Gerard Way',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 4,
      'counselorId': 2,
      'name': 'Mika Maynard',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4.5,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 5,
      'counselorId': 3,
      'name': 'Gerard Way',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 6,
      'counselorId': 4,
      'name': 'Tina Maynard',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4.5,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 7,
      'counselorId': 1,
      'name': 'Gerard Zee',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 8,
      'counselorId': 1,
      'name': 'Gerard Infe',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
    {
      'id': 9,
      'counselorId': 1,
      'name': 'Gerard Way',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      'rating': 4,
      'review':
          'He is a very good listener and has a lot of experience in dealing with various problems. He is also a very friendly person and easy to talk to.',
      'createdAt': '2021-08-01'
    },
  ];

  void getCounselorDetail(int id) {
    try {
      myState = MyState.loading;
      notifyListeners();
      counselorDetail.clear();
      counselorDetail
          .addAll(counselorListData.where((element) => element['id'] == id));
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void getAvaibleTime() {
    try {
      myState = MyState.loading;
      notifyListeners();
      avaibleTime.clear();
      avaibleTime.addAll(avaibleTimeData);
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void setSelectedTime(int id) {
    try {
      selectedTime = id;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void getCustomerReview(int id) {
    try {
      myState = MyState.loading;
      notifyListeners();
      customerReview.clear();
      // count customerReviewData where counselorId == id
      if (customerReviewData
              .where((element) => element['counselorId'] == id)
              .length >
          5) {
        for (int i = 0; i < 5; i++) {
          customerReview.add(customerReviewData
              .where((element) => element['counselorId'] == id)
              .toList()[i]);
        }
      } else {
        customerReview.addAll(customerReviewData
            .where((element) => element['counselorId'] == id)
            .toList());
      }

      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }

  void loadMoreCustomerReview(int id) {
    try {
      myState = MyState.loading;
      notifyListeners();

      if (customerReviewData
              .where((element) => element['counselorId'] == id)
              .length >
          5) {
        for (int i = 0; i < 5; i++) {
          customerReview.add(customerReviewData
              .where((element) => element['counselorId'] == id)
              .toList()[i]);
        }
      } else {
        customerReview.addAll(customerReviewData
            .where((element) => element['counselorId'] == id)
            .toList());
      }

      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
      rethrow;
    }
  }
}
