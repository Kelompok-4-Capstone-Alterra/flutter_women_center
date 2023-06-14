import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:dio/dio.dart';

class CounselingTopicService extends InterceptorApi {
  late List<TopicModel> topics;

  Future<List<TopicModel>> getCounselingTopic(String token) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getTopics;
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      topics = (response.data['data']['topics'] as List)
          .map((e) => TopicModel.fromJson(e))
          .toList();
      return topics;
    } catch (e) {
      rethrow;
    }
  }
}
