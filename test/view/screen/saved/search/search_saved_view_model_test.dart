import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/model/service/reading_list_service.dart';
import 'package:capstone_project/view/screen/saved/search/search_saved_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../saved_view_model_test.mocks.dart';

@GenerateMocks([ReadingListService])
Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  late MockReadingListService readingListService;
  late SearchSavedViewModel searchSavedViewModel;
  late SharedPreferences loginData;
  late String token;
  final List<ReadingListModel> listOfReadingListModel = <ReadingListModel>[];

  setUpAll(() async {
    readingListService = MockReadingListService();
    searchSavedViewModel = SearchSavedViewModel();
    loginData = await SharedPreferences.getInstance();
    token = loginData.getString('token') ?? '';
  });

  group('saved view model test', () {
    test('get reading list by name and show all reading list by name',
        () async {
      when(readingListService.getReadingListByName(
              token: token, name: 'Anonim'))
          .thenAnswer((_) async {
        return listOfReadingListModel;
      });
      await searchSavedViewModel.showReadingListByName(name: 'Anonim');
      expect(searchSavedViewModel.allReadingListData, listOfReadingListModel);
    });
  });
}
