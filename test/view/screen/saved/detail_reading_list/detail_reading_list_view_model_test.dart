import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../saved_view_model_test.mocks.dart';

@GenerateMocks([ReadingListService])
Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  late MockReadingListService readingListService;
  late DetailReadingListViewmodel detailReadingListViewmodel;
  late SharedPreferences loginData;
  late String token;
  final ReadingListModel readingListModel = ReadingListModel();

  setUpAll(() async {
    readingListService = MockReadingListService();
    detailReadingListViewmodel = DetailReadingListViewmodel();
    loginData = await SharedPreferences.getInstance();
    token = loginData.getString('token') ?? '';
  });

  group('saved view model test', () {
    test('get detail reading list and show detail reading list', () async {
      when(readingListService.getReadingList(token: token, id: 'abc-123'))
          .thenAnswer((_) async {
        return readingListModel;
      });
      await detailReadingListViewmodel.showReadingList(id: 'abc-123');
      expect(detailReadingListViewmodel.readingListData, readingListModel);
    });
  });
}
