import 'package:capstone_project/service/api/endpoint.dart';
import 'package:capstone_project/service/api/interceptor_api.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:dio/dio.dart';

import '../model/forum_model.dart';

class ForumService extends InterceptorApi {
  Future<List<TopicModel>> getTopics() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicTopics;
      final response = await dio.get(
        url,
      );
      final List<TopicModel> data = (response.data['data']['topics'] as List)
          .map((e) => TopicModel.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> joinForum(
      {required String token, required String forumId}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.forumJoin;
      await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'forum_id': forumId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createForum(
      {required String token, required ForumModel forumData}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.forum;
      await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: forumData.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteForum(
      {required String token, required String forumId}) async {
    try {
      final String url = '${Endpoint.baseUrl}${Endpoint.forum}/$forumId';
      await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateForum(
      {required String token,
      required String forumId,
      required ForumModel forumData}) async {
    try {
      final String url = '${Endpoint.baseUrl}${Endpoint.forum}/$forumId';
      await dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: forumData.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ForumModel>> getAllForum({
    String? topic,
    String? sortBy,
    int? categoryId,
  }) async {
    final Map<String, dynamic> parameter = {};
    if (topic != null) {
      parameter['topic'] = topic;
    }
    if (sortBy != null) {
      parameter['sort_by'] = sortBy;
    }
    if (categoryId != null) {
      parameter['category_id'] = categoryId;
    }
    try {
      const url = Endpoint.baseUrl + Endpoint.publicForum;
      final responser = await dio.get(
        url,
        queryParameters: parameter,
      );
      final List<ForumModel> data = (responser.data['data'] as List)
          .map((e) => ForumModel.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ForumModel>> getMyForum({
    required String token,
    String? topic,
    String? sortBy,
  }) async {
    final Map<String, dynamic> parameter = {'my_forum': 'yes'};
    if (topic != null) {
      parameter['topic'] = topic;
    }
    if (sortBy != null) {
      parameter['sort_by'] = sortBy;
    }
    try {
      const url = Endpoint.baseUrl + Endpoint.forum;
      final responser = await dio.get(
        url,
        queryParameters: parameter,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<ForumModel> data = (responser.data['data'] as List)
          .map((e) => ForumModel.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
