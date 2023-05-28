import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        home: false,
        searchField: true,
        tabBar: false,
        judul: 'Home',
        searchTextBox: SearchTextBox(textEditingController: searchController),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, ArticleListScreen.routename);
                },
                icon: const Icon(Icons.ac_unit_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
