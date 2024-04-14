part of 'fetch_recipes_cubit.dart';

@immutable
abstract class FetchRecipesState {}

class FetchRecipesInitial extends FetchRecipesState {}

class DataLoading extends FetchRecipesInitial{}

class DataLoaded extends FetchRecipesInitial{
  final List<Clothing> clothes;
  final List<Clothing> clothesById;


  DataLoaded(this.clothes, this.clothesById);
}

class DataError extends FetchRecipesInitial{
  final String message;
  DataError(this.message);
}

class DataAdded extends FetchRecipesInitial{}