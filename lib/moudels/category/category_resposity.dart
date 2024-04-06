import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase/firebase_firestore.dart';

class CategoryResposity {

  final FirestoreServiceImpl _firestoreService = FirestoreServiceImpl();

  Future<String> addCategory(Map<String, dynamic> categoryData) async {
    // Create a new document reference with auto-generated ID
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('categories').doc();

    // Add the auto-generated ID to the recipe data
    categoryData['id'] = docRef.id;

    // Use the set method to add the recipe
    await docRef.set(categoryData);

    // Return the auto-generated ID
    return docRef.id;
  }

  Future<void> deleteCategory(String id) async {
    await _firestoreService.delete('categories', id);
  }

  Future<void> updateCategory(String id, Map<String, dynamic> categoryData) async {
    await _firestoreService.update('categories', id, categoryData);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    // Fetch data from Firestore and convert it to a list of Recipe objects
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}