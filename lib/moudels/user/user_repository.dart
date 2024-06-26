import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/service.dart';
import 'package:recipes/views/app_body.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipes/moudels/user/user_module.dart';

class UserController {
  static const String baseUrl = 'http://10.0.2.2:3000';

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

  Future<void> signup(
      String username, String email, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      print('User signed up successfully');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to sign up user');
    }
  }

  Future<UserModel?> login( String email, String password ,BuildContext context) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

    try {
      print('Response: ${response.body}');
    } catch (e) {
      print('Failed to print response: $e');
    }

    if (response.statusCode == 200) {
      print('Logged in successfully');
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppBody()));
      await storeUserData(user);
      return user;
    } else if (response.statusCode == 500) {
      print('Server error: ${response.body}');
      throw Exception('Server error');
    } else {
      print('Failed to log in: ${response.body}');
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
    String email = prefs.getString('email') ?? '';
    String username = prefs.getString('username') ?? '';
    String phone = prefs.getString('phone') ?? '';

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
