import 'dart:convert';

import 'package:arraid/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  // Save user data locally
  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    print(prefs.getString('user'));
      print("saved user"  );
      print(user.isEmployee);
      print(user.email);

  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');

    if (userData != null) {
       print(" user mot null"  );
      return User.fromJson(jsonDecode(userData));
    }else{
      
    return User(id: "0", email: "example", firstName: "thameur", lastName: "alrraid",type: 'admin',isEmployee: 'true');
    }
    return null;
  }

  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
