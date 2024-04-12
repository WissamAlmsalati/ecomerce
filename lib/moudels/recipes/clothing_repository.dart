import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes/firebase/firebase_firestore.dart';
import 'package:recipes/moudels/recipes/clothing_module.dart';

class ClothingRepository {
  final FirestoreServiceImpl _firestoreService = FirestoreServiceImpl();

  Future<String> addRecipe(Map<String, dynamic> clothingData) async {
    // Create a new document reference with auto-generated ID
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('clothing').doc();

    // Add the auto-generated ID to the recipe data
    clothingData['id'] = docRef.id;

    // Use the set method to add the recipe
    await docRef.set(clothingData);

    // Return the auto-generated ID
    return docRef.id;
  }

  Future<List<Clothing>> fetchData() async {
    // Fetch data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("clothing").get();
    return querySnapshot.docs
        .map((doc) => Clothing.fromMap(
              doc.data() as Map<String, dynamic>,
            ))
        .toList();
  }

  Future<List<Clothing>> fetchDataByCategory(String categoryId) async {
    // Fetch all data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("clothing").get();

    // Convert all documents to Recipe objects
    List<Clothing> allRecipes = querySnapshot.docs
        .map((doc) => Clothing.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    // Filter the recipes by category
    List<Clothing> filteredRecipes =
        allRecipes.where((Clothing) => Clothing.category == categoryId).toList();

    return filteredRecipes;
  }

 Future<List<Clothing>> fetchDataByName(String name) async {
  // Fetch all data from Firestore and convert it to a list of Clothing objects
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("clothing").get();

  // Convert all documents to Clothing objects
  List<Clothing> allClothing = querySnapshot.docs
      .map((doc) => Clothing.fromMap(doc.data() as Map<String, dynamic>))
      .toList();

  // Filter the clothing by name
  List<Clothing> filteredClothing =
      allClothing.where((Clothing) => Clothing.name == name).toList();

  return filteredClothing;
}

  Future<Clothing> fetchDataByOneId(String id) async {
    // Fetch all data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("clothing").get();

    // Convert all documents to Recipe objects
    List<Clothing> allRecipes = querySnapshot.docs
        .map((doc) => Clothing.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    // Find the recipe with the provided ID
    Clothing clothing = allRecipes.firstWhere((recipe) => recipe.id == id, );

    return clothing; // Return the found recipe (or null if not found)
  }


  Future<void> updateRecipe(String id, Map<String, dynamic> recipeData) async {
    await _firestoreService.update('clothing', id, recipeData);
  }

  Future<void> deleteRecipe(String id) async {
    await _firestoreService.delete('clothing', id);
  }
}
