import 'package:capstone_project/model/api/interceptor_api.dart';
import 'package:capstone_project/model/transactions_model.dart';
import 'package:dio/dio.dart';
import '../api/endpoint.dart';

class TransactionsService extends InterceptorApi {
  Future<List<TransactionsModel>> getAllTransactions(
      {required String token, required bool statusOngoing}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.transactions;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'status': statusOngoing == true ? 'waiting' : 'completed'
        },
      );
      final List<TransactionsModel> transactionsOngoingModel =
          (response.data['data'] as List)
              .map((e) => TransactionsModel.fromJson(e))
              .toList();
      return transactionsOngoingModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionsModel>> getAllTransactionsBySearch(
      {required String token,
      required bool statusOngoing,
      required String search}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.transactions;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          'status': statusOngoing == true ? 'waiting' : 'completed',
          'search': search,
        },
      );
      final List<TransactionsModel> transactionsOngoingModel =
          (response.data['data'] as List)
              .map((e) => TransactionsModel.fromJson(e))
              .toList();
      return transactionsOngoingModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> postReviewCounselor(
      {required String token,
      required String transactionsId,
      required int rating,
      required String review}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.counselors;
      late Response response;
      response = await dio.post(
        '$url/$transactionsId/reviews',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'transaction_id': transactionsId,
          'rating': rating,
          'review': review,
        },
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      rethrow;
    }
  }
}
