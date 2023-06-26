import 'package:capstone_project/model/service/counseling_topic_service.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:flutter/material.dart';

class CounselingTopicViewModel extends ChangeNotifier {
  MyState myState = MyState.initial;

  List<TopicModel> topics = [];
  int selectedTopic = 0;

  final CounselingTopicService _counselingTopicService =
      CounselingTopicService();

  Future<void> getTopics() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      topics = await _counselingTopicService.getCounselingTopic();
      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> setSelectedTopic(int id) async {
    selectedTopic = id;
    notifyListeners();
  }
}
