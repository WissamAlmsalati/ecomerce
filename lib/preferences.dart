import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUserLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('isLoggedIn', value);
  }

  Future<bool> getUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}