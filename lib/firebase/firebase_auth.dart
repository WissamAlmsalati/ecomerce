
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final supabase = Supabase.instance.client;
  static Future<User?> signIn(String email, String password) async {
    try {
      final result = await supabase.auth.signIn(email: email, password: password);
      if (result.error != null) {
        print(result.error!.message);
        return null;
      }
      final user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<User?> signUp(String email, String password) async {
    try {
      final result = await supabase.auth.signUp(email: email, password: password);
      if (result.error != null) {
        print(result.error!.message);
        return null;
      }
      final user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<void> addUser(String name, String email) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('You must be signed in to add a user');
    }

    final result = await supabase.from('users').insert([
      {
        'id': user.id, // Use Supabase's generated UUID for ID
        'name': name,
        'email': email,
      },
    ]);

    if (result.error != null) {
      print(result.error!.message);
      throw Exception('Failed to add user');
    }
  }
}
