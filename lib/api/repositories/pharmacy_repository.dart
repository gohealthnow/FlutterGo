import 'package:gohealth/api/interfaces/pharmacy_interface.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/pharmacy_to_product_model.dart';
import 'package:gohealth/api/services/http_client.dart';

class PharmacyRepository implements IPharmacy {
  late HttpClient repositoryHttpClient;

  PharmacyRepository() {
    repositoryHttpClient = HttpClient();
  }

  @override
  Future<PharmacyModels> getPharmacyById(int id) async {
    var response = await repositoryHttpClient.client.get('/pharmacy/$id');

    PharmacyModels model = PharmacyModels.fromJson(response.data["pharmacy"]);

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

  Future<bool> createPharmacy(
      {required String name,
      required String image,
      required String cep,
      required String email,
      required String phone}) async {
    var response =
        await repositoryHttpClient.client.post('/pharmacy/create', data: {
      'name': name,
      if (image.isNotEmpty) 'imageurl': image,
      'cep': cep,
      'phone': phone,
      'email': email,
    });

    print(response.data);

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<PharmacyModels>> getPharmacyByName(String text) async {
    var response =
        await repositoryHttpClient.client.get('/pharmacy/search/$text');

    List<PharmacyModels> model = [];

    PharmacyStockItem pharmacyStockItem = PharmacyStockItem.fromJson(response.data);

    if (response.data['pharmacy'] is List) {
      if (response.data['PharmacyProduct'] != null) {
        pharmacyStockItem = PharmacyStockItem.fromJson(response.data['pharmacy']['PharmacyProduct']);
      }
      for (var item in response.data['pharmacy']) {
        model.add(PharmacyModels.fromJson(item));
      }
      return model;
    } else {
      throw Exception('Failed to load products');
    }
  }

}
