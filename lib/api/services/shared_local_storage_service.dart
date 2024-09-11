import 'dart:convert';

import 'package:gohealth/api/interfaces/local_storage_interface.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.remove(key);
  }

  Future<UserModels?> getProfile() async {
    var shared = await SharedPreferences.getInstance();
    var productString = shared.getString('product');
    var product = productString != null
        ? jsonDecode(productString) as Map<String, dynamic>?
        : null;

    var user = UserModels(
      id: shared.getInt('id'),
      createdAt: shared.getString('createdAt'),
      updatedAt: shared.getString('updatedAt'),
      email: shared.getString('email'),
      name: shared.getString('name'),
      product: product,
      avatar: shared.getString('avatar'),
      bio: shared.getString('bio'),
      role: shared.getString('role'),
    );

    return user;
  }

  Future<UserModels> putProfile(UserModels user) async {
    var shared = await SharedPreferences.getInstance();

    for (var key in user.toJson().keys) {
      if (key == 'id') {
        shared.setInt(key, user.toJson()[key] as int);
        continue;
      } else {
        var shared = await SharedPreferences.getInstance();
        shared.setString(key, user.toJson()[key].toString());
      }
    }
  
    return user;
  }

  @override
  Future<String?> get(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.getString(key);
  }

  @override
  Future put(String key, dynamic value) async {
    var shared = await SharedPreferences.getInstance();
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    } else if (value is UserModels) {
      shared.setString(key, value.toJson().toString());
    }
  }

  void clearProfile() {
    var shared = SharedPreferences.getInstance();
    shared.then((value) {
      value.clear();
    });
  }

  void saveProduct(ProductModels productModels) {
    var shared = SharedPreferences.getInstance();
    shared.then((value) {
      var products = value.getString('products');
      List<ProductModels> list = [];
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        list = decoded.map((e) => ProductModels.fromJson(e)).toList();
      }
      list.add(productModels);
      value.setString('products', jsonEncode(list));
    });
  }

  Future<List<ProductModels>> getAllProducts() {
    var shared = SharedPreferences.getInstance();
    return shared.then((value) {
      var products = value.getString('products');
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        return decoded.map((e) => ProductModels.fromJson(e)).toList();
      } else {
        throw Exception('No products found');
      }
    });
  }

  getSelectedItems() {
    var shared = SharedPreferences.getInstance();
    return shared.then((value) {
      var products = value.getString('products');
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        return decoded.map((e) => e.toString()).toList();
      } else {
        throw Exception('No products found');
      }
    });
  }
}
