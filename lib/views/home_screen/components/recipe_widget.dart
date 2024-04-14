import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import 'package:recipes/views/home_screen/components/view_clothes_widget.dart';
import '../../../constance.dart';
import '../../clothes_detail_screen/clothes_detail_screen.dart';


class ClothesCard extends StatelessWidget {
  const ClothesCard({super.key});

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
            final clothesList = state.clothes;
            return SizedBox(
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
                  final clothes = clothesList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClothesScreen(
                              recipeId: clothes.id,
                              recipeName: clothes.name,
                              recipeDescription: clothes.description,
                              recipeImage: clothes.image, discount: '',
                            ),
                          ));
                    },
                    child: ViewClothes(
                      name: clothes.name ??"",
                      image: clothes.image??"",
                      description: clothes.description??"",
                    )
                  );
                },
                itemCount: clothesList.length,
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
