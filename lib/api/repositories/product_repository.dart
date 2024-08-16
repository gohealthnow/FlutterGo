import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/interfaces/product_interface.dart';
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
    var response = await client.post('/product/name/$name');

    ProductModels model = ProductModels.fromJson(response.data);

    return model;
  }

  @override
  Future<List<ProductModels>> getAll() async {
    var response = await client.get('/product');

    List<ProductModels> model = [];

    if (response.data['products'] is List) {
      for (var item in response.data['products']) {
        model.add(ProductModels.fromJson(item));
      }
    return model;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
