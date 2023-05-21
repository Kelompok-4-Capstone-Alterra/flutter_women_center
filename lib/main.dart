import 'package:capstone_project/view/screen/article_list/article_list_screen.dart';
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
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: ArticleListScreen.routename,
      routes: {
        ArticleListScreen.routename: (context) => const ArticleListScreen(),
        //ArticleDetails.routename:(context) => const ArticleDetails(articles: '')
      },
    );
  }
}
