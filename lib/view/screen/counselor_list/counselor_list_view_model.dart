import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class CounselorListViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List counselorList = [];

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

  String sortValue = 'Highest Rating';

  void filterHighestRating() {
    myState = MyState.loading;
    notifyListeners();

    counselorList = counselorListData;
    counselorList.sort((a, b) => b['rating'].compareTo(a['rating']));
    sortValue = 'Highest Rating';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterHighestPrice() {
    myState = MyState.loading;
    notifyListeners();

    counselorList = counselorListData;
    counselorList.sort((a, b) => b['price'].compareTo(a['price']));
    sortValue = 'Highest Price';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterLowestPrice() {
    myState = MyState.loading;
    notifyListeners();

    counselorList = counselorListData;
    counselorList.sort((a, b) => a['price'].compareTo(b['price']));
    sortValue = 'Lowest Price';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterByName(String name) {
    myState = MyState.loading;
    notifyListeners();

    // filter counselorList from counselorListData
    counselorList = counselorListData
        .where((element) =>
            element['name'].toLowerCase().contains(name.toLowerCase()))
        .toList();

    myState = MyState.loaded;
    notifyListeners();
  }
}
