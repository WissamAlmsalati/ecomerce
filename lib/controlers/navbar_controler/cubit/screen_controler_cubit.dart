import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../views/cart_screen/cart_screen.dart';
import '../../../views/favorite_screen/favorite_screen.dart';
import '../../../views/home_screen/home_screen.dart';
import '../../../views/profile_screen/profile_screen.dart';
import '../../../views/search_screen/search_screen.dart';

part 'screen_controler_state.dart';

class ScreenControlerCubit extends Cubit<ScreenControlerState> {
  ScreenControlerCubit() : super(ScreenControlerInitial());

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
     SearchScreen( showBackArrow: false),
    const CartScreen(),
    const ProfileScreen(),
  ];


  void changeScreen(int index ,) {
    if (kDebugMode) {
      print(index.toString());
    }

    currentIndex = index;
    emit(ScreenChanged(index));
  }
}
