import 'package:flutter/material.dart';

class MySize {
  static const double screenPadding = 16;

  ///mengembalikan berapa tinggi body, belum termasuk padding yang ada pada body
  static double bodyHeight(BuildContext context, bool home, bool searchField,
      bool tabBar, bool bottomNavBar) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    if (bottomNavBar == true) {
      height -= kBottomNavigationBarHeight;
    }
    if (home == true) {
      return height -= 206;
    } else {
      if (searchField == true && tabBar == false) {
        return height -= 178;
      } else if (searchField == false && tabBar == true) {
        return height -= 174;
      } else if (searchField == true && tabBar == true) {
        return height -= 238;
      } else {
        print(height - 114);
        return height -= 114;
      }
    }
  }

  ///mengembalikan lebar layar
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  ///mengembalikan tinggi layar
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  ///mengembalikan lebar body yang ada paddingnya (16)
  static double bodyWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - (screenPadding * 2);
  }

  ///mengembalikan setengah dari lebar body yang ada paddingnya (16)
  static double bodyHalfWidth(BuildContext context) {
    return (MediaQuery.of(context).size.width - (screenPadding * 2)) / 2;
  }
}
