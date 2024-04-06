class Recipe {
  String id;
  String name;
  String description;
  String image;
  String category;
  String difficulty;
  String duration;
  List<String> ingredients;
  List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.ingredients,
    required this.steps,
  });

  // Define a fromMap constructor to create a Recipe object from a map
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      category: map['category'],
      difficulty: map['difficulty'],
      duration: map['duration'],
      ingredients: List<String>.from(map['ingredients'] ?? []),
      steps: List<String>.from(map['steps'] ?? []),
    );
  }

  // Define a toMap method to convert a Recipe object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'difficulty': difficulty,
      'duration': duration,
      'ingredients': ingredients,
      'steps': steps,
    };
  }
}
