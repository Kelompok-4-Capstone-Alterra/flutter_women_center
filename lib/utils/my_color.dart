import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyColor {
  static final primarySurface = HexColor('#E2D0DC');
  static final primaryBorder = HexColor('#B5589A');
  static final primaryMain = HexColor('#AF1582');
  static final primaryHover = HexColor('#954E80');
  static final primaryPressed = HexColor('#913175');
  static final secondarySurface = HexColor('#E3DDB2');
  static final secondaryBorder = HexColor('#EADB7D');
  static final secondaryMain = HexColor('#A49F23');
  static final secondaryHover = HexColor('#AEAB59');
  static final secondaryPressed = HexColor('#9A8A23');
  static final success = HexColor('#0E9325');
  static final danger = HexColor('#B3261E');
  static final warning = HexColor('#FFCB14');
  static final neutralLow = HexColor('#E7E4E4');
  static final neutralMediumLow = HexColor('#9E9494');
  static final neutralMedium = HexColor('#6B6161');
  static final neutralMediumHigh = HexColor('#504949');
  static final neutralHigh = HexColor('#282424');
  static final white = HexColor('#FDFCFC');
  static final Gradient background = LinearGradient(
    colors: [
      HexColor("#F9DAD9"),
      HexColor("#DAD29C"),
    ],
  );
}
