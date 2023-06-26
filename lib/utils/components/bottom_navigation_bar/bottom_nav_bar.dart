import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar_view_model.dart';
import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/auth/login/login_screen.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/profile/profile_screen.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    Provider.of<BottomNavBarViewModel>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buttomNavBarProvider =
        Provider.of<BottomNavBarViewModel>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: MyColor.neutralLow,
            width: .5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: MyColor.white,
        elevation: 0.0,
        currentIndex: widget.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColor.primaryMain,
        unselectedItemColor: MyColor.neutralMediumHigh,
        unselectedLabelStyle: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w500,
          color: MyColor.neutralMediumHigh,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w500,
          color: MyColor.primaryMain,
        ),
        selectedIconTheme: IconThemeData(color: MyColor.primaryMain),
        unselectedIconTheme: IconThemeData(color: MyColor.neutralMediumHigh),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        onTap: (value) {
          if (value == widget.currentIndex) {
            return;
          }
          switch (value) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const HomeScreen();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final tween = Tween(begin: 0.1, end: 1.0);
                    return FadeTransition(
                      opacity: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
              break;
            case 1:
              if (buttomNavBarProvider.token == '') {
                Navigator.pushNamed(context, LoginScreen.routeName);
              } else {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const TransactionScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween(begin: 0.1, end: 1.0);
                      return FadeTransition(
                        opacity: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              }
              break;
            case 2:
              if (buttomNavBarProvider.token == '') {
                Navigator.pushNamed(context, LoginScreen.routeName);
              } else {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const SavedScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween(begin: 0.1, end: 1.0);
                      return FadeTransition(
                        opacity: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              }
              break;
            case 3:
              if (buttomNavBarProvider.token == '') {
                Navigator.pushNamed(context, LoginScreen.routeName);
              } else {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const ProfileScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween(begin: 0.1, end: 1.0);
                      return FadeTransition(
                        opacity: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              }
              break;
            default:
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        },
      ),
    );
  }
}
