import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/screens_body.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    theme: ThemeData(
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
    ),
    debugShowCheckedModeBanner: false,
    home: const ScreensBody(),
  ));
}