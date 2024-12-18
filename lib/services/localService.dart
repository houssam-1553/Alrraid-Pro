import 'dart:convert';
import 'dart:typed_data';
import 'package:arraid/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  // Save token
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  // Get token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Clear token
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  // Save user data
  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
   // print("User saved: ${user.email}, ${user.firstName}, ${user.id}");
  }

  // Get user data
  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    } else {
      // Default user if not found in SharedPreferences
      return User(id: "0", email: "example", firstName: "thameur", lastName: "alrraid", type: 'admin', isEmployee: 'true', clerkId: '');
    }
  }

  // Clear user data
  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  // Save the "Remember Me" flag
  static Future<void> saveRememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  // Get the "Remember Me" flag
  static Future<bool> getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;  // Default to false if not set
  }

  // Save the email and password when Remember Me is checked
  static Future<void> saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // Get the saved email and password
  static Future<Map<String, String?>> getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    return {'email': email, 'password': password};
  }

  // Clear saved credentials
  static Future<void> clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

   // Save profile image in SharedPreferences
  static Future<void> saveProfileImage(Uint8List imageBytes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    await prefs.setString('profileImage', base64Image);
  //  print("Profile image saved.");
  }

  // Load profile image as Uint8List
  static Future<Uint8List?> loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profileImage');
    
    if (base64Image != null) {
      try {
        return base64Decode(base64Image);
      } catch (e) {
       // print("Error decoding profile image: $e");
      }
    }
    return null; // Return null if no image is saved or decoding fails
  }

}
