import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gohealth/api/interfaces/user_interface.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';

class UserRepository implements IUser {
  late HttpClient userNetworkClient;

  UserRepository() {
    userNetworkClient = HttpClient();
  }

  @override
  Future<UserModels> login(String email, String password) async {
    var response = await userNetworkClient.client.post('/user/login', data: {
      'email': email,
      'password': password,
    });

    logout();

    UserModels model = UserModels.fromJson(response.data['user']);
    SharedLocalStorageService().put('token', response.data['token']);
    SharedLocalStorageService().putProfile(model);

    return model;
  }

  @override
  Future<UserModels> registerUser(
      String email, String name, String password) async {
    var response = await userNetworkClient.client.post('/user/register', data: {
      'email': email,
      'name': name,
      'password': password,
    });

    logout();

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
      var response = await userNetworkClient.client.get('/user/$id');
      if (kDebugMode) {
        print(response.data);
      }
      final user = response.data['user'];
      final products = user['Product'];
      return products == null || products.isEmpty;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      } else {
        rethrow;
      }
    }
  }

  void linkProductinUser(ProductModels product, int user) async {
    await userNetworkClient.client
        .post('/user/product', data: {'prodid': product.id, 'id': user});
  }

  Future<UserModels?> getbyId(int id) async {
    var response = await userNetworkClient.client.get('/user/$id');

    if (response.data['user'] == null) {
      return UserModels();
    }
    
    UserModels model = UserModels.fromJson(response.data['user']);
    return model;
  }
}
