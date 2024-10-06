import 'package:gohealth/api/interfaces/product_interface.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/pharmacy_to_product_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/services/http_client.dart';

class ProductRepository implements IProduct {
  late HttpClient repositoryHttpClient;

  ProductRepository() {
    repositoryHttpClient = HttpClient();
  }

  @override
  Future<ProductModels> getbyId(int id) async {
    var response = await repositoryHttpClient.client.post('/product/$id');

    ProductModels model = ProductModels.fromJson(response.data["product"]);

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

  Future<List<ProductModels>> getProductsReserveList(int id) async {
    var response = await repositoryHttpClient.client.get('/product/stock/$id');

    List<ProductModels> model = [];

    for (var item in response.data['products']) {
      if (item['productId'] != null) {
        var productIdentifier = item['productId'];
        var product = await getbyId(productIdentifier);
        print(product.toString());
        model.add(product);
      }
    }

    return model;
  }

  Future<List<PharmacyStockItem>> getQuantity(
      int productId, int pharmacyId) async {
    var response = await repositoryHttpClient.client
        .get('/product/stock/$productId/$pharmacyId');

    List<PharmacyStockItem> model = [];

    for (var item in response.data['products']) {
      model.add(PharmacyStockItem.fromJson(item));
    }

    return model;
  }

  Future<List<ProductModels>> getProducts(String searchText) async {
    var response =
        await repositoryHttpClient.client.post('/product/name/$searchText');

    List<ProductModels> model = [];

    for (var item in response.data['products']) {
      model.add(ProductModels.fromJson(item));
    }

    return model;
  }

  Future<bool> createProduct(ProductModels product) async {
    var response =
        await repositoryHttpClient.client.post('/product/create', data: {
      "name": product.name,
      "price": product.price,
    });

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> updateStock(
      {required ProductModels product,
      required PharmacyModels pharmacy,
      required int quantity}) async {
    var response = await repositoryHttpClient.client
        .put('/product/update/stock/${product.id}/${pharmacy.id}', data: {
      "quantity": quantity,
    });

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
