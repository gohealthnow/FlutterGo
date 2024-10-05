import 'package:gohealth/api/interfaces/pharmacy_to_product.dart';
import 'package:gohealth/api/services/http_client.dart';

class PharmacyUserRepository implements IPharmacyStockItem {
  late HttpClient stockItemHttpClient;

  PharmacyUserRepository() {
    stockItemHttpClient = HttpClient();
  }

  getAvailableQuantity(int pharmacy, int product) async {
    var response =
        await stockItemHttpClient.client.get('/stock/$pharmacy/$product');

    if (response.statusCode == 200) {
      var data = response.data;
      return data['availableQuantity']['quantity'];
    } else {
      return 0;
    }
  }
}
