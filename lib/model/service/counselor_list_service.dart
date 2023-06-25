import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/counselor_list_model.dart';
import 'package:dio/dio.dart';

class CounselorListService extends InterceptorApi {
  late List<CounselorListModel> counselingList;

  Future<List<CounselorListModel>> getCounselorList(
      {required token, required int topic, required String sortBy}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getCounselorList;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'topic': topic,
          'sort_by': sortBy,
        },
      );
      counselingList = (response.data['data']['counselors'] as List)
          .map((e) => CounselorListModel.fromJson(e))
          .toList();

      return counselingList;
    } catch (e) {
      rethrow;
    }
  }
}
