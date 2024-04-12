import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constance.dart';
import '../home_screen/components/recipe_widget.dart';
import '../../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import '../recipe_screen/recipe_screen.dart';

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
              print('Fetched recipes: ${state.recipes.length} items');
              for (int i = 0; i < state.recipes.length; i++) {
                print(
                    'Recipe $i: Name - ${state.recipes[i].name}, Image URL - ${state.recipes[i].image}');
              }

              print('Data loaded: ${state.recipes}');
              return ListView.builder(
                itemCount: state.recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  print('Recipe: ${state.recipes[index]}');
                  return GestureDetector(
                    onTap: () {
                      final recipe = state.recipes[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeScreen(
                              recipeId: recipe.id,
                              recipeName: recipe.name,
                              recipeDescription: recipe.description,
                              recipeImage: recipe.image, discount: '',

                            ),
                          ));
                    },
                    child: ListTile(
                      title: Text(state.recipes[index].name),
                      subtitle: Text(state.recipes[index].description),
                      leading: Image.memory(
                        base64Decode(
                            state.recipes[index].image.split(',').last),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
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
