import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../moudels/recipes/clothing_module.dart';
import '../../../moudels/recipes/clothing_repository.dart';

part 'fetch_recipes_state.dart';

class FetchRecipesCubit extends Cubit<FetchRecipesState> {
  FetchRecipesCubit() : super(FetchRecipesInitial());

  Future<void> fetchRecipes() async {
    emit(DataLoading());
    try {
      final recipes = await ClothingRepository().fetchData();
      emit(DataLoaded(recipes, [])); // Pass an empty list for recipesById
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> fetchRecipesByCategory(String categoryId) async {
    emit(DataLoading());
    try {
      final recipes = await ClothingRepository().fetchDataByCategory(categoryId);
      emit(DataLoaded(recipes, [])); // Pass an empty list for recipesById
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> fetchRecipesByName(String name) async {
    emit(DataLoading());
    try {
      final recipes = await ClothingRepository().fetchDataByName(name);
      emit(DataLoaded(recipes, [])); // Pass an empty list for recipesById
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }


}