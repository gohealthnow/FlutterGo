import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gohealth/api/interfaces/user_interface.dart';
import 'package:gohealth/api/models/user_models.dart';

class UserRepository implements IUser {
  late final Dio client;
  final String baseUrl = "http://192.168.18.242:3000";
  final String jwtSecret = "AGUeQ8bNvmNyV5grj1x8jl4C92UsSWP3o0WypU30MxrlSlHFfD";

  UserRepository() {
    client = Dio();
  }

  @override
  Future<UserModels> authenticate(String email, String password) async {
    var response = await client.post('$baseUrl/user/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(headers: {
          'Authorization': jwtSecret,
        }));

    UserModels model = UserModels.fromJson(response.data['user']);
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
  Future<bool> registerUser(String email, String name, String password) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
