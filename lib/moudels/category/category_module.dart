import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/categories'));

  if (response.statusCode == 200 && response.body != null) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Category.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

class Category {
  final int id;
  final String name;
  final String picturePath;

  Category({required this.id, required this.name, required this.picturePath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] ?? 'Default Name', // If name is null, assign 'Default Name'
      picturePath: json['photoUrl'] ?? 'Default Path', // If picturePath is null, assign 'Default Path'
    );
  }
}