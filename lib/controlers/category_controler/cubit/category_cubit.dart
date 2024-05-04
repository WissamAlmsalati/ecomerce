import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../moudels/category/category_module.dart';
import '../../../moudels/category/category_resposity.dart';
import 'package:http/http.dart' as http;

part 'category_state.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> fetchCategory() async {
    emit(CategoryLoading());
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/categories'));
      if (response.statusCode == 200) {
        final categoriesJson = jsonDecode(response.body) as List;
        final categories = categoriesJson.map((categoryJson) => Category.fromJson(categoryJson)).toList();
        emit(CategoryLoaded(categories));
      } else {
        emit(CategoryError('Failed to load categories: ${response.statusCode} ${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(CategoryError('Failed to load categories: $e'));
    }
  }
}