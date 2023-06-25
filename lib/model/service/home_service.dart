import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/forum_model.dart';
import 'package:capstone_project/model/mock_model.dart';

class HomeService extends InterceptorApi {
  Future<List<ArticlesMock>> getArticles() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicArticles;
      final response = await dio.get(
        url,
      );
      final List<ArticlesMock> data =
          (response.data["data"]["articles"] as List)
              .map((e) => ArticlesMock.fromJson(e))
              .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CounselorMock>> getCounselor() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCounselor;
      final response = await dio.get(
        url,
      );
      final List<CounselorMock> data =
          (response.data["data"]["counselors"] as List)
              .map((e) => CounselorMock.fromJson(e))
              .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CareerMock>> getCareer() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCareer;
      final response = await dio.get(
        url,
      );
      final List<CareerMock> data = (response.data["data"]["careers"] as List)
          .map((e) => CareerMock.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ForumModel>> getForum() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicForum;
      final response = await dio.get(url, queryParameters: {
        'sort_by': 'newest',
      });
      final List<ForumModel> data = (response.data["data"] as List)
          .map((e) => ForumModel.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}