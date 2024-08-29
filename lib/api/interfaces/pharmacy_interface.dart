import 'package:gohealth/api/models/pharmacy_model.dart';

abstract class IPharmacy {
  Future<PharmacyModels> getPharmacyById(int id) async {
    throw UnimplementedError();
  }

  Future<List<PharmacyModels>> getAll() async {
    throw UnimplementedError();
  }
}
