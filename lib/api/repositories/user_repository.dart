import 'package:dio/dio.dart';
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

    if(response.statusCode == 401) {
      throw Exception('Erro ao logar');
    }

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

  Future<Map<String, String>> resetPassword(String email) async {
    var response = await userNetworkClient.client.post('/user/forget', data: {
      'email': email,
    });

    if (response.statusCode != 200) {
      throw Exception('Erro ao resetar senha');
    }

    return response.data;
  }

  void unlinkProductinUser(ProductModels product, int user) async {
    await userNetworkClient.client
        .post('/user/product/unlink', data: {'prodid': product.id, 'id': user});
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

  purchaseItem(
      {required int id,
      required int productId,
      required int quantity,
      required int pharid}) async {
    var response = await userNetworkClient.client.post('/user/product/buy',
        data: {
          'id': id,
          'prodid': productId,
          'pharid': pharid,
          'quantity': quantity
        });

    return response.data;
  }

  Future<List<Order>> getOrder({required UserModels user}) async {
    var response = await userNetworkClient.client.post("/user/order", data: {
      'id': user.id,
    });

    List<Order> model = [];

    for (var item in response.data['order']) {
      model.add(Order.fromJson(item));
    }

    return model;
  }

  Future<bool> createReview(
      {required int user,
      required int product,
      required String review,
      required int rating}) async {
    var response = await userNetworkClient.client.post('/user/review', data: {
      'id': user,
      'prodid': product,
      'rating': rating,
      'comment': review
    });

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
