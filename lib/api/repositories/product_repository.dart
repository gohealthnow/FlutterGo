import 'package:gohealth/api/interfaces/product_interface.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/services/http_client.dart';

class ProductRepository implements IProduct {

  late HttpClient repositoryHttpClient;

  ProductRepository() {
    repositoryHttpClient = HttpClient();
  }

  @override
  Future<ProductModels> getbyId(int id) async {
    var response = await repositoryHttpClient.client.get('/product/$id');

    ProductModels model = ProductModels.fromJson(response.data);

    return model;
  }

  @override
  Future<ProductModels> getbyName(String name) async {
    var response =
        await repositoryHttpClient.client.post('/product/name/$name');

    ProductModels model = ProductModels.fromJson(response.data);

    return model;
  }

  @override
  Future<List<ProductModels>> getAll() async {
    var response = await repositoryHttpClient.client.get('/product');

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
