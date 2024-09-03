import 'package:gohealth/api/interfaces/pharmacy_interface.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/services/http_client.dart';

class PharmacyRepository implements IPharmacy {
  late HttpClient repositoryHttpClient;

  PharmacyRepository() {
    repositoryHttpClient = HttpClient();
  }

  @override
  Future<PharmacyModels> getPharmacyById(int id) async {
    var response = await repositoryHttpClient.client.get('/pharmacy/$id');

    PharmacyModels model = PharmacyModels.fromJson(response.data);

    return model;
  }

  @override
  Future<List<PharmacyModels>> getAll() async {
    var response = await repositoryHttpClient.client.get('/pharmacy');

    List<PharmacyModels> model = [];

    if (response.data['pharmacy'] is List) {
      for (var item in response.data['pharmacy']) {
        model.add(PharmacyModels.fromJson(item));
      }
      return model;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
