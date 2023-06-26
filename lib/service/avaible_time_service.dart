import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/avaible_time_model.dart';
import 'package:dio/dio.dart';

class AvaibleTimeService extends InterceptorApi {
  late AvaibleTimeModel avaibleTime;

  Future<AvaibleTimeModel> getAvaibleTime(
      {required String token, required String id}) async {
    try {
      final String url =
          '${Endpoint.baseUrl}${Endpoint.getCounselorDetail}/$id/schedules';
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      avaibleTime =
          AvaibleTimeModel.fromJson(response.data['data']['schedule']);

      return avaibleTime;
    } catch (e) {
      throw Exception(e);
    }
  }
}
