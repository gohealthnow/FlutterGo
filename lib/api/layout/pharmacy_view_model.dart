import 'package:flutter/foundation.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';

class PharmacyViewModel extends ValueNotifier<PharmacyModels> {
  late final PharmacyRepository repository;

  PharmacyViewModel(this.repository) : super(PharmacyModels());

  final pharmacyModels = ValueNotifier<PharmacyModels>(PharmacyModels());

  Future<List<PharmacyModels>> loadPharmacies() async {
    List<PharmacyModels> model = await repository.getAll();
    if (kDebugMode) {
      print(model.toString());
    }
    return model;
  }

  getPharmacyById(int query) async {
    pharmacyModels.value = await repository.getPharmacyById(query);
  }

  void updatePharmacyData(pharmacyData) {}
}
