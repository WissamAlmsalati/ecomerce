import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import '../../constance.dart';
import 'components/banner.dart';
import 'components/category_widget.dart';
import 'components/coustom_appbar.dart';
import 'components/last_recipes.dart';
import 'components/search_bar.dart';
import 'components/text_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Constans constants = Constans(context);

    return Scaffold(
      body: RefreshIndicator(
        //i need to change indecator style 

        onRefresh: () async {
          // Access the Cubit and call the fetch method
          context.read<FetchRecipesCubit>().fetchRecipes();
        },
        child: SingleChildScrollView(
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
