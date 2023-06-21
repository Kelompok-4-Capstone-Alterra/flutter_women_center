import 'package:capstone_project/model/api/endpoint.dart';
import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/transactions_ongoing_model.dart';
import 'package:dio/dio.dart';

class TransactionsOngoingService extends InterceptorApi {
  Future<List<TransactionsOngoingModel>> getAllTransactionsOngoing(
      {required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.transacton;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<TransactionsOngoingModel> transactionsOngoingModel =
          (response.data['data'] as List)
              .map((e) => TransactionsOngoingModel.fromJson(e))
              .toList();
      print(response.data);
      return transactionsOngoingModel;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
