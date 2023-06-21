import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/reading_list_model.dart';
import 'package:dio/dio.dart';
import '../api/endpoint.dart';

class ReadingListService extends InterceptorApi {
  Future<List<ReadingListModel>> getAllReadingList(
      {required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.readingLists;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<ReadingListModel> readingListModel =
          (response.data['data']['reading_list'] as List)
              .map((e) => ReadingListModel.fromJson(e))
              .toList();
      return readingListModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReadingListModel>> getReadingListByName(
      {required String token, required String name}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.readingLists;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {'name': name},
      );
      final List<ReadingListModel> readingListModel =
          (response.data['data']['reading_list'] as List)
              .map((e) => ReadingListModel.fromJson(e))
              .toList();
      return readingListModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<ReadingListModel> getReadingList(
      {required String token, required String id}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.readingLists;
      final Response response = await dio.get(
        '$url/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final ReadingListModel readingListModel =
          ReadingListModel.fromJson(response.data['data']);
      return readingListModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReadingListModel>> getReadingListSortByOldestOrNewest(
      {required String token, required bool sortByOldest}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.readingLists;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'sort_by': sortByOldest == true ? 'oldest' : 'newest'
        },
      );
      final List<ReadingListModel> readingListModel =
          (response.data['data']['reading_list'] as List)
              .map((e) => ReadingListModel.fromJson(e))
              .toList();
      return readingListModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> postReadingList(
      {required String token,
      required String name,
      required String description}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.readingLists;
      late Response response;
      response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'name': name,
          'description': description,
        },
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> putReadingList(
      {required String token,
      required String id,
      required String name,
      required String description}) async {
    try {
      String url = Endpoint.baseUrl + Endpoint.readingLists;
      late Response response;
      response = await dio.put(
        '$url/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'name': name,
          'description': description,
        },
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteReadingList(
      {required String token, required String id}) async {
    try {
      String url = Endpoint.baseUrl + Endpoint.readingLists;
      final Response response = await dio.delete(
        '$url/save/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteArticleFromReadingList(
      {required String token, required String id}) async {
    try {
      String url = Endpoint.baseUrl + Endpoint.readingLists;
      final Response response = await dio.delete(
        '$url/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }
}
