import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../moudels/recipes/recipes_module.dart';
import '../../../moudels/recipes/recipes_repository.dart';

part 'fetch_recipes_state.dart';

class FetchRecipesCubit extends Cubit<FetchRecipesState> {
  FetchRecipesCubit() : super(FetchRecipesInitial());

  Future<void> fetchRecipes() async {
    emit(DataLoading());
    try {
      final recipes = await RecipesRepository().fetchData();
      emit(DataLoaded(recipes, [])); // Pass an empty list for recipesById
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> fetchRecipesByCategory(String categoryId) async {
    emit(DataLoading());
    try {
      final recipes = await RecipesRepository().fetchDataByCategory(categoryId);
      emit(DataLoaded(recipes, [])); // Pass an empty list for recipesById
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }


}