import 'package:capstone_project/service/api/endpoint.dart';
import 'package:capstone_project/service/api/interceptor_api.dart';
import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/model/career_model.dart';
import 'package:capstone_project/model/counselor_list_model.dart';
import 'package:capstone_project/model/forum_model.dart';

class HomeService extends InterceptorApi {
  Future<List<Articles>> getArticles() async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicArticles;
      final response = await dio.get(
        url,
      );
      final List<Articles> data = (response.data["data"]["articles"] as List)
          .map((e) => Articles.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CounselorListModel>> getCounselor({String? search}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCounselor;
      final response = await dio.get(url, queryParameters: {
        'search': search,
      });
      final List<CounselorListModel> data =
          (response.data["data"]["counselors"] as List)
              .map((e) => CounselorListModel.fromJson(e))
              .toList();
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CareerModel>> getCareer({String? search}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCareer;
      final response = await dio.get(url, queryParameters: {
        'search': search,
      });
      final List<CareerModel> data = (response.data["data"]["careers"] as List)
          .map((e) => CareerModel.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      throw Exception(e);
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
      throw Exception(e);
    }
  }
}
