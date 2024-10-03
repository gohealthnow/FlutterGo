import 'package:gohealth/api/interfaces/pharmacy_to_product.dart';
import 'package:gohealth/api/models/pharmacy_to_product_model.dart';
import 'package:gohealth/api/services/http_client.dart';

class PharmacyUserRepository implements IPharmacyStockItem {
  late HttpClient stockItemHttpClient;

  PharmacyUserRepository() {
    stockItemHttpClient = HttpClient();
  }

  Future<List<PharmacyStockItem>> getAvailableQuantity(
      int pharmacy, int product) async {
    var response =
        await stockItemHttpClient.client.get('/stock/$pharmacy/$product');

    List<PharmacyStockItem> model = [];

    if (response.statusCode == 200) {
      for (var item in response.data['pharmacyProduct']) {
        model.add(PharmacyStockItem.fromJson(item));
      }
    }

    return model;
  }
}
