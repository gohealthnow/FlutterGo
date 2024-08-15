import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/interfaces/prodcut_interface.dart';
import 'package:gohealth/api/models/product_models.dart';

class ProductRepository implements IProduct {
  late Dio client;

  ProductRepository() {
    client = Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000',
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  @override
  Future<ProductModels> getbyId(int id) async {
    var response = await client.get('/product/$id');

    ProductModels model = ProductModels.fromJson(response.data);

    return model;
  }

  @override
  Future<ProductModels> getbyName(String name) async {
    var response = await client.get('/product/$name');

    ProductModels model = ProductModels.fromJson(response.data);

    return model;
  }

  @override
  Future<ProductModels> getAll() async {
    var response = await client.get('/product');

    ProductModels model = ProductModels.fromJson(response.data);

    return model;
  }
}
