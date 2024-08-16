import 'package:gohealth/api/models/product_models.dart';

abstract class IProduct {
  Future<ProductModels> getbyId(int id) async {
    throw UnimplementedError();
  }

  Future<ProductModels> getbyName(String name) async {
    throw UnimplementedError();
  }

  Future<List<ProductModels>> getAll() async {
    throw UnimplementedError();
  }
}
