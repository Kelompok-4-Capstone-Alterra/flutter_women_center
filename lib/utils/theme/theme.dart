import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleTheme {
  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.deepPurple,
      primaryColor: const Color(0xFFAF1582),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        titleMedium: const TextStyle(
          fontSize: 16,
          color: Color(0xff282424),
          letterSpacing: 0.15,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          color: Color(0xffBDB728),
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          color: Color(0xff282424),
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
