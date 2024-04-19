import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipes/preferences.dart';
import 'package:recipes/theme_data.dart';
import 'package:recipes/views/on_boarding/on_boarding.dart';
import 'views/screens_body.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // Navigation bar color
    systemNavigationBarIconBrightness: Brightness.dark, // Navigation bar icons
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isLoggedIn = await UserPreferences().getUserLoggedIn();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: isLoggedIn ? const ScreensBody() : const OnBoarding()));
}
