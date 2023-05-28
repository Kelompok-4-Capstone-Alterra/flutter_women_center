import 'package:capstone_project/utils/my_color.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int)? onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onTap,
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
    );
  }
}
