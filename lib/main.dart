import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/counselor_detail/counselor_detail_view_model.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_screen.dart';
import 'package:capstone_project/view/screen/counselor_list/counselor_list_view_model.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_view_model.dart';
import 'package:capstone_project/view/screen/profile/profile_screen.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_screen.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_view_model.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_screen.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_view_model.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/saved/saved_view_model.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/screen/counseling_topic/counseling_topic_view_model.dart';
import 'view/screen/counselor_detail/counselor_detail_screen.dart';

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
          create: (context) => LandingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavedViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailReadingListViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselingTopicViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselorListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounselorDetailViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Woman Center',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: HomeScreen.routeName,
        routes: {
          LandingScreen.routeName: (context) => const LandingScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          TransactionScreen.routeName: (context) => const TransactionScreen(),
          SavedScreen.routeName: (context) => const SavedScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          DetailReadingListScreen.routeName: (context) =>
              const DetailReadingListScreen(),
          ArticleScreen.routeName: (context) => const ArticleScreen(),
          CounselingTopicScreen.routeName: (context) =>
              const CounselingTopicScreen(),
          CounselorListScreen.routeName: (context) =>
              const CounselorListScreen(),
          CounselorDetailScreen.routeName: (context) =>
              const CounselorDetailScreen(
                id: 0,
              ),
        },
      ),
    );
  }
}
