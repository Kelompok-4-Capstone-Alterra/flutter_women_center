import 'package:capstone_project/model/service/transactions_service.dart';
import 'package:capstone_project/model/transactions_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_view_model_test.mocks.dart';

@GenerateMocks([TransactionsService])
Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  late MockTransactionsService transactionsService;
  late TransactionViewModel transactionViewModel;
  late SharedPreferences loginData;
  late String token;
  final List<TransactionsModel> listOfTransactionsModel = <TransactionsModel>[];

  setUpAll(() async {
    transactionsService = MockTransactionsService();
    transactionViewModel = TransactionViewModel();
    loginData = await SharedPreferences.getInstance();
    token = loginData.getString('token') ?? '';
  });

  group('transactions view model test', () {
    test('get all transactions and show all transactions', () async {
      when(transactionsService.getAllTransactions(
              token: token, statusOngoing: true))
          .thenAnswer((_) async {
        return listOfTransactionsModel;
      });
      await transactionViewModel.showAllTransactions(statusOngoing: true);
      expect(transactionViewModel.allTransactionsDataOngoing,
          listOfTransactionsModel);
      when(transactionsService.getAllTransactions(
              token: token, statusOngoing: false))
          .thenAnswer((_) async {
        return listOfTransactionsModel;
      });
      await transactionViewModel.showAllTransactions(statusOngoing: false);
      expect(transactionViewModel.allTransactionsDataHistory,
          listOfTransactionsModel);
    });
  });
}
