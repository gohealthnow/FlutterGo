import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/interfaces/user_interface.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';

class UserRepository implements IUser {
  late Dio client;

  UserRepository() {
    client = Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? 'http://10.0.0.7:3000',
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  @override
  Future<UserModels> login(String email, String password) async {
    var response = await client.post('/user/login', data: {
      'email': email,
      'password': password,
    });

    logout();

    if (response.statusCode == 401) {
      throw Exception('Usuário ou senha inválidos');
    }

    UserModels model = UserModels.fromJson(response.data['user']);
    SharedLocalStorageService().put('token', response.data['token']);
    SharedLocalStorageService().putProfile(model);

    return model;
  }

  @override
  Future<UserModels> registerUser(
      String email, String name, String password) async {
    var response = await client.post('/user/register', data: {
      'email': email,
      'name': name,
      'password': password,
    });

    logout();

    if (response.statusCode == 409) {
      throw Exception('Usuário já cadastrado');
    }

    UserModels model = UserModels.fromJson(response.data['user']);
    SharedLocalStorageService().put('token', response.data['token']);
    SharedLocalStorageService().putProfile(model);

    return model;
  }

  Future<bool> checkToken() {
    return SharedLocalStorageService().get('token').then((value) {
      if (value != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  logout() {
    SharedLocalStorageService().delete('token');
    SharedLocalStorageService().clearProfile();
  }

  Future<bool> doesUserHaveProduct(int? id) async {
    if (id == null) {
      return false;
    }
    try {
      var response = await client.post('/user/$id');
      if (kDebugMode) {
        print(response.data);
      }
      return response.data['user']['product'] != null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      } else {
        rethrow;
      }
    }
  }
}
