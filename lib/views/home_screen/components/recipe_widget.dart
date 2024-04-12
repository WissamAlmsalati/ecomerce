import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import '../../../constance.dart';
import '../../../moudels/recipes/clothing_repository.dart';
import '../../recipe_screen/recipe_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constans = Constans(context);

    return BlocProvider(
      create: (context) => FetchRecipesCubit()..fetchRecipes(),
      child: BlocBuilder<FetchRecipesCubit, FetchRecipesState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            final recipes = state.recipes;
            return Container(
              height: constans.height * 0.4,
              width: constans.width * 0.96,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return GestureDetector(
                    onTap: () {
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: constans.height * 0.19,
                            width: constans.width * 0.47,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(recipe.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(recipe.name),
                          Text(recipe.description),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: recipes.length,
              ),
            );
          } else if (state is DataError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
