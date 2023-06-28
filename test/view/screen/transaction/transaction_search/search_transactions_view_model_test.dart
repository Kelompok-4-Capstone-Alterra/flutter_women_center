import 'package:capstone_project/service/transactions_service.dart';
import 'package:capstone_project/model/transactions_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_search/search_transactions_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../transaction_view_model_test.mocks.dart';

@GenerateMocks([TransactionsService])
Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  late MockTransactionsService transactionsService;
  late SearchTransactionsViewModel searchTransactionsViewModel;
  late SharedPreferences loginData;
  late String token;
  final List<TransactionsModel> listOfTransactionsModel = <TransactionsModel>[];

  setUpAll(() async {
    transactionsService = MockTransactionsService();
    searchTransactionsViewModel = SearchTransactionsViewModel();
    loginData = await SharedPreferences.getInstance();
    token = loginData.getString('token') ?? '';
  });

  group('transactions view model test', () {
    test('get all transactions by search and show all transactions by search',
        () async {
      when(transactionsService.getAllTransactionsBySearch(
              token: token, search: 'abc', statusOngoing: true))
          .thenAnswer((_) async {
        return listOfTransactionsModel;
      });
      await searchTransactionsViewModel.showAllTransactionsBySearch(
          search: 'abc', statusOngoing: true);
      expect(searchTransactionsViewModel.allTransactionsDataOngoing,
          listOfTransactionsModel);
      when(transactionsService.getAllTransactionsBySearch(
              token: token, search: 'abc', statusOngoing: false))
          .thenAnswer((_) async {
        return listOfTransactionsModel;
      });
      await searchTransactionsViewModel.showAllTransactionsBySearch(
          search: 'abc', statusOngoing: false);
      expect(searchTransactionsViewModel.allTransactionsDataOngoing,
          listOfTransactionsModel);
    });
  });
}
