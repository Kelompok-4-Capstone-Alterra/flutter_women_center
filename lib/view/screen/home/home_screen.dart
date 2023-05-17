import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/join_forum_discussion/join_forum_discussion_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, CounselingTopicScreen.routeName);
            },
            child: const Text('Counseling Topic Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, JoinForumDiscussionScreen.routeName);
            },
            child: const Text('Join Forum Discussion Screen'),
          ),
        ],
      ),
    );
  }
}
