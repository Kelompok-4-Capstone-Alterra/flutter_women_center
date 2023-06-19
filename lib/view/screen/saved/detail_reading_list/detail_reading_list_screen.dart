import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/article/article_detail/article_detail_screen.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/saved/search/search_saved_screen.dart';
import 'package:capstone_project/view/screen/saved/widgets/article_list_popup_menu_button.dart';
import 'package:capstone_project/view/screen/saved/widgets/vertical_article_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/utils/components/text_box/regular_text_box/text_box.dart';
import '../../../../utils/components/buttons/primary_button.dart';
import '../../../../utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';

class DetailReadingListScreen extends StatefulWidget {
  const DetailReadingListScreen({super.key});

  static const String routeName = '/detail_reading_list_screen';

  @override
  State<DetailReadingListScreen> createState() =>
      _DetailReadingListScreenState();
}

class _DetailReadingListScreenState extends State<DetailReadingListScreen> {
  final TextEditingController _editListNameController = TextEditingController();
  final TextEditingController _editDescriptionController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _editListNameNode = FocusNode();
  final FocusNode _editDescriptionNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _editListNameController.dispose();
    _editDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailReadingListViewmodel provider =
        Provider.of<DetailReadingListViewmodel>(context, listen: false);
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
            Navigator.popAndPushNamed(context, SearchSavedScreen.routeName);
          },
        ),
        actions: [
          ArticleListPopupMenuButton(
            cancelEvent: null,
            editReadingListBottomSheetBuilder: (context) {
              return CustomBottomSheetBuilder(
                header: true,
                tinggi: 680,
                judul: 'Edit List Info',
                isi: [
                  Form(
                    key: _formKey,
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
                            textEditingController: _editListNameController,
                            hintText:
                                'Ex : How to heal my traumatized inner child',
                            currentFocus: _editListNameNode,
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
                            'Description (optional)',
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
                            textEditingController: _editDescriptionController,
                            last: true,
                            hintText: 'Ex : This is an important list',
                            currentFocus: _editDescriptionNode,
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
                          PrimaryButton(
                            teks: 'Save Changes',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.updateReadingList(
                                  id: provider.readingListData.id!,
                                  name: _editListNameController.text,
                                  description: _editDescriptionController.text,
                                );
                                provider.showReadingList(
                                    id: provider.readingListData.id!);
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
            editListNameTextEditingController: _editListNameController,
            editDescriptionTextEditingController: _editDescriptionController,
            editListNameFocusNode: _editListNameNode,
            editDescriptionFocusNode: _editDescriptionNode,
            deleteEvent: () {
              provider.removeReadingList(id: provider.readingListData.id!);
              Navigator.popUntil(
                context,
                ModalRoute.withName(SavedScreen.routeName),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        strokeWidth: 2,
        color: MyColor.primaryMain,
        onRefresh: () {
          return provider.showReadingList(id: provider.readingListData.id!);
        },
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 114,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              width: double.infinity,
              child: Consumer<DetailReadingListViewmodel>(
                  builder: (context, detailReadingListProvider, _) {
                if (detailReadingListProvider.state == MyState.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: MyColor.primaryMain,
                    ),
                  );
                } else {
                  final DateTime today = DateTime.now();
                  final DateTime daysCreated = DateTime.parse(
                      detailReadingListProvider.readingListData.createdAt!);
                  final Duration days = today.difference(daysCreated);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        detailReadingListProvider.readingListData.name ?? '-',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: MyColor.primaryMain,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            detailReadingListProvider
                                        .readingListData.articleTotal ==
                                    0
                                ? 'No Article Yet'
                                : detailReadingListProvider
                                            .readingListData.articleTotal ==
                                        1
                                    ? '1 Article'
                                    : '${detailReadingListProvider.readingListData.articleTotal} Articles',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: MyColor.neutralHigh,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${days.inDays} days ago',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: MyColor.neutralMediumLow,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        detailReadingListProvider.readingListData.description ??
                            '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: MyColor.neutralHigh,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
            Consumer<DetailReadingListViewmodel>(
                builder: (context, detailReadingListProvider, _) {
              if (detailReadingListProvider.state == MyState.loading) {
                return Flexible(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: MyColor.primaryMain,
                    ),
                  ),
                );
              } else {
                if (detailReadingListProvider.readingListData.articleTotal ==
                    0) {
                  return Flexible(
                    child: Center(
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
                    ),
                  );
                } else {
                  return Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: ListView.separated(
                        itemCount: detailReadingListProvider
                            .readingListData.articleTotal!,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //ke halaman view article
                              Navigator.pushNamed(
                                  context, ArticleDetailsScreen.routename);
                            },
                            child: VerticalArticleCard(
                              deleteEvent: () {
                                detailReadingListProvider
                                    .removeArticleFromReadingList(
                                        id: detailReadingListProvider
                                            .readingListData.id!);
                                detailReadingListProvider.showReadingList(
                                    id: detailReadingListProvider
                                        .readingListData.id!);
                              },
                              articleImageLink: detailReadingListProvider
                                      .readingListData
                                      .readingListArticles![index]
                                      .article!
                                      .image ??
                                  '-',
                              articleTitle: detailReadingListProvider
                                      .readingListData
                                      .readingListArticles![index]
                                      .article!
                                      .title ??
                                  '-',
                              articleAuthor: detailReadingListProvider
                                      .readingListData
                                      .readingListArticles![index]
                                      .article!
                                      .author ??
                                  '-',
                              articleCategory: detailReadingListProvider
                                      .readingListData
                                      .readingListArticles![index]
                                      .article!
                                      .category ??
                                  '-',
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                    ),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
