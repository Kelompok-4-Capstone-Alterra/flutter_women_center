import 'package:capstone_project/service/api/interceptor_api.dart';
import 'package:capstone_project/model/transactions_model.dart';
import 'package:dio/dio.dart';
import 'api/endpoint.dart';

class TransactionsService extends InterceptorApi {
  ///mengembalikan List<TransactionsModel> berdasarkan status "waiting" atau "completed" dari API transactions
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
      throw e.toString();
    }
  }

  ///mengembalikan List<TransactionsModel> berdasarkan status "waiting" atau "completed" serta berdasarkan "search" dari API transactions
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
      throw e.toString();
    }
  }

  ///mengunggah rating dan review untuk counseling ke API counselors
  Future<String> postReviewCounselor(
      {required String token,
      required String counselorId,
      required String transactionId,
      required int rating,
      required String review}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.counselors;
      late Response response;
      response = await dio.post(
        '$url/$counselorId/reviews',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'transaction_id': transactionId,
          'rating': rating,
          'review': review,
        },
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      throw e.toString();
    }
  }

  ///mengarahkan user ke link counseling melalui API transactions
  Future<String> postUserJoinTransaction(
      {required String token,
      required String userId,
      required String transactionId}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.transactions;
      late Response response;
      response = await dio.post(
        '$url/join',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'user_id': userId,
          'transaction_id': transactionId,
        },
      );
      final String message = response.data['meta']['message'].toString();
      return message;
    } catch (e) {
      throw e.toString();
    }
  }
}
