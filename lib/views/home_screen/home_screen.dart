import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/navbar_controler/cubit/screen_controler_cubit.dart';
import '../../constance.dart';
import '../../controlers/banner_controler/cubit/banner_controler_cubit.dart';
import '../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import 'components/banner.dart';
import 'components/category_widget.dart';
import 'components/coustom_appbar.dart';
import 'components/last_recipes.dart';
import 'components/search_bar.dart';
import 'components/text_Row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Constans constants = Constans(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<BannerCubit>(
          create: (BuildContext context) => BannerCubit()..fetchBanner(),
        ),
        BlocProvider<FetchRecipesCubit>(
          create: (BuildContext context) => FetchRecipesCubit()..fetchRecipes(),
        ),
        BlocProvider<ScreenControlerCubit>(
          create: (BuildContext context) => ScreenControlerCubit(),
        ),
      ],
      child: Scaffold(

        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CoustomAppBar(),
                constants.smallSizedsBoxHeight,
                const CoustomeSearchBar(),
                constants.samllmediumSizedBoxHeight,
                const BannerWidget(),
                TextRow(
                  text: 'Last Recipes',
                  tapText: 'View All',
                  onTap: () {},
                ),
                const CategoryWidget(),
                constants.samllmediumSizedBoxHeight,
                const FlashSale(),
                // Add additional widgets as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}


