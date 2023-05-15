import 'package:flutter/material.dart';

class MySize {
  static const int screenPadding = 16;
  static const int appBarHeight = 114;

  static double bodyHeight1(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top;
  }

  static double bodyHeight2(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBarHeight;
  }

  static double bodyHeight3(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBarHeight -
        kBottomNavigationBarHeight;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width - (screenPadding * 2);
  }

  static double halfWidth(BuildContext context) {
    return (MediaQuery.of(context).size.width - (screenPadding * 2)) / 2;
  }
}
