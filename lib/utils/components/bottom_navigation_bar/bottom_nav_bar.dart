import 'package:capstone_project/utils/my_color.dart';
import 'package:capstone_project/view/screen/home/home_screen.dart';
import 'package:capstone_project/view/screen/profile/profile_screen.dart';
import 'package:capstone_project/view/screen/saved/saved_screen.dart';
import 'package:capstone_project/view/screen/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
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
        currentIndex: currentIndex,
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
          if (value == currentIndex) {
            return;
          }
          switch (value) {
            case 0:
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              break;
            case 1:
              Navigator.pushReplacementNamed(
                  context, TransactionScreen.routeName);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, SavedScreen.routeName);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
              break;
          }
        },
      ),
    );
  }
}
