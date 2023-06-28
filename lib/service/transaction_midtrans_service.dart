import 'package:capstone_project/service/api/endpoint.dart';
import 'package:capstone_project/service/api/interceptor_api.dart';
import 'package:capstone_project/model/transaction_detail_model.dart';
import 'package:capstone_project/model/transaction_midtrans_model.dart';
import 'package:dio/dio.dart';

class TransactionMidtransService extends InterceptorApi {
  late TransactionMidtransModel transactionMidtrans;
  late TransactionDetailModel transactionDetail;

  Future<TransactionMidtransModel> getTransactionMidtrans({
    required String token,
    required String counselorId,
    required int counselorTopicKey,
    required String consultationDateId,
    required String consultationTimeId,
    required String consultationTimeStart,
    required String consultationMethod,
    required String voucherId,
  }) async {
    try {
      final requestData = {
        'counselor_id': counselorId,
        'counselor_topic_key': counselorTopicKey,
        'consultation_date_id': consultationDateId,
        'consultation_time_id': consultationTimeId,
        'consultation_time_start': consultationTimeStart,
        'consultation_method': consultationMethod,
        'voucher_id': voucherId,
      };
      const String url = Endpoint.baseUrl + Endpoint.postTransaction;
      final Response response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: requestData,
      );

      transactionMidtrans = TransactionMidtransModel.fromJson(response.data);

      return transactionMidtrans;
    } catch (e) {
      if (e is DioException) {}
      rethrow;
    }
  }

  Future<TransactionDetailModel> getTransactionDetail({
    required String token,
    required String transactionId,
  }) async {
    try {
      final String url =
          Endpoint.baseUrl + Endpoint.getTransactionDetail + transactionId;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      transactionDetail = TransactionDetailModel.fromJson(response.data);

      return transactionDetail;
    } catch (e) {
      if (e is DioException) {}
      rethrow;
    }
  }
}
