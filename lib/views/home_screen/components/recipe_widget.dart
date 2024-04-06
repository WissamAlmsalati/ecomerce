import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import '../../../constance.dart';
import '../../../moudels/category/category_module.dart';
import '../../../moudels/recipes/recipes_repository.dart';
import '../../recipe_screen/recipe_screen.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchRecipesCubit()..fetchRecipes(),
      child: BlocBuilder<FetchRecipesCubit, FetchRecipesState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            final recipes = state.recipes;
            return Container(
              height: Constans.height(context) * 0.4,
              width: Constans.width(context) * 0.96,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              recipeImage: recipe.image,
                              recipeIngredients: recipe.ingredients.toString(),
                              recipeSteps: recipe.steps.toString(),
                            ),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: Constans.height(context) * 0.22,
                              width: Constans.width(context) * 0.47,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                  image: MemoryImage(
                                    base64Decode(recipe.image.split(',').last),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(recipe.name),
                            Text(recipe.description),
                          ],
                        ),
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
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Future<void> _deleteRecipe(String id) async {
    // Create an instance of RecipesRepository
    RecipesRepository repository = RecipesRepository();
    try {
      // Call the method to delete the recipe
      await repository.deleteRecipe(id);
      print('Recipe deleted successfully');
    } catch (e) {
      print(e);
    }
  }
}
