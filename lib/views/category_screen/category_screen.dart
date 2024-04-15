import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/views/clothes_detail_screen/clothes_detail_screen.dart';

import '../../constance.dart';
import '../home_screen/components/recipe_widget.dart';
import '../../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  CategoryScreen(
      {Key? key, required this.categoryName, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return FetchRecipesCubit()..fetchRecipesByCategory(categoryId);
        },
        child: BlocBuilder<FetchRecipesCubit, FetchRecipesState>(
          builder: (BuildContext context, state) {
            if (state is DataLoading) {
              print('Data is loading...');
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataError) {
              print('Error: ${state.message}');
              return Center(
                child: Text(state.message),
              );
            } else if (state is DataLoaded) {
              print('Fetched recipes: ${state.clothes.length} items');
              for (int i = 0; i < state.clothes.length; i++) {
                print(
                    'Recipe $i: Name - ${state.clothes[i].name}, Image URL - ${state.clothes[i].image}');
              }

              print('Data loaded: ${state.clothes}');
              return ListView.builder(
                itemCount: state.clothes.length,
                itemBuilder: (BuildContext context, int index) {
                  print('Recipe: ${state.clothes[index]}');
                  return GestureDetector(
                    onTap: () {
                      final recipe = state.clothes[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClothesScreen(
                              recipeId: recipe.id,
                              recipeName: recipe.name,
                              recipeDescription: recipe.description,
                              recipeImage: recipe.image, discount: '', price: recipe.price,

                            ),
                          ));
                    },
                    child: ListTile(
                      title: Text(state.clothes[index].name),
                      subtitle: Text(state.clothes[index].description),
                      leading: Image.network(state.clothes[index].image),
                    ),
                  );
                },
              );
            } else {
              print('Unknown state: $state');
              return Container();
            }
          },
        ),
      ),
    );
  }
}