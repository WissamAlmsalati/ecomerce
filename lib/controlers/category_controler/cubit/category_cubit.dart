import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../moudels/category/category_module.dart';
import '../../../moudels/category/category_resposity.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future <void> fetchCategory() async{
  emit(CategoryLoading());
  try {
    final categoriesData = await CategoryResposity().fetchData();
    final categories = categoriesData.map((data) => Category.fromMap(data)).toList();
    emit(CategoryLoaded(categories));
  } catch (e) {
    emit(CategoryError(e.toString()));
  }
}
}
