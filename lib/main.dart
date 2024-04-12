import 'package:flutter/material.dart';
import 'package:recipes/views/auth_screen/auth_sign_in.dart';
import 'package:recipes/views/auth_screen/auth_sign_up.dart';
import 'package:recipes/views/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase/firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}