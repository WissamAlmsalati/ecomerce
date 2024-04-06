import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes/firebase/firebase_firestore.dart';

import 'bannerModule.dart';



class BannerRepostry {
  final FirestoreServiceImpl _firestoreService = FirestoreServiceImpl();

  Future<String> addBanner(BannerMoudule bannerMoudule) async {
    // Create a new document reference with auto-generated ID
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('banners').doc();

    // Add the auto-generated ID to the banner data
    Map<String, dynamic> bannerData = bannerMoudule.toJson();
    bannerData['id'] = docRef.id;

    // Use the set method to add the banner
    await docRef.set(bannerData);

    // Return the auto-generated ID
    return docRef.id;
  }

  Future<void> deleteBanner(String id) async {
    await _firestoreService.delete('banners', id);
  }

  Future<void> updateBanner(String id, BannerMoudule bannerMoudule) async {
    await _firestoreService.update('banners', id, bannerMoudule.toJson());
  }

  Future<List<BannerMoudule>> fetchData() async {
    // Fetch data from Firestore and convert it to a list of Banner objects
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("banners").get();
    return querySnapshot.docs
        .map((doc) => BannerMoudule.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}