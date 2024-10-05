import 'dart:convert';

import 'package:gohealth/api/interfaces/local_storage_interface.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/pharmacy_to_product.dart';
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
      createdAt: shared.getString('createdAt') != null
          ? DateTime.parse(shared.getString('createdAt')!)
          : null,
      updatedAt: shared.getString('updatedAt') != null
          ? DateTime.parse(shared.getString('updatedAt')!)
          : null,
      email: shared.getString('email'),
      name: shared.getString('name'),
      products: product != null
          ? (product['products'] as List)
              .map((e) => ProductModels.fromJson(e))
              .toList()
          : null,
      avatar: shared.getString('avatar'),
      bio: shared.getString('bio'),
      role: shared.getString('role') != null
          ? Role.values.firstWhere(
              (e) => e.toString() == 'Role.' + shared.getString('role')!)
          : null,
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

  Future<List<CartItem>> fetchAllCartItems() {
    var shared = SharedPreferences.getInstance();
    return shared.then((value) {
      var products = value.getString('cart');
      List<CartItem> list = [];
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        list = decoded.map((e) => CartItem.fromJson(e)).toList();
      }
      return list;
    });
  }

  Future<List<ProductModels>> getProductsForCart() {
    var shared = SharedPreferences.getInstance();
    return shared.then((value) {
      var products = value.getString('cart');
      List<CartItem> list = [];
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        list = decoded.map((e) => CartItem.fromJson(e)).toList();
      }
      return list.map((e) => e.product).toList();
    });
  }

  void removeProductTocart({required int id}) {
    var shared = SharedPreferences.getInstance();
    shared.then((value) {
      var products = value.getString('cart');
      List<CartItem> list = [];
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        list = decoded.map((e) => CartItem.fromJson(e)).toList();
      }
      list.removeWhere((element) => element.product.id == id);
      value.setString('cart', jsonEncode(list.map((e) => e.toJson()).toList()));
    });
  }

  void clearCart() {
    var shared = SharedPreferences.getInstance();
    shared.then((value) {
      value.remove('cart');
    });
  }

  addProductToCart(
      {required ProductModels product,
      required PharmacyModels pharmacy,
      required int quantity}) {
    final _repositoryStock = PharmacyUserRepository();

    var shared = SharedPreferences.getInstance();
    shared.then((value) async {
      var products = value.getString('cart');
      List<CartItem> list = [];
      if (products != null) {
        var decoded = jsonDecode(products) as List;
        list = decoded.map((e) => CartItem.fromJson(e)).toList();
      }

      // Obter a quantidade disponível do produto na farmácia
      int availableQuantity = (await _repositoryStock.getAvailableQuantity(
        pharmacy.id!,
        product.id!,
      ));

      // Verificar se a quantidade solicitada é maior que a disponível
      if (quantity > availableQuantity || availableQuantity <= 0) {
        throw Exception('Quantidade indisponível');
      }

      // Verificar se o produto já está no carrinho

      var index = list.indexWhere((element) =>
          element.product.id == product.id &&
          element.pharmacy.id == pharmacy.id);

      if (index >= 0) {
        list[index].quantity += quantity;
      } else {
        list.add(new CartItem(
            product: product, pharmacy: pharmacy, quantity: quantity));
      }

      value.setString('cart', jsonEncode(list.map((e) => e.toJson()).toList()));
    });
  }
}

class CartItem {
  final ProductModels product;
  final PharmacyModels pharmacy;
  int quantity;

  CartItem({
    required this.product,
    required this.pharmacy,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'pharmacy': pharmacy.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModels.fromJson(json['product']),
      pharmacy: PharmacyModels.fromJson(json['pharmacy']),
      quantity: json['quantity'],
    );
  }

  @override
  String toString() {
    return 'CartItem{product: $product, pharmacy: $pharmacy, quantity: $quantity}';
  }
}
