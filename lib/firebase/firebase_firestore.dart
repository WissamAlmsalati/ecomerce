// Import the cloud_firestore package at the top of your file
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';


// Define the FirestoreService abstract class
abstract class FirestoreService {
  Future<void> add(String collection, Map<String, dynamic> data);
  Future<void> fetchData(String collection);
  Future<void> getDataById(String Collection ,String id);
  Future<void> update(String collection, String id, Map<String, dynamic> data);
  Future<void> delete(String collection, String id);
}

// Define a concrete class that extends FirestoreService
class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> add(String collection, Map<String, dynamic> data) async {
    await _db.collection(collection).add(data);
  }

  @override
  Future<void> update(String collection, String id, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(id).update(data);
  }

  @override
  Future<void> delete(String collection, String id) async {
    await _db.collection(collection).doc(id).delete();
  }


  @override
  Future<void> fetchData(String collection) {
   
    throw UnimplementedError();
  }

@override
Future<DocumentSnapshot> getDataById(String collection ,String id) async {
  return await _db.collection(collection).doc(id).get();
}
}
