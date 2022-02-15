import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_app_todo/model/sign_in_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const JWT_KEY = 'JWT';
  static const baseUrl = 'https://todo-lovepeople.herokuapp.com';

  Future<SignInResponse?> login(String email, String senha) {
    var url = Uri.parse('$baseUrl/auth/local');
    return http.post(
      url,
      body: {
        'identifier': email,
        'password': senha,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(value.body);
        var response = SignInResponse.fromJson(json);
        await saveToken(response.jwt!);
        return response;
      } else {
        return null;
      }
    });
  }

  static Future saveToken(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(JWT_KEY, jwt);
  }

  static Future<String?> getToken(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(JWT_KEY);
  }
}
