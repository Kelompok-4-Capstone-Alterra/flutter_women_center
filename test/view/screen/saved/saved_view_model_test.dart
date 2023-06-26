import 'package:capstone_project/model/reading_list_model.dart';
import 'package:capstone_project/service/reading_list_service.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'saved_view_model_test.mocks.dart';

@GenerateMocks([ReadingListService])
Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  late MockReadingListService readingListService;
  late SavedViewModel savedViewModel;
  late SharedPreferences loginData;
  late String token;
  final List<ReadingListModel> listOfReadingListModel = <ReadingListModel>[];

  setUpAll(() async {
    readingListService = MockReadingListService();
    savedViewModel = SavedViewModel();
    loginData = await SharedPreferences.getInstance();
    token = loginData.getString('token') ?? '';
  });

  group('saved view model test', () {
    test('get all reading list and show all reading list', () async {
      when(readingListService.getAllReadingList(token: token))
          .thenAnswer((_) async {
        return listOfReadingListModel;
      });
      await savedViewModel.showAllReadingList();
      expect(savedViewModel.allReadingListData, listOfReadingListModel);
    });

    test(
        'get reading list sort by oldest or newest and show all reading list sort by oldest or newest',
        () async {
      //sort by oldest
      when(readingListService.getReadingListSortByOldestOrNewest(
              token: token, sortByOldest: true))
          .thenAnswer((_) async {
        return listOfReadingListModel;
      });
      await savedViewModel.showReadingListSortByOldestOrNewest(
          sortByOldest: true);
      expect(savedViewModel.allReadingListData, listOfReadingListModel);
      //sort by newest
      when(readingListService.getReadingListSortByOldestOrNewest(
              token: token, sortByOldest: false))
          .thenAnswer((_) async {
        return listOfReadingListModel;
      });
      await savedViewModel.showReadingListSortByOldestOrNewest(
          sortByOldest: false);
      expect(savedViewModel.allReadingListData, listOfReadingListModel);
    });
  });
}
