import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_screen.dart';
import 'package:capstone_project/view/screen/forum/join_forum_discussion_screen.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/landing/landing_view_model.dart';
import 'package:capstone_project/view/screen/profile/profile_screen.dart';
import 'package:capstone_project/view/screen/saved/acticle/article_screen.dart';
import 'package:capstone_project/view/screen/saved/detail_reading_list/detail_reading_list_screen.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static const String routeName = '/landing_screen';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // This navigator state will be used to navigate different pages
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKey.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTabIndex != 0) {
            _onTap(0);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: SafeArea(
        child: Scaffold(
          body: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute),
          bottomNavigationBar: Consumer<LandingViewModel>(
            builder: (context, landingProvider, _) {
              return BottomNavBar(
                  currentIndex: _currentTabIndex, onTap: _onTap);
            },
          ),
        ),
      ),
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        _navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
        break;
      case 1:
        _navigatorKey.currentState!
            .pushReplacementNamed(TransactionScreen.routeName);
        break;
      case 2:
        _navigatorKey.currentState!.pushReplacementNamed(SavedScreen.routeName);
        break;
      case 3:
        _navigatorKey.currentState!
            .pushReplacementNamed(ProfileScreen.routeName);
        break;
    }
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TransactionScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const TransactionScreen());
      case SavedScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SavedScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      //jika ada halaman baru (selain di bottom nav bar), tambahin lagi
      case DetailReadingListScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const DetailReadingListScreen());
      case ArticleScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ArticleScreen());
      case ArticleListScreen.routename:
        return MaterialPageRoute(
            builder: (context) => const ArticleListScreen());
      case JoinForumDiscussionScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const JoinForumDiscussionScreen());

      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
