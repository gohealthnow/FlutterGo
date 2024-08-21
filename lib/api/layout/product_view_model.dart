import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/api/repositories/user_repository.dart';

class ProductsViewModel extends ValueNotifier<ProductModels> {
  final ProductRepository repository;

  ProductsViewModel(this.repository) : super(ProductModels());

  final productModels = ValueNotifier<ProductModels>(ProductModels());

  loadProducts() async {
    List<ProductModels> model = await repository.getAll();
    for (var item in model) {
      productModels.value = item;
    }
    return model;
  }

  searchProducts(String query) async {
    productModels.value = await repository.getbyName(query);
  }

  addProductInUser(ProductModels product, int user) async {
    UserRepository().linkProductinUser(product, user);
  }
}