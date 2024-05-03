import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/cart_control_cubit/cubit/cart_cubit.dart';
import 'package:recipes/controlers/navbar_controler/cubit/screen_controler_cubit.dart';
import 'package:recipes/controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import 'package:recipes/moudels/cart/cart_repostry.dart';
import 'package:recipes/preferences.dart';
import 'package:recipes/theme_data.dart';
import 'package:recipes/views/on_boarding/on_boarding.dart';
import 'package:http/http.dart' as http;
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


  void testConnection() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:8080"));
      if (response.statusCode == 200) {
        print('Connected to the server successfully.');
      } else {
        print('Server returned status code ${response.statusCode}.');
      }
    } catch (e) {
      print('Failed to connect to the server: $e');
    }
  }


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
        BlocProvider<CartCubit>(
          create: (BuildContext context) => CartCubit(CartRepository()),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: OnBoarding()
      ),
    ),
  );
}


//        home: isLoggedIn ? const AppBody() : const OnBoarding(),
