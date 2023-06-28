import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_screen.dart';
import 'package:capstone_project/view/screen/career/career_list/career_list_screen.dart';
import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/forum/forum_discussion_screen.dart';
import 'package:capstone_project/view/screen/home/search/search_view_model.dart';
import 'package:capstone_project/view/screen/home/search/tab_search/tab_search_screen.dart';
import 'package:capstone_project/view/screen/home/search/tab_search/tab_search_view_model.dart';
import 'package:capstone_project/view/screen/home/search/widget/category_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/components/appbar/custom_appbar.dart';
import '../../../../utils/components/text_box/search_text_box.dart';
import '../../../../utils/my_size.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final HomeSearchViewModel homeSearchProvider;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    homeSearchProvider =
        Provider.of<HomeSearchViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeSearchProvider.init();
      Provider.of<TabSearchViewModel>(context, listen: false)
          .changeSelectedTab(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.screenWidth(context), double.maxFinite),
        home: false,
        judul: 'Search',
        searchField: true,
        tabBar: false,
        onTap: (index) {
          Provider.of<HomeSearchViewModel>(context, listen: false)
              .changeSelectedTab(index);
        },
        searchTextBox: SearchTextBox(
          textEditingController: _searchController,
          onChanged: (value) {
            homeSearchProvider.search(value);
            Provider.of<TabSearchViewModel>(context, listen: false)
                .searchData(value);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: MySize.screenPadding,
          left: MySize.screenPadding,
          right: MySize.screenPadding,
        ),
        child: Consumer<HomeSearchViewModel>(
          builder: (context, value, _) {
            if (value.state == MyState.initial) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search by Category",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: MyColor.neutralHigh,
                    ),
                  ),
                  Row(
                    children: const [
                      CategoryBox(
                        customIcon: Icons.article,
                        category: 'Article',
                        direction: ArticleListScreen.routename,
                      ),
                      CategoryBox(
                        customIcon: Icons.supervisor_account,
                        category: 'Counselling',
                        direction: CounselingTopicScreen.routeName,
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      CategoryBox(
                        customIcon: Icons.home_repair_service,
                        category: 'Career',
                        direction: CareerListScreen.routeName,
                      ),
                      CategoryBox(
                        customIcon: Icons.forum,
                        category: 'Forum',
                        direction: ForumDiscussionScreen.routeName,
                      ),
                    ],
                  ),
                ],
              );
            } else if (value.state == MyState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.state == MyState.loaded) {
              return const TabSearch();
            } else {
              return const Center(child: Text('Error'));
            }
          },
        ),
      ),
    );
  }
}
