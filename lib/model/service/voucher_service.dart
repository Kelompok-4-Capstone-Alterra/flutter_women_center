import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/voucher_model.dart';
import 'package:dio/dio.dart';

class VoucherService extends InterceptorApi {
  late List<VoucherModel> voucher;

  Future<List<VoucherModel>> getVoucher(
      {required token, required String id}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.voucher;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      voucher = (response.data['data'] as List)
          .map((e) => VoucherModel.fromJson(e))
          .toList();

      return voucher;
    } catch (e) {
      rethrow;
    }
  }
}
