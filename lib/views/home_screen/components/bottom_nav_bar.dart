import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipes/controlers/navbar_controler/cubit/screen_controler_cubit.dart';
import '../../../constance.dart';

class BottomBavBar extends StatefulWidget {
  const BottomBavBar({super.key});

  @override
  State<BottomBavBar> createState() => _BottomBavBarState();
}

class _BottomBavBarState extends State<BottomBavBar> {
  @override
  Widget build(BuildContext context) {
    final constants = Constans(context);
    return BlocBuilder<ScreenControlerCubit, ScreenControlerState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is ScreenChanged) {
          selectedIndex = state.index;
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox(
              height: constants.height * 0.08,
              child: GNav(
                tabMargin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15.0),
                haptic: true,
                duration: const Duration(milliseconds: 400),
                gap: constants.smallWidth,
                tabBorderRadius: 15,
                tabBackgroundColor: constants.white,
                backgroundColor: constants.lightBlue,
                activeColor: constants.brown,
                iconSize: 40,
                tabs: const [
                  GButton(
                    icon: Iconsax.home,
                    text: '', // Remove the label
                  ),
                  GButton(
                    icon: Iconsax.heart,
                    text: '',
                  ),
                  GButton(
                    icon: Iconsax.search_normal,
                    text: '', // Remove the label
                  ),
                  GButton(
                    icon: Iconsax.shopping_cart,
                    text: '', // Remove the label
                  ),
                  GButton(
                    icon: Iconsax.user,
                    text: '', // Remove the label
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  if (kDebugMode) {
                    print('Tab changed: $index');
                  }
                  context.read<ScreenControlerCubit>().changeScreen(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
