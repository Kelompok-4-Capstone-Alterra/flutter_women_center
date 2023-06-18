import 'package:capstone_project/utils/components/alert_dialog/custom_alert_dialog_builder.dart';
import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_screen.dart';
import 'package:capstone_project/view/screen/saved/widgets/article_list_popup_menu_button.dart';
import 'package:capstone_project/view/screen/saved/widgets/vertical_article_card.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        judul: 'Reading List',
        home: false,
        searchField: true,
        tabBar: false,
        searchTextBox: SearchTextBox(textEditingController: _searchController),
        actions: [
          ArticleListPopupMenuButton(
            editListNameTextEditingController: _editListNameController,
            editDescriptionTextEditingController: _editDescriptionController,
            editListNameFocusNode: _editListNameNode,
            editDescriptionFocusNode: _editDescriptionNode,
            sureOnPressed: null,
          )
        ],
      ),
      body: Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List\'s Name',
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
                      '2 Articles',
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
                      '2 days ago',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: MyColor.neutralMediumLow,
                      ),
                    ),
                  ],
                ),
                Text(
                  'This is a description of this reading list',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: MyColor.neutralHigh,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ArticleScreen.routeName);
                    },
                    child: const VerticalArticleCard(
                      sureOnPressed: null,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
