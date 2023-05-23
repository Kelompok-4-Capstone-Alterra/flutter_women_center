import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleTheme {
  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.deepPurple,
      primaryColor: const Color(0xFFAF1582),
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: const TextStyle(
          fontSize: 57,
          color: Color(0xff000000),
          letterSpacing: -0.25,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: const TextStyle(
          fontSize: 45,
          color: Color(0xff000000),
          fontWeight: FontWeight.w400,
        ),
        displaySmall: const TextStyle(
          fontSize: 36,
          color: Color(0xff000000),
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: const TextStyle(
          fontSize: 32,
          color: Color(0xff000000),
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: const TextStyle(
          fontSize: 28,
          color: Color(0xff000000),
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          color: Color(0xff000000),
          fontWeight: FontWeight.w500,
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          color: Color(0xff000000),
          fontWeight: FontWeight.w500,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          color: Color(0xff000000),
          letterSpacing: 0.15,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          color: Color(0xff000000),
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          color: Color(0xff000000),
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          color: Color(0xff000000),
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
          height: 16,
        ),
        labelSmall: const TextStyle(
          fontSize: 8,
          color: Color(0xff9E9494),
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: Color(0xff000000),
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: Color(0xff000000),
          letterSpacing: 0.25,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          color: Color(0xffBDB728),
          fontWeight: FontWeight.w400,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
      ),
    );
  }
}
