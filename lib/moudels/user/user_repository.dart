
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipes/moudels/user/user_module.dart';
class UserRepository  {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

// ignore: non_constant_identifier_names
static Future<void> SignUp(String email, String password, String phone, String name ,BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? firebaseUser = userCredential.user;

    if (firebaseUser != null) {
      AppUser appUser = AppUser(
        id: firebaseUser.uid,
        email: email,
        name: name,
        password: password,
        phone: phone,
      );

      await _db.collection('users').doc(firebaseUser.uid).set(appUser.toMap());
    }
  } catch (e) {
    if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
      //show alert dialog
      throw Exception('The account already exists for that email.');
    } else {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('An unknown error occurred.');
    }
  }
}



// ignore: non_constant_identifier_names
static Future<AppUser?> SignIn( String email, String password) async {
  try {
    // Sign in the user
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get the User object
    User? firebaseUser = userCredential.user;

    if (firebaseUser != null) {
      // Fetch the user data from Firestore
      DocumentSnapshot doc = await _db.collection('users')
          .doc(firebaseUser.uid)
          .get();

      // Create a new AppUser object
      AppUser appUser = AppUser.fromMap(doc.data() as Map<String, dynamic>);

      return appUser;
    } else {
      throw Exception('Sign in failed.');
    }
  } catch (e) {
    if (e is FirebaseAuthException && e.code == 'user-not-found') {
      throw Exception('No user found for this email.');
    } else {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('An unknown error occurred.');
    }
  }
}

// ignore: non_constant_identifier_names
static Future<void> SignOut() async {
  await _auth.signOut();
}

static Future<AppUser?> getCurrentUser() async {
  try {
    // Get the current user
    User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      // Fetch the user data from Firestore
      DocumentSnapshot doc = await _db.collection('users')
          .doc(firebaseUser.uid)
          .get();

      // Create a new AppUser object
      AppUser appUser = AppUser.fromMap(doc.data() as Map<String, dynamic>);

      return appUser;
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}

static Future<void> updateProfile(String name, String phone) async {
  try {
    // Get the current user
    User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      // Update the user data in Firestore
      await _db.collection('users')
          .doc(firebaseUser.uid)
          .update({
        'name': name,
        'phone': phone,
      });
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

static Future<void> updatePassword(String password) async {
  try {
    // Get the current user
    User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      // Update the user password
      await firebaseUser.updatePassword(password);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

 static Future<AppUser?> fetchUser(String id) async {
    DocumentSnapshot doc = await _db.collection('users').doc(id).get();
    if (doc.exists) {
      // Assuming that AppUser has a factory constructor that creates an instance from a Map
      return AppUser.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

}