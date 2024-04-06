
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes/moudels/user/user_module.dart';
import '../../firebase/firebase_firestore.dart';

class UserRepository  {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _db = FirebaseFirestore.instance;

static Future<void> SignUp(String email, String password, String phone, String name) async {
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
      throw Exception('The email is already in use.');
    } else {
      print(e);
      throw Exception('An unknown error occurred.');
    }
  }
}



static Future<AppUser?> SignIn(String email, String password) async {
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
      print(e);
      throw Exception('An unknown error occurred.');
    }
  }
}

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
    print(e);
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
    print(e);
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
    print(e);
  }
}


}