import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/forum/join_forum_discussion_screen.dart';
import 'package:capstone_project/view/screen/forum/join_forum_discussion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => JoinForumDiscussionViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woman Center',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          JoinForumDiscussionScreen.routeName: (context) =>
              const JoinForumDiscussionScreen(),
        },
      ),
    );
  }
}
