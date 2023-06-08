import 'dart:collection';

import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';

import 'package:flutter/material.dart';

class ArticleListProvider extends ChangeNotifier {
  String searchString = '';
  MyState myState = MyState.initial;

  List<Articles> listArticles = [
    Articles(
      title: 'Kakdna Ikljsaldkjl',
      author: 'Manusia',
      date: '2000-04-20',
      category: 'Mental Health',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut arcu ex. Sed eu arcu sed eros faucibus lacinia in non nibh. Proin dui quam, tincidunt ac efficitur eget, ornare eget turpis. Pellentesque laoreet nunc non odio ultricies, nec auctor ipsum vulputate. Sed maximus enim orci, in feugiat leo accumsan eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam erat volutpat. Curabitur ac odio sit amet elit hendrerit porttitor congue at metus. Proin libero ipsum, interdum nec quam sed, consectetur egestas arcu. Maecenas nunc ligula, scelerisque at ornare id, molestie ut velit. Sed vitae tristique est, id ullamcorper magna.\n\nCras vitae sagittis purus. Suspendisse potenti. Duis id tellus rhoncus, consectetur orci sit amet, ultrices mi. Suspendisse scelerisque tristique porttitor. Quisque nec quam sed eros molestie maximus vestibulum at felis. Mauris quis mauris nec augue faucibus consectetur. Sed pretium ornare fermentum. Aenean tristique diam nec est accumsan, a auctor eros placerat. Suspendisse consectetur ligula vitae ex posuere gravida. Pellentesque nisi neque, ullamcorper in risus ac, porttitor varius ante. Ut in velit at est hendrerit porta non sed diam.\n\nPhasellus lacus urna, tristique at cursus feugiat, tincidunt eget metus. Sed molestie, orci at faucibus mollis, arcu tellus tincidunt arcu, nec varius urna augue id ex. Morbi viverra porttitor eros quis dictum. Vivamus molestie lacus eu facilisis suscipit. Aliquam rhoncus diam sed lacus bibendum, suscipit iaculis justo varius. Nullam ultrices consectetur velit, in vehicula est varius eget. Sed dignissim, velit nec lobortis vestibulum, nisl lectus feugiat lorem, at dignissim nunc quam non massa. Ut congue est id luctus tempor. Etiam egestas ex arcu, et pulvinar tortor finibus ut.\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec erat odio, efficitur quis fringilla et, dignissim sit amet purus. Nam ac lacinia nisi, sit amet porta augue. Ut commodo aliquet rhoncus. Nulla in efficitur nibh, quis imperdiet elit. Nulla sagittis justo vel est maximus malesuada. Donec vestibulum dictum diam sed tincidunt. Quisque auctor eros ut placerat pharetra. Nulla eleifend nulla ex, ut pulvinar nunc maximus a.\n\nPraesent faucibus tristique ante et venenatis. Etiam quis venenatis elit. Phasellus eleifend efficitur sapien, non suscipit massa congue a. Integer pretium, nisl in commodo sodales, mauris metus tempus dolor, sit amet efficitur metus dolor vitae arcu. Morbi convallis mi in libero pellentesque laoreet. Phasellus dapibus pretium odio, et finibus enim tristique ac. Nam consectetur ornare lobortis. Morbi id finibus ex. Praesent in arcu non quam vestibulum tristique. Aenean lacinia suscipit nulla sit amet tristique. Ut eu augue in sem facilisis feugiat eu quis ex. Duis sodales quis erat eget accumsan. Donec sapien leo, luctus nec ex nec, condimentum viverra elit. Morbi sed sapien vehicula, vulputate mi egestas, feugiat nisi. Ut luctus ipsum et diam pulvinar convallis. Etiam efficitur quis leo at congue.',
      image: 'assets/images/tes.jpg',
    ),
    Articles(
      title: 'ANnajs AJuisadn',
      author: 'Manusia',
      date: '2000-04-25',
      category: 'Mental Health',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut arcu ex. Sed eu arcu sed eros faucibus lacinia in non nibh. Proin dui quam, tincidunt ac efficitur eget, ornare eget turpis. Pellentesque laoreet nunc non odio ultricies, nec auctor ipsum vulputate. Sed maximus enim orci, in feugiat leo accumsan eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam erat volutpat. Curabitur ac odio sit amet elit hendrerit porttitor congue at metus. Proin libero ipsum, interdum nec quam sed, consectetur egestas arcu. Maecenas nunc ligula, scelerisque at ornare id, molestie ut velit. Sed vitae tristique est, id ullamcorper magna.\n\nCras vitae sagittis purus. Suspendisse potenti. Duis id tellus rhoncus, consectetur orci sit amet, ultrices mi. Suspendisse scelerisque tristique porttitor. Quisque nec quam sed eros molestie maximus vestibulum at felis. Mauris quis mauris nec augue faucibus consectetur. Sed pretium ornare fermentum. Aenean tristique diam nec est accumsan, a auctor eros placerat. Suspendisse consectetur ligula vitae ex posuere gravida. Pellentesque nisi neque, ullamcorper in risus ac, porttitor varius ante. Ut in velit at est hendrerit porta non sed diam.\n\nPhasellus lacus urna, tristique at cursus feugiat, tincidunt eget metus. Sed molestie, orci at faucibus mollis, arcu tellus tincidunt arcu, nec varius urna augue id ex. Morbi viverra porttitor eros quis dictum. Vivamus molestie lacus eu facilisis suscipit. Aliquam rhoncus diam sed lacus bibendum, suscipit iaculis justo varius. Nullam ultrices consectetur velit, in vehicula est varius eget. Sed dignissim, velit nec lobortis vestibulum, nisl lectus feugiat lorem, at dignissim nunc quam non massa. Ut congue est id luctus tempor. Etiam egestas ex arcu, et pulvinar tortor finibus ut.\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec erat odio, efficitur quis fringilla et, dignissim sit amet purus. Nam ac lacinia nisi, sit amet porta augue. Ut commodo aliquet rhoncus. Nulla in efficitur nibh, quis imperdiet elit. Nulla sagittis justo vel est maximus malesuada. Donec vestibulum dictum diam sed tincidunt. Quisque auctor eros ut placerat pharetra. Nulla eleifend nulla ex, ut pulvinar nunc maximus a.\n\nPraesent faucibus tristique ante et venenatis. Etiam quis venenatis elit. Phasellus eleifend efficitur sapien, non suscipit massa congue a. Integer pretium, nisl in commodo sodales, mauris metus tempus dolor, sit amet efficitur metus dolor vitae arcu. Morbi convallis mi in libero pellentesque laoreet. Phasellus dapibus pretium odio, et finibus enim tristique ac. Nam consectetur ornare lobortis. Morbi id finibus ex. Praesent in arcu non quam vestibulum tristique. Aenean lacinia suscipit nulla sit amet tristique. Ut eu augue in sem facilisis feugiat eu quis ex. Duis sodales quis erat eget accumsan. Donec sapien leo, luctus nec ex nec, condimentum viverra elit. Morbi sed sapien vehicula, vulputate mi egestas, feugiat nisi. Ut luctus ipsum et diam pulvinar convallis. Etiam efficitur quis leo at congue.',
      image: 'assets/images/tes.jpg',
    ),
    Articles(
      title: 'Lapmah Hana',
      author: 'Manusia',
      date: '2000-04-15',
      category: 'Spiritual',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut arcu ex. Sed eu arcu sed eros faucibus lacinia in non nibh. Proin dui quam, tincidunt ac efficitur eget, ornare eget turpis. Pellentesque laoreet nunc non odio ultricies, nec auctor ipsum vulputate. Sed maximus enim orci, in feugiat leo accumsan eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam erat volutpat. Curabitur ac odio sit amet elit hendrerit porttitor congue at metus. Proin libero ipsum, interdum nec quam sed, consectetur egestas arcu. Maecenas nunc ligula, scelerisque at ornare id, molestie ut velit. Sed vitae tristique est, id ullamcorper magna.\n\nCras vitae sagittis purus. Suspendisse potenti. Duis id tellus rhoncus, consectetur orci sit amet, ultrices mi. Suspendisse scelerisque tristique porttitor. Quisque nec quam sed eros molestie maximus vestibulum at felis. Mauris quis mauris nec augue faucibus consectetur. Sed pretium ornare fermentum. Aenean tristique diam nec est accumsan, a auctor eros placerat. Suspendisse consectetur ligula vitae ex posuere gravida. Pellentesque nisi neque, ullamcorper in risus ac, porttitor varius ante. Ut in velit at est hendrerit porta non sed diam.\n\nPhasellus lacus urna, tristique at cursus feugiat, tincidunt eget metus. Sed molestie, orci at faucibus mollis, arcu tellus tincidunt arcu, nec varius urna augue id ex. Morbi viverra porttitor eros quis dictum. Vivamus molestie lacus eu facilisis suscipit. Aliquam rhoncus diam sed lacus bibendum, suscipit iaculis justo varius. Nullam ultrices consectetur velit, in vehicula est varius eget. Sed dignissim, velit nec lobortis vestibulum, nisl lectus feugiat lorem, at dignissim nunc quam non massa. Ut congue est id luctus tempor. Etiam egestas ex arcu, et pulvinar tortor finibus ut.\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec erat odio, efficitur quis fringilla et, dignissim sit amet purus. Nam ac lacinia nisi, sit amet porta augue. Ut commodo aliquet rhoncus. Nulla in efficitur nibh, quis imperdiet elit. Nulla sagittis justo vel est maximus malesuada. Donec vestibulum dictum diam sed tincidunt. Quisque auctor eros ut placerat pharetra. Nulla eleifend nulla ex, ut pulvinar nunc maximus a.\n\nPraesent faucibus tristique ante et venenatis. Etiam quis venenatis elit. Phasellus eleifend efficitur sapien, non suscipit massa congue a. Integer pretium, nisl in commodo sodales, mauris metus tempus dolor, sit amet efficitur metus dolor vitae arcu. Morbi convallis mi in libero pellentesque laoreet. Phasellus dapibus pretium odio, et finibus enim tristique ac. Nam consectetur ornare lobortis. Morbi id finibus ex. Praesent in arcu non quam vestibulum tristique. Aenean lacinia suscipit nulla sit amet tristique. Ut eu augue in sem facilisis feugiat eu quis ex. Duis sodales quis erat eget accumsan. Donec sapien leo, luctus nec ex nec, condimentum viverra elit. Morbi sed sapien vehicula, vulputate mi egestas, feugiat nisi. Ut luctus ipsum et diam pulvinar convallis. Etiam efficitur quis leo at congue.',
      image: 'assets/images/tes.jpg',
    ),
    Articles(
      title: 'Jauq asd',
      author: 'Manusia',
      date: '2000-05-21',
      category: 'Self Improvement',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut arcu ex. Sed eu arcu sed eros faucibus lacinia in non nibh. Proin dui quam, tincidunt ac efficitur eget, ornare eget turpis. Pellentesque laoreet nunc non odio ultricies, nec auctor ipsum vulputate. Sed maximus enim orci, in feugiat leo accumsan eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam erat volutpat. Curabitur ac odio sit amet elit hendrerit porttitor congue at metus. Proin libero ipsum, interdum nec quam sed, consectetur egestas arcu. Maecenas nunc ligula, scelerisque at ornare id, molestie ut velit. Sed vitae tristique est, id ullamcorper magna.\n\nCras vitae sagittis purus. Suspendisse potenti. Duis id tellus rhoncus, consectetur orci sit amet, ultrices mi. Suspendisse scelerisque tristique porttitor. Quisque nec quam sed eros molestie maximus vestibulum at felis. Mauris quis mauris nec augue faucibus consectetur. Sed pretium ornare fermentum. Aenean tristique diam nec est accumsan, a auctor eros placerat. Suspendisse consectetur ligula vitae ex posuere gravida. Pellentesque nisi neque, ullamcorper in risus ac, porttitor varius ante. Ut in velit at est hendrerit porta non sed diam.\n\nPhasellus lacus urna, tristique at cursus feugiat, tincidunt eget metus. Sed molestie, orci at faucibus mollis, arcu tellus tincidunt arcu, nec varius urna augue id ex. Morbi viverra porttitor eros quis dictum. Vivamus molestie lacus eu facilisis suscipit. Aliquam rhoncus diam sed lacus bibendum, suscipit iaculis justo varius. Nullam ultrices consectetur velit, in vehicula est varius eget. Sed dignissim, velit nec lobortis vestibulum, nisl lectus feugiat lorem, at dignissim nunc quam non massa. Ut congue est id luctus tempor. Etiam egestas ex arcu, et pulvinar tortor finibus ut.\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec erat odio, efficitur quis fringilla et, dignissim sit amet purus. Nam ac lacinia nisi, sit amet porta augue. Ut commodo aliquet rhoncus. Nulla in efficitur nibh, quis imperdiet elit. Nulla sagittis justo vel est maximus malesuada. Donec vestibulum dictum diam sed tincidunt. Quisque auctor eros ut placerat pharetra. Nulla eleifend nulla ex, ut pulvinar nunc maximus a.\n\nPraesent faucibus tristique ante et venenatis. Etiam quis venenatis elit. Phasellus eleifend efficitur sapien, non suscipit massa congue a. Integer pretium, nisl in commodo sodales, mauris metus tempus dolor, sit amet efficitur metus dolor vitae arcu. Morbi convallis mi in libero pellentesque laoreet. Phasellus dapibus pretium odio, et finibus enim tristique ac. Nam consectetur ornare lobortis. Morbi id finibus ex. Praesent in arcu non quam vestibulum tristique. Aenean lacinia suscipit nulla sit amet tristique. Ut eu augue in sem facilisis feugiat eu quis ex. Duis sodales quis erat eget accumsan. Donec sapien leo, luctus nec ex nec, condimentum viverra elit. Morbi sed sapien vehicula, vulputate mi egestas, feugiat nisi. Ut luctus ipsum et diam pulvinar convallis. Etiam efficitur quis leo at congue.',
      image: 'assets/images/tes.jpg',
    ),
    Articles(
      title: 'Ybna Kqiso',
      author: 'Manusia',
      date: '2001-02-29',
      category: 'Spiritual',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut arcu ex. Sed eu arcu sed eros faucibus lacinia in non nibh. Proin dui quam, tincidunt ac efficitur eget, ornare eget turpis. Pellentesque laoreet nunc non odio ultricies, nec auctor ipsum vulputate. Sed maximus enim orci, in feugiat leo accumsan eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam erat volutpat. Curabitur ac odio sit amet elit hendrerit porttitor congue at metus. Proin libero ipsum, interdum nec quam sed, consectetur egestas arcu. Maecenas nunc ligula, scelerisque at ornare id, molestie ut velit. Sed vitae tristique est, id ullamcorper magna.\n\nCras vitae sagittis purus. Suspendisse potenti. Duis id tellus rhoncus, consectetur orci sit amet, ultrices mi. Suspendisse scelerisque tristique porttitor. Quisque nec quam sed eros molestie maximus vestibulum at felis. Mauris quis mauris nec augue faucibus consectetur. Sed pretium ornare fermentum. Aenean tristique diam nec est accumsan, a auctor eros placerat. Suspendisse consectetur ligula vitae ex posuere gravida. Pellentesque nisi neque, ullamcorper in risus ac, porttitor varius ante. Ut in velit at est hendrerit porta non sed diam.\n\nPhasellus lacus urna, tristique at cursus feugiat, tincidunt eget metus. Sed molestie, orci at faucibus mollis, arcu tellus tincidunt arcu, nec varius urna augue id ex. Morbi viverra porttitor eros quis dictum. Vivamus molestie lacus eu facilisis suscipit. Aliquam rhoncus diam sed lacus bibendum, suscipit iaculis justo varius. Nullam ultrices consectetur velit, in vehicula est varius eget. Sed dignissim, velit nec lobortis vestibulum, nisl lectus feugiat lorem, at dignissim nunc quam non massa. Ut congue est id luctus tempor. Etiam egestas ex arcu, et pulvinar tortor finibus ut.\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec erat odio, efficitur quis fringilla et, dignissim sit amet purus. Nam ac lacinia nisi, sit amet porta augue. Ut commodo aliquet rhoncus. Nulla in efficitur nibh, quis imperdiet elit. Nulla sagittis justo vel est maximus malesuada. Donec vestibulum dictum diam sed tincidunt. Quisque auctor eros ut placerat pharetra. Nulla eleifend nulla ex, ut pulvinar nunc maximus a.\n\nPraesent faucibus tristique ante et venenatis. Etiam quis venenatis elit. Phasellus eleifend efficitur sapien, non suscipit massa congue a. Integer pretium, nisl in commodo sodales, mauris metus tempus dolor, sit amet efficitur metus dolor vitae arcu. Morbi convallis mi in libero pellentesque laoreet. Phasellus dapibus pretium odio, et finibus enim tristique ac. Nam consectetur ornare lobortis. Morbi id finibus ex. Praesent in arcu non quam vestibulum tristique. Aenean lacinia suscipit nulla sit amet tristique. Ut eu augue in sem facilisis feugiat eu quis ex. Duis sodales quis erat eget accumsan. Donec sapien leo, luctus nec ex nec, condimentum viverra elit. Morbi sed sapien vehicula, vulputate mi egestas, feugiat nisi. Ut luctus ipsum et diam pulvinar convallis. Etiam efficitur quis leo at congue.',
      image: 'assets/images/tes.jpg',
    ),
  ];

  UnmodifiableListView<Articles> get articles =>
      UnmodifiableListView(listArticles.where((item) =>
          item.title.toLowerCase().contains(searchString.toLowerCase()) &&
          (filteredCategory == 'All' || item.category == filteredCategory)));

  void changeSearchString(String value) {
    if (value.isEmpty) {
      searchString = '';
    } else {
      searchString = value.toLowerCase();
    }
    notifyListeners();
  }

  String sortValue = 'Most Viewed';

  void filterMostViewed() {
    myState = MyState.loading;
    notifyListeners();

    sortValue = 'Most Viewed';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterNewest() {
    myState = MyState.loading;
    notifyListeners();

    listArticles.sort(
        (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));

    sortValue = 'Newest';

    myState = MyState.loaded;
    notifyListeners();
  }

  void filterOldest() {
    myState = MyState.loading;
    notifyListeners();

    listArticles.sort(
        (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

    sortValue = 'Oldest';

    myState = MyState.loaded;
    notifyListeners();
  }

  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void changeSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  String get filteredCategory {
    if (_selectedTab == 0) {
      return 'All';
    } else {
      return [
        'Mental Health',
        'Self Improvement',
        'Spiritual'
      ][_selectedTab - 1];
    }
  }

  List<Articles> get filteredArticles {
    final selectedCategory = filteredCategory;
    if (_selectedTab == 0) {
      return listArticles;
    } else {
      return listArticles
          .where((article) => article.category == selectedCategory)
          .toList();
    }
  }
}
