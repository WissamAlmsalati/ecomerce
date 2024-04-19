import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.brown,
    primaryColor: Colors.brown[800],
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.brown[800],
      textTheme: ButtonTextTheme.primary,
    ),
  );
}