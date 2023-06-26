import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/counselor_detail_model.dart';
import 'package:dio/dio.dart';

class CounselorDetailService extends InterceptorApi {
  late CounselorDetailModel counselorDetail;

  Future<CounselorDetailModel> getCounselorDetail(
      {required token, required String id}) async {
    try {
      final String url =
          '${Endpoint.baseUrl}${Endpoint.getCounselorDetail}/$id';
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      counselorDetail =
          CounselorDetailModel.fromJson(response.data['data']['counselor']);

      return counselorDetail;
    } catch (e) {
      throw Exception(e);
    }
  }
}
