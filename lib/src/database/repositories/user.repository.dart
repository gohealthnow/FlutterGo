import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl =
      'https://api.example.com'; // Substitua pela sua URL base

  Future<String> authenticate(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authenticate'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Autenticação bem-sucedida, retornar o token JWT
      return response.body;
    } else {
      // Autenticação falhou, lançar uma exceção ou retornar null
      throw Exception('Falha na autenticação');
    }
  }

  Future<User> getUserProfile(String token) async {
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
