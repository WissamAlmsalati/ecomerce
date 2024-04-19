import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/navbar_controler/cubit/screen_controler_cubit.dart';
import 'package:recipes/controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import 'package:recipes/preferences.dart';
import 'package:recipes/theme_data.dart';
import 'package:recipes/views/on_boarding/on_boarding.dart';
import 'views/screens_body.dart';
import 'firebase/firebase_options.dart';
import 'controlers/banner_controler/cubit/banner_controler_cubit.dart';

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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FetchRecipesCubit>(
          create: (BuildContext context) => FetchRecipesCubit()..fetchRecipes(),
        ),
        BlocProvider<BannerCubit>(
          create: (BuildContext context) => BannerCubit()..fetchBanner(),
        ),
        BlocProvider<ScreenControlerCubit>(
          create: (BuildContext context) => ScreenControlerCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: isLoggedIn ? const ScreensBody() : const OnBoarding(),
      ),
    ),
  );
}