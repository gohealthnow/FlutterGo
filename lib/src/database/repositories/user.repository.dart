import 'dart:convert';
import 'package:gohealth/src/database/models/user.models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:3000';
final String jwtSecret = dotenv.env['JWT_SECRET'] ?? 'http://localhost:3000';

class UserRepository {
  static Future<bool> authenticate(
      TextEditingController email, TextEditingController password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      body: {
        'email': email.text,
        'password': password.text,
      },
    );

    if (response.statusCode == 200) {
      // Autenticação bem-sucedida, retornar o token JWT
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.body);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> registerUser(TextEditingController email,
      TextEditingController name, TextEditingController password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email.text,
        'name': name.text,
        'password': password.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];

      try {
        // Verify a token (SecretKey for HMAC & PublicKey for all the others)
        final jwt = JWT.verify(token, SecretKey(jwtSecret));

        jwt.payload;
      } on JWTExpiredException {
        print('jwt expired');
      } on JWTException catch (ex) {
        print(ex.message); // ex: invalid signature
      }
    } else {
      return false;
    }

    return false; // Add this line to return a value at the end of the method
  }

  static Future<bool> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      return true;
    }
    return false;
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {}
    return '';
  }

  static Future<User> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Perfil do usuário obtido com sucesso, retornar um objeto User
      return User.fromJson(response.body as Map<String, dynamic>);
    } else {
      // Falha ao obter o perfil do usuário, lançar uma exceção ou retornar null
      throw Exception('Falha ao obter o perfil do usuário');
    }
  }
}
