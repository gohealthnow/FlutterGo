import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.example.com';

class UserRepository {
  static Future<String> authenticate(GlobalKey<FormState> credentialsFormState,
      TextEditingController email, TextEditingController password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/authenticate'),
      body: {
        'email': email.text,
        'password': password.text,
      },
    );

    if (response.statusCode == 200) {
      // Autenticação bem-sucedida, retornar o token JWT
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.body);
      return response.body;
    } else {
      // Autenticação falhou, lançar uma exceção ou retornar null
      throw Exception('Falha na autenticação');
    }
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
    if (prefs.getString('token') != null) {
      return prefs.getString('token')!;
    }
    throw Exception('Token not found');
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

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
