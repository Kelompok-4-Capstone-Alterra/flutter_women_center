import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/counselor_review_model.dart';
import 'package:dio/dio.dart';

class CounselorReviewService extends InterceptorApi {
  late CounselorReviewModel counselorReview;

  Future<CounselorReviewModel> getCounselorReview(
      {required String token,
      required String id,
      required int currentPage}) async {
    try {
      final String url =
          '${Endpoint.baseUrl}${Endpoint.getCounselorDetail}/$id/reviews';
      final Response response = await dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          queryParameters: {
            'page': currentPage,
          });

      counselorReview = CounselorReviewModel.fromJson(response.data['data']);

      return counselorReview;
    } catch (e) {
      rethrow;
    }
  }
}
