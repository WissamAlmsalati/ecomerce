import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../constance.dart';
import '../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import '../../firebase/banner_controler_cubit.dart';
import 'components/banner.dart';
import 'components/category_widget.dart';
import 'components/coustom_appbar.dart';
import 'components/last_recipes.dart';
import 'components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final Constans constants = Constans(context);

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<BannerCubit>(
            create: (BuildContext context) {
              return BannerCubit()..fetchBanner();
            },
          ),
          BlocProvider<FetchRecipesCubit>(
            create: (BuildContext context) {
              return FetchRecipesCubit()..fetchRecipes();
            },
          ),
        ],
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CoustomAppBar(),
                    constants.smallSizedsBoxHeight,
                    const CoustomeSearchBar(),
                    constants.samllmediumSizedBoxHeight,
                    const BannerWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: constants.smallWidth, vertical: constants.smallHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: constants.brown,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const CategoryWidget(),
                    constants.samllmediumSizedBoxHeight,
                    const FlashSale(),
                    // Add additional widgets as needed
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
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
              selectedIndex: 0, // You can set the initial index here
              onTabChange: (index) {},
            ),
          ),
        ),
      ),
    );
  }
}


