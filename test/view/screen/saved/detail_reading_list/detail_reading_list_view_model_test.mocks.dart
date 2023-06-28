// Mocks generated by Mockito 5.4.0 from annotations
// in capstone_project/test/view/screen/saved/detail_reading_list/detail_reading_list_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:capstone_project/model/reading_list_model.dart' as _i3;
import 'package:capstone_project/service/reading_list_service.dart'
    as _i4;
import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeReadingListModel_1 extends _i1.SmartFake
    implements _i3.ReadingListModel {
  _FakeReadingListModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ReadingListService].
///
/// See the documentation for Mockito's code generation for more information.
class MockReadingListService extends _i1.Mock
    implements _i4.ReadingListService {
  MockReadingListService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);
  @override
  _i5.Future<List<_i3.ReadingListModel>> getAllReadingList(
          {required String? token}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllReadingList,
          [],
          {#token: token},
        ),
        returnValue: _i5.Future<List<_i3.ReadingListModel>>.value(
            <_i3.ReadingListModel>[]),
      ) as _i5.Future<List<_i3.ReadingListModel>>);
  @override
  _i5.Future<List<_i3.ReadingListModel>> getReadingListByName({
    required String? token,
    required String? name,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getReadingListByName,
          [],
          {
            #token: token,
            #name: name,
          },
        ),
        returnValue: _i5.Future<List<_i3.ReadingListModel>>.value(
            <_i3.ReadingListModel>[]),
      ) as _i5.Future<List<_i3.ReadingListModel>>);
  @override
  _i5.Future<_i3.ReadingListModel> getReadingList({
    required String? token,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getReadingList,
          [],
          {
            #token: token,
            #id: id,
          },
        ),
        returnValue:
            _i5.Future<_i3.ReadingListModel>.value(_FakeReadingListModel_1(
          this,
          Invocation.method(
            #getReadingList,
            [],
            {
              #token: token,
              #id: id,
            },
          ),
        )),
      ) as _i5.Future<_i3.ReadingListModel>);
  @override
  _i5.Future<List<_i3.ReadingListModel>> getReadingListSortByOldestOrNewest({
    required String? token,
    required bool? sortByOldest,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getReadingListSortByOldestOrNewest,
          [],
          {
            #token: token,
            #sortByOldest: sortByOldest,
          },
        ),
        returnValue: _i5.Future<List<_i3.ReadingListModel>>.value(
            <_i3.ReadingListModel>[]),
      ) as _i5.Future<List<_i3.ReadingListModel>>);
  @override
  _i5.Future<String> postReadingList({
    required String? token,
    required String? name,
    required String? description,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postReadingList,
          [],
          {
            #token: token,
            #name: name,
            #description: description,
          },
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> postArticleToReadingList({
    required String? token,
    required String? readingListId,
    required String? articleId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postArticleToReadingList,
          [],
          {
            #token: token,
            #readingListId: readingListId,
            #articleId: articleId,
          },
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> putReadingList({
    required String? token,
    required String? id,
    required String? name,
    required String? description,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #putReadingList,
          [],
          {
            #token: token,
            #id: id,
            #name: name,
            #description: description,
          },
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> deleteReadingList({
    required String? token,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteReadingList,
          [],
          {
            #token: token,
            #id: id,
          },
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> deleteArticleFromReadingList({
    required String? token,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteArticleFromReadingList,
          [],
          {
            #token: token,
            #id: id,
          },
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
}
