import 'package:capstone_project/utils/theme/theme.dart';
import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_screen.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/join_forum_discussion/join_forum_discussion_screen.dart';
import 'package:capstone_project/view/screen/join_forum_discussion/join_forum_discussion_view_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SortByForumProvider(),
      child: MaterialApp(
        title: 'Woman Center',
        theme: StyleTheme.themeData(),
        initialRoute: HomeScreen.routeName,
        routes: {
          CounselingTopicScreen.routeName: (context) =>
              const CounselingTopicScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          CounselorListScreen.routeName: (context) =>
              const CounselorListScreen(),
          TransactionScreen.routeName: (context) => const TransactionScreen(),
          JoinForumDiscussionScreen.routeName: (context) =>
              const JoinForumDiscussionScreen(),
        },
      ),
    );
  }
}
