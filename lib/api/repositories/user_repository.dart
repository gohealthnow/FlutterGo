import 'package:gohealth/api/interfaces/client_http_interface.dart';
import 'package:gohealth/api/interfaces/user_interface.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRepository implements IUser {
  final IClientHttp client;
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:3000';
  final String jwtSecret = dotenv.env['JWT_SECRET'] ?? 'http://localhost:3000';

  UserRepository(this.client);

  @override
  Future<UserModels> authenticate(
      TextEditingController email, TextEditingController password) async {
    var response = await client.get('$baseUrl/user/authenticate');

    UserModels model = UserModels.fromJson(response['0']);
    return model;
  }

  @override
  Future<bool> checkToken() {
    // TODO: implement checkToken
    throw UnimplementedError();
  }

  @override
  Future delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String key) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future put(String key, value) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<bool> registerUser(TextEditingController email,
      TextEditingController name, TextEditingController password) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
