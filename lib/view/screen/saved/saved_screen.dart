import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/buttons/floating_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/buttons/primary_button_icon.dart';
import 'package:capstone_project/utils/components/loading/loading.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_screen.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:capstone_project/view/screen/saved/search/search_saved_screen.dart';
import 'package:capstone_project/view/screen/saved/widgets/horizontal_article_card.dart';
import 'package:capstone_project/view/screen/saved/widgets/reading_list_sort_by_bottom_sheet_content.dart';
import 'package:capstone_project/view/screen/saved/widgets/saved_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  static const String routeName = '/saved_screen';

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final TextEditingController _listNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _listNameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final TextEditingController _editListNameController = TextEditingController();
  final TextEditingController _editDescriptionController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _editListNameNode = FocusNode();
  final FocusNode _editDescriptionNode = FocusNode();
  final GlobalKey<FormState> _addReadingListFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editReadingListFormKey = GlobalKey<FormState>();

  late final SavedViewModel provider;

  @override
  void initState() {
    provider = Provider.of<SavedViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.showAllReadingList();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listNameController.dispose();
    _descriptionController.dispose();
    _editListNameController.dispose();
    _editDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Reading List',
        home: false,
        searchField: true,
        tabBar: false,
        searchTextBox: SearchTextBox(
          textEditingController: _searchController,
          readOnly: true,
          onTap: () {
            Navigator.pushNamed(context, SearchSavedScreen.routeName);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PrimaryButtonIcon(
              widget: const Icon(Icons.add),
              teks: 'New List',
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheetBuilder(
                      tinggi: 680,
                      header: true,
                      judul: 'Create New List',
                      cancelEvent: () {
                        _listNameController.clear();
                        _descriptionController.clear();
                        Navigator.pop(context);
                      },
                      isi: [
                        Form(
                          key: _addReadingListFormKey,
                          child: SizedBox(
                            height: 680,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'List Name',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.neutralHigh,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextBox(
                                  textEditingController: _listNameController,
                                  hintText:
                                      'Ex : How to heal my traumatized inner child',
                                  currentFocus: _listNameNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.neutralHigh,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextBox(
                                  textEditingController: _descriptionController,
                                  last: true,
                                  hintText: 'Ex : This is an important list',
                                  currentFocus: _descriptionNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Consumer<SavedViewModel>(
                                    builder: (context, savedProvider, _) {
                                  return PrimaryButton(
                                    teks: 'Add',
                                    onPressed: () {
                                      if (_addReadingListFormKey.currentState!
                                          .validate()) {
                                        savedProvider.createReadingList(
                                          name: _listNameController.text,
                                          description:
                                              _descriptionController.text,
                                        );
                                        _listNameController.clear();
                                        _descriptionController.clear();
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          savedProvider.showAllReadingList();
                                        }
                                      }
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              customHeight: 36,
              customWidth: 119,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingButton(
        widget: const Icon(Icons.sort),
        teks: 'Sort By',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ReadingListSortByBottomSheetBuilder(
                sortBySaveEvent: () {
                  Navigator.pop(context);
                  if (provider.oldestCheckStatus == true) {
                    provider.saveSortByOldest();
                  } else {
                    provider.saveSortByNewest();
                  }
                  provider.showReadingListSortByOldestOrNewest(
                      sortByOldest: provider.sortingByOldest);
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: RefreshIndicator(
        strokeWidth: 2,
        color: MyColor.primaryMain,
        onRefresh: () {
          return provider.showAllReadingList();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SavedViewModel>(
            builder: (context, savedProvider, _) {
              if (savedProvider.state == MyState.loading) {
                return const Loading();
              } else {
                if (savedProvider.allReadingListData.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/nothing_here.png'),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Woops! Sorry, no result found.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: MyColor.neutralHigh,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemCount: savedProvider.allReadingListData.length,
                    itemBuilder: (context, indexList) {
                      return Consumer<DetailReadingListViewmodel>(
                          builder: (context, detailReadingListProvider, _) {
                        return GestureDetector(
                          onTap: () {
                            detailReadingListProvider.showReadingList(
                                id: savedProvider
                                    .allReadingListData[indexList].id!);
                            Navigator.pushNamed(
                              context,
                              DetailReadingListScreen.routeName,
                            );
                          },
                          child: SavedCard(
                            editReadingListBottomSheetBuilder: (context) {
                              return CustomBottomSheetBuilder(
                                header: true,
                                tinggi: 680,
                                judul: 'Edit List Info',
                                isi: [
                                  Form(
                                    key: _editReadingListFormKey,
                                    child: SizedBox(
                                      height: 680,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'List Name',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: MyColor.neutralHigh,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextBox(
                                            textEditingController:
                                                _editListNameController,
                                            hintText:
                                                'Ex : How to heal my traumatized inner child',
                                            currentFocus: _editListNameNode,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Wajib diisi';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'Description',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: MyColor.neutralHigh,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextBox(
                                            textEditingController:
                                                _editDescriptionController,
                                            last: true,
                                            hintText:
                                                'Ex : This is an important list',
                                            currentFocus: _editDescriptionNode,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Wajib diisi';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          PrimaryButton(
                                            teks: 'Save Changes',
                                            onPressed: () {
                                              if (_editReadingListFormKey
                                                  .currentState!
                                                  .validate()) {
                                                savedProvider.updateReadingList(
                                                  id: savedProvider
                                                      .allReadingListData[
                                                          indexList]
                                                      .id!,
                                                  name: _editListNameController
                                                      .text,
                                                  description:
                                                      _editDescriptionController
                                                          .text,
                                                );
                                                savedProvider
                                                    .showAllReadingList();
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                cancelEvent: () {
                                  _editListNameController.clear();
                                  _editDescriptionController.clear();
                                  Navigator.pop(context);
                                },
                              );
                            },
                            judulList: savedProvider
                                        .allReadingListData[indexList].name ==
                                    null
                                ? '-'
                                : savedProvider
                                    .allReadingListData[indexList].name!,
                            totalArtikel: savedProvider
                                    .allReadingListData[indexList]
                                    .articleTotal ??
                                0,
                            deskripsi: savedProvider
                                    .allReadingListData[indexList]
                                    .description ??
                                '-',
                            editListNameTextEditingController:
                                _editListNameController,
                            editDescriptionTextEditingController:
                                _editDescriptionController,
                            editListNameFocusNode: _editListNameNode,
                            editDescriptionFocusNode: _editDescriptionNode,
                            deleteEvent: () {
                              savedProvider.removeReadingList(
                                  id: savedProvider
                                      .allReadingListData[indexList].id!);
                              savedProvider.showAllReadingList();
                              Navigator.pop(context);
                            },
                            daftarArtikel: savedProvider
                                        .allReadingListData[indexList]
                                        .articleTotal! ==
                                    0
                                ? null
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: savedProvider
                                        .allReadingListData[indexList]
                                        .articleTotal!,
                                    itemBuilder: (context, indexArticle) {
                                      return HorizontalArticleCard(
                                        urlGambarArtikel: savedProvider
                                                    .allReadingListData[
                                                        indexList]
                                                    .readingListArticles ==
                                                null
                                            ? '-'
                                            : savedProvider
                                                .allReadingListData[indexList]
                                                .readingListArticles![
                                                    indexArticle]
                                                .article!
                                                .image!,
                                        kategoriArtikel: savedProvider
                                                    .allReadingListData[
                                                        indexList]
                                                    .readingListArticles ==
                                                null
                                            ? '-'
                                            : savedProvider
                                                .allReadingListData[indexList]
                                                .readingListArticles![
                                                    indexArticle]
                                                .article!
                                                .category!,
                                        judulArtikel: savedProvider
                                                    .allReadingListData[
                                                        indexList]
                                                    .readingListArticles ==
                                                null
                                            ? '-'
                                            : savedProvider
                                                .allReadingListData[indexList]
                                                .readingListArticles![
                                                    indexArticle]
                                                .article!
                                                .title!,
                                      );
                                    },
                                    separatorBuilder: (context, indexArticle) {
                                      return const SizedBox(
                                        width: 8,
                                      );
                                    },
                                  ),
                            cancelEvent: () {
                              _editListNameController.clear();
                              _editDescriptionController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        );
                      });
                    },
                    separatorBuilder: (context, indexList) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
