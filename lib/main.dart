import 'package:capstone_project/utils/theme/theme.dart';

import 'package:capstone_project/view/screen/join_forum_discussion/join_forum_discussion_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Woman Center',
      theme: StyleTheme.themeData(),
      initialRoute: JoinForumDiscussionScreen.routeName,
      routes: {
        JoinForumDiscussionScreen.routeName: (context) =>
            const JoinForumDiscussionScreen(),
      },
    );
  }
}
