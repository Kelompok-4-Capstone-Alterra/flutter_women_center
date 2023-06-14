import 'package:capstone_project/model/service/counseling_topic_service.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounselingTopicViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List<TopicModel> topics = [];
  int selectedTopic = 0;

  late SharedPreferences _loginData;
  final CounselingTopicService _counselingTopicService =
      CounselingTopicService();

  Future<void> getTopics() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      // topics = [
      //   {
      //     "id": 1,
      //     "title": "Self - Development",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 2,
      //     "title": "Spiritual",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 3,
      //     "title": "Family / Relationship",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 4,
      //     "title": "Couple",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 5,
      //     "title": "Career",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 6,
      //     "title": "Depression",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 7,
      //     "title": "Discrimination",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 8,
      //     "title": "Mental Disorder",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 9,
      //     "title": "Sexual Abuse",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      //   {
      //     "id": 10,
      //     "title": "Self Harming Behavior",
      //     "image":
      //         "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
      //   },
      // ];

      _loginData = await SharedPreferences.getInstance();
      final token = _loginData.getString('token') ?? '';
      if (token.isEmpty) {
        myState = MyState.failed;
      }
      topics = await _counselingTopicService.getCounselingTopic(token);
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  void setSelectedTopic(int id) {
    selectedTopic = id;
    notifyListeners();
  }
}
