import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_screen.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
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
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: HomeScreen.routeName,
      routes: {
        CounselingTopicScreen.routeName: (context) =>
            const CounselingTopicScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CounselorListScreen.routeName: (context) => const CounselorListScreen(),
      },
    );
  }
}
