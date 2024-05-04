import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/moudels/recipes/clothing_module.dart';


class ClothingRepository {
  final String serverUrl = 'http://your_server_url';

  Future<String> addRecipe(Map<String, dynamic> clothingData) async {
    final response = await http.post(
      Uri.parse('$serverUrl/addRecipe'),
      body: jsonEncode(clothingData),
      headers: {"Content-Type": "application/json"},
    );
    return jsonDecode(response.body)['id'];
  }

  Future<List<Clothing>> fetchData() async {
    final response = await http.get(Uri.parse('$serverUrl/fetchData'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Clothing.fromJson(item)).toList();
  }

  Future<List<Clothing>> fetchDataByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('$serverUrl/fetchDataByCategory/$categoryId'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Clothing.fromJson(item)).toList();
  }

  Future<List<Clothing>> fetchDataByName(String name) async {
    final response = await http.get(Uri.parse('$serverUrl/fetchDataByName/$name'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Clothing.fromJson(item)).toList();
  }

  Future<Clothing> fetchDataByOneId(String id) async {
    final response = await http.get(Uri.parse('$serverUrl/fetchDataByOneId/$id'));
    return Clothing.fromJson(jsonDecode(response.body));
  }

  Future<void> updateRecipe(String id, Map<String, dynamic> recipeData) async {
    await http.put(
      Uri.parse('$serverUrl/updateRecipe/$id'),
      body: jsonEncode(recipeData),
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<void> deleteRecipe(String id) async {
    await http.delete(Uri.parse('$serverUrl/deleteRecipe/$id'));
  }
}