import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/model/comment_model.dart';
import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/model/topic_model.dart';
import 'package:dio/dio.dart';

class ArticleService extends InterceptorApi {
  late List<TopicModel> topics;
  late List<Articles> articles;
  late List<Comment> comments;
  late List<ReadingListModel> readingListModel;

  Future<List<TopicModel>> getAllTopic() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getTopics;
      Response response = await dio.get(
        url,
      );
      topics = (response.data['data']['topics'] as List)
          .map((e) => TopicModel.fromJson(e))
          .toList();
      return topics;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Articles>> getAllArticles(String token) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticles;
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      articles = (response.data['data']['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return articles;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Articles>> searchArticles(String token, String searchText) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticles;
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'search': searchText,
        },
      );
      articles = (response.data['data']['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return articles;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Articles>> sortArticles(String token, String sortValue) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticles;
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'sort_by': sortValue,
        },
      );
      articles = (response.data['data']['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return articles;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Articles>> getAllArticlesNoLogin({String? search}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticlesNoLogin;
      Response response = await dio.get(url, queryParameters: {
        'search': search ?? '',
      });
      articles = (response.data['data']['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return articles;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Articles>> searchArticlesNonLogin(String searchText) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticlesNoLogin;
      Response response = await dio.get(
        url,
        queryParameters: {
          'search': searchText,
        },
      );
      articles = (response.data['data']['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return articles;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Articles>> sortArticlesNoLogin(String sortValue) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticlesNoLogin;
      Response response = await dio.get(
        url,
        queryParameters: {
          'sort_by': sortValue,
        },
      );
      articles = (response.data['data']['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return articles;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Comment>> getAllComments(String token, String articleId) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticles;

      Response response = await dio.get(
        '$url/$articleId/comments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      comments = (response.data['data']['comments'] as List)
          .map((e) => Comment.fromJson(e))
          .toList();
      return comments;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Comment>> createComment(
      String token, String articleId, Comment comment) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticles;

      Response response = await dio.post(
        '$url/$articleId/comments',
        data: comment.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      comments = (response.data['data']['comments'] as List)
          .map((e) => Comment.fromJson(e))
          .toList();

      return comments;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Comment>> deleteComments(
      String token, String articleId, String commentId) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getArticles;
      Response response = await dio.delete(
        '$url/$articleId/comments/$commentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      comments = (response.data['data']['comments'] as List)
          .map((e) => Comment.fromJson(e))
          .toList();
      return comments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
