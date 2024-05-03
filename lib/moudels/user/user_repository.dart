import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipes/moudels/user/user_module.dart';

class UserController {
  static const String baseUrl =
      'http://10.0.2.2:8080'; // Replace with your backend API base URL

  Future<void> storeUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id ?? 0);
    await prefs.setString('email', user.email);
    await prefs.setString('username', user.username);
    await prefs.setString('phone', user.phone);
  }

  Future<String?> getCurrentUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<UserModel?> signup(
      String email, String username, String password, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'username': username,
          'password': password,
          'phone': phone,
        }),
      );

      if (response.statusCode == 201) {
        // Successful signup
        print('Signed up successfully');
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        await storeUserData(user);
        return user;
      } else {
        // Failed signup, handle error
        print('Failed to sign up: ${response.body}');
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      // Exception occurred, handle error
      print('Exception occurred during signup: $e');
      throw Exception('Failed to sign up');
    }
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print('Logged in successfully');
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        await storeUserData(user);
        return user;
      } else {
        print('Failed to log in: ${response.body}');
        throw Exception('Failed to log in');
      }
    } catch (e) {
      // Exception occurred, handle error
      print('Exception occurred during login: $e');
      throw Exception('Failed to log in');
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 201) {
        // Successful logout
        print('Logged out successfully');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear(); // Clear all data
      } else {
        // Failed logout, handle error
        print('Failed to log out: ${response.body}');
        throw Exception('Failed to log out');
      }
    } catch (e) {
      // Exception occurred, handle error
      print('Exception occurred during logout: $e');
      throw Exception('Failed to log out');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? email = prefs.getString('email');
    String? username = prefs.getString('username');
    String? phone = prefs.getString('phone');

    if (id != null && email != null && username != null && phone != null) {
      return UserModel(
        id: id,
        email: email,
        username: username,
        phone: phone,
        password: '',
      );
    } else {
      return null;
    }
  }
}
