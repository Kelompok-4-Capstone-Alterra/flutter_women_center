import 'package:capstone_project/model/article_model.dart';
import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/buttons/floating_button.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/article_detail/article_detail_screen.dart';
import 'package:capstone_project/view/screen/article_list/bottomsheet_content.dart';
import 'package:flutter/material.dart';

class ArticleListScreen extends StatefulWidget {
  static const String routename = '/article_list_screen';
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(
          preferredSize: Size(MySize.screenWidth(context), double.maxFinite),
          home: false,
          action: false,
          title: 'Article',
          searchField: true,
          tabBar: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Mental Health'),
            Tab(text: 'Self Improvement'),
            Tab(text: 'Spiritual'),
          ],
          searchTextBox:
              SearchTextBox(textEditingController: _searchController),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Most Viewed",
                        style: TextStyle(
                          color: MyColor.neutralMediumLow,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: ((context, index) {
                          final Articles articles = articlesList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArticleDetailsScreen(articles: articles),
                                ),
                              );
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                      articles.image,
                                      width: 135,
                                      height: 128,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            articles.title,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            articles.author,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: MyColor.neutralMedium,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            articles.date,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: MyColor.neutralMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 19),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.bookmark_border),
                                        PopupMenuButton(
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    // row has two child icon and text.
                                                    child: Row(
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            "Show less like this",
                                                            style: TextStyle(
                                                                color: MyColor
                                                                    .neutralHigh),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 2,
                                                    // row has two child icon and text.
                                                    child: Row(
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            "Report",
                                                            style: TextStyle(
                                                              color: MyColor
                                                                  .danger,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        itemCount: articlesList.length,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 50,
          width: 130,
          child: FloatingButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetContent();
                  });
            },
            teks: 'Sort By',
            widget: const Icon(Icons.sort),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
