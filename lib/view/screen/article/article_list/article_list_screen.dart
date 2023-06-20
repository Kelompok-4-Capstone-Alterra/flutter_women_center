import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/buttons/floating_button.dart';
import 'package:capstone_project/utils/components/modal_bottom_sheet/custom_bottom_sheet_builder.dart';

import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_view_model.dart';
import 'package:capstone_project/view/screen/article/article_list/widgets/article_list_post_widget.dart';
import 'package:capstone_project/view/screen/article/article_list/widgets/bottomsheet_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../../../../utils/components/bottom_navigation_bar/bottom_nav_bar.dart';

class ArticleListScreen extends StatefulWidget {
  static const String routename = '/article_list_screen';

  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<ArticleListProvider>(context, listen: false);
      provider.fetchTopicsAndArticles();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleListProvider>(builder: (context, provider, _) {
      if (provider.myState == MyState.loading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (provider.myState == MyState.failed) {
        return const Center(
          child: Text('Failed to load data'),
        );
      } else {
        _tabController = TabController(
          length: provider.topics.length,
          vsync: this,
        );
        return Scaffold(
          appBar: CustomAppBar(
            preferredSize: Size(MySize.screenWidth(context), double.maxFinite),
            home: false,
            judul: 'Article',
            searchField: true,
            tabBar: true,
            controller: _tabController,
            tabs: provider.getListTopic(),
            searchTextBox: SearchTextBox(
              textEditingController: _searchController,
              onChanged: (value) {
                provider.updateSearchText(value);
                provider.searchArticles(value);
              },
            ),
          ),
          body: DefaultTabController(
            length: provider.topics.length,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      provider.sortValues.toUpperCase().replaceAll('_', ' '),
                      style: TextStyle(
                        color: MyColor.neutralMediumLow,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: provider.topics.map((topic) {
                        final articles = provider.listArticles
                            .where((article) => article.topic == topic.name)
                            .toList();
                        return ArticleListPostWidget(articles: articles);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            height: 50,
            width: 130,
            child: FloatingButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useRootNavigator: true,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomBottomSheetBuilder(
                      tinggi: MediaQuery.of(context).size.height * 0.8,
                      isi: const [
                        BottomSheetContent(),
                      ],
                      header: true,
                      judul: 'Sort By',
                    );
                  },
                );
              },
              teks: 'Sort By',
              widget: const Icon(Icons.sort),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }
    });
  }
}
