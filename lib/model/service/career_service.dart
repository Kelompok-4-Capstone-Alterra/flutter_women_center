import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/career_model.dart';
import 'package:dio/dio.dart';

import '../api/endpoint.dart';
import '../detail_career_model.dart';

class CareerService extends InterceptorApi {
  Future<List<CareerModel>> getAllCareer({required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCareer;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<CareerModel> careerList;
      careerList = (response.data['data']['careers'] as List)
          .map((e) => CareerModel.fromJson(e))
          .toList();

      return careerList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CareerModel>> searchCareer(
      {required String token, required String keywords}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCareer;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'search': keywords,
        },
      );
      final List<CareerModel> careerList;
      careerList = (response.data['data']['careers'] as List)
          .map((e) => CareerModel.fromJson(e))
          .toList();

      return careerList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CareerModel>> getCareerSortBy(
      {required String token, required bool sortBy}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCareer;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'sort_by': sortBy == true ? 'newest' : 'highest_salary'
        },
      );
      final careerList = (response.data['data']['careers'] as List)
          .map((e) => CareerModel.fromJson(e))
          .toList();

      return careerList;
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailCareerModel> getCareerById(
      {required String token, required id}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.publicCareer;
      final Response response = await dio.get(
        '$url/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final DetailCareerModel detailCareer;
      detailCareer = DetailCareerModel.fromJson(response.data['data']);
      return detailCareer;
    } catch (e) {
      rethrow;
    }
  }
}
