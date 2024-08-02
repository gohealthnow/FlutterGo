import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/interfaces/user_interface.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';

class UserRepository implements IUser {
  late final Dio client;

  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? jwtSecret = dotenv.env['JWT_SECRET'];

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
    SharedLocalStorageService().put('token', response.data['token']);
    SharedLocalStorageService().put('profile', model);

    return model;
  }

  @override
  bool checkToken() {
    return SharedLocalStorageService().get('token') != null;
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
