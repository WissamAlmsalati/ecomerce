import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes/firebase/firebase_firestore.dart';
import 'package:recipes/moudels/recipes/recipes_module.dart';

class RecipesRepository {
  final FirestoreServiceImpl _firestoreService = FirestoreServiceImpl();

  Future<String> addRecipe(Map<String, dynamic> recipeData) async {
    // Create a new document reference with auto-generated ID
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('recipes').doc();

    // Add the auto-generated ID to the recipe data
    recipeData['id'] = docRef.id;

    // Use the set method to add the recipe
    await docRef.set(recipeData);

    // Return the auto-generated ID
    return docRef.id;
  }

  Future<List<Recipe>> fetchData() async {
    // Fetch data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("recipes").get();
    return querySnapshot.docs
        .map((doc) => Recipe.fromMap(
              doc.data() as Map<String, dynamic>,
            ))
        .toList();
  }

  Future<List<Recipe>> fetchDataByCategory(String categoryId) async {
    // Fetch all data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("recipes").get();

    // Convert all documents to Recipe objects
    List<Recipe> allRecipes = querySnapshot.docs
        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    // Filter the recipes by category
    List<Recipe> filteredRecipes =
        allRecipes.where((recipe) => recipe.category == categoryId).toList();

    return filteredRecipes;
  }

  Future<Recipe> fetchDataByOneId(String id) async {
    // Fetch all data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("recipes").get();

    // Convert all documents to Recipe objects
    List<Recipe> allRecipes = querySnapshot.docs
        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    // Find the recipe with the provided ID
    Recipe recipe = allRecipes.firstWhere((recipe) => recipe.id == id, );

    return recipe; // Return the found recipe (or null if not found)
  }


  Future<void> updateRecipe(String id, Map<String, dynamic> recipeData) async {
    await _firestoreService.update('recipes', id, recipeData);
  }

  Future<void> deleteRecipe(String id) async {
    await _firestoreService.delete('recipes', id);
  }
}
