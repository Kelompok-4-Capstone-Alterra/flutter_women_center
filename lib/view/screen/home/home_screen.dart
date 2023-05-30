import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/login/login_view_model.dart';

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
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, CounselingTopicScreen.routeName);
          },
          child: const Text('Counseling'),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
