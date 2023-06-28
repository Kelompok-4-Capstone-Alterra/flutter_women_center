import 'package:flutter/material.dart';

class MyFocusNode {
  final BuildContext context;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  ///ganti fokus ke text form field berikutnya
  MyFocusNode.change(
      {required this.context,
      required this.currentFocus,
      required this.nextFocus}) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
